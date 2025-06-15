module Debouncer (
    input wire clk,        
    input wire button_in,  
    output reg button_out 
);

    parameter COUNT_MAX = 19999;

    reg [15:0] count_reg;
    reg s1_button_in, s2_button_in;
    reg debounced_signal_internal;

    initial begin
        button_out = 1'b0;
        debounced_signal_internal = 1'b1;
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
        
        button_out <= ~debounced_signal_internal;
    end

endmodule