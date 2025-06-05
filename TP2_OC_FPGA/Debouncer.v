module Debouncer (
    input wire clk,          // Clock rápido da FPGA (ex: CLOCK_50)
    input wire button_in,    // Entrada do botão (ativo baixo)
    output reg button_out    // Saída debounced (ativo alto quando o botão é considerado pressionado)
);

    parameter COUNT_MAX = 19999; // ~1ms com clock de 20MHz, ajuste para CLOCK_50 (~50000 para ~1ms)
                                 // Para CLOCK_50 (50MHz), 50000 * 20ns = 1ms

    reg [15:0] count_reg; // Ajuste a largura se COUNT_MAX for maior
    reg s1_button_in, s2_button_in;
    reg debounced_signal_internal; // Ativo baixo internamente

    initial begin
        button_out = 1'b0; // Inicialmente não pressionado
        debounced_signal_internal = 1'b1; // Inicialmente não pressionado (ativo baixo)
        count_reg = 0;
        s1_button_in = 1'b1;
        s2_button_in = 1'b1;
    end

    always @(posedge clk) begin
        s1_button_in <= button_in;
        s2_button_in <= s1_button_in;

        if (s2_button_in != debounced_signal_internal) begin
            count_reg <= count_reg + 1;
            if (count_reg == COUNT_MAX) begin
                debounced_signal_internal <= s2_button_in;
                count_reg <= 0;
            end
        end else begin
            count_reg <= 0;
        end
        
        // A saída é invertida para ser ativa alta
        button_out <= ~debounced_signal_internal;
    end

endmodule