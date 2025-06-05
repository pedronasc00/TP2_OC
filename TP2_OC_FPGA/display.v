module display (
    input wire CLOCK_50,         
    input wire KEY_STEP_CLK,     // Botão para avançar uma instrução 
    input wire KEY_RESET,        // Botão para resetar o processador
    input wire [4:0] SW_REG_SELECT, // 5 Chaves para selecionar o registrador 

    output wire [6:0] SEG_PC_DIGIT_1,  // Display de 7 segmentos para PC (dígito mais significativo)
    output wire [6:0] SEG_PC_DIGIT_0,  // Display de 7 segmentos para PC (dígito menos significativo)
    output wire [6:0] SEG_REG_DIGIT_1, // Display de 7 segmentos para valor do Registrador (dígito mais significativo)
    output wire [6:0] SEG_REG_DIGIT_0  // Display de 7 segmentos para valor do Registrador (dígito menos significativo)
);

    // --- Sinais Internos ---
    wire debounced_reset_key_active_high;    // Saída do debouncer do reset (ativo alto)
    wire debounced_step_key_active_high;     // Saída do debouncer do step (ativo alto)
    
    wire single_pulse_clk_for_processor;   // Clock de pulso único para o 'main'
    wire processor_actual_reset;           // Sinal de reset para o 'main' (geralmente ativo alto)

    wire [31:0] pc_from_processor_main;         // Saída PC_I do seu módulo 'main'
    wire [31:0] instr_from_processor_main;      // Saída Instr_I do seu módulo 'main' (não usado para display aqui, mas é uma saída)
    wire [31:0] reg_value_for_display_from_main; // Saída debug_reg_data_out do seu módulo 'main'

    // --- Lógica de Debounce e Pulso ---

    
    Debouncer reset_debouncer_unit (
        .clk(CLOCK_50),
        .button_in(KEY_RESET), // Botão físico (ativo baixo)
        .button_out(debounced_reset_key_active_high) // Saída debounced (ativo alto)
    );
   
    assign processor_actual_reset = debounced_reset_key_active_high;
	 
    Debouncer step_clk_debouncer_unit (
        .clk(CLOCK_50),
        .button_in(KEY_STEP_CLK), // Botão físico (ativo baixo)
        .button_out(debounced_step_key_active_high) // Saída debounced (ativo alto)
    );

   
    SinglePulse clk_pulse_generator_unit (
        .clk(CLOCK_50),                             // Clock rápido da FPGA
        .trigger_in(debounced_step_key_active_high),// Gatilho do botão de step (após debounce, ativo alto)
        .pulse_out(single_pulse_clk_for_processor)  // Clock de pulso único para o 'main'
    );


    // --- Instanciação do Seu Processador RISC-V (módulo 'main') ---
    main riscv_processor_core (
        .clk(single_pulse_clk_for_processor),
        .reset(processor_actual_reset),
        
        .PC_I(pc_from_processor_main), // Saída do PC do seu processador
        .Instr_I(instr_from_processor_main), // Saída da Instrução (não usada diretamente nos displays aqui)

        .debug_reg_read_addr_in(SW_REG_SELECT),
        .debug_reg_data_out(reg_value_for_display_from_main)
    );

    // --- Lógica de Exibição para PC (Ex: 2 dígitos hexadecimais, PC_I[7:0]) ---
    wire [3:0] pc_hex_digit_1_val = pc_from_processor_main[7:4];
    wire [3:0] pc_hex_digit_0_val = pc_from_processor_main[3:0];

    HexTo7Seg pc_display_1 (
        .hex_in(pc_hex_digit_1_val),
        .segments_out(SEG_PC_DIGIT_1)
    );
    HexTo7Seg pc_display_0 (
        .hex_in(pc_hex_digit_0_val),
        .segments_out(SEG_PC_DIGIT_0)
    );

    // --- Lógica de Exibição para Valor do Registrador (Ex: 2 dígitos hexadecimais, REG_VAL[7:0]) ---
    wire [3:0] reg_hex_digit_1_val = reg_value_for_display_from_main[7:4];
    wire [3:0] reg_hex_digit_0_val = reg_value_for_display_from_main[3:0];

    HexTo7Seg reg_display_1 (
        .hex_in(reg_hex_digit_1_val),
        .segments_out(SEG_REG_DIGIT_1)
    );
    HexTo7Seg reg_display_0 (
        .hex_in(reg_hex_digit_0_val),
        .segments_out(SEG_REG_DIGIT_0)
    );

endmodule