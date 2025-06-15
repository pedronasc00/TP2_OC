module display (
    input wire CLOCK_50,         
    input wire KEY_STEP_CLK,      
    input wire KEY_RESET,        
    input wire [4:0] SW_REG_SELECT, 

    output wire [6:0] SEG_PC_DIGIT_1,  
    output wire [6:0] SEG_PC_DIGIT_0,  
    output wire [6:0] SEG_REG_DIGIT_1,
    output wire [6:0] SEG_REG_DIGIT_0 
);

    wire debounced_reset_key_active_high; 
    wire debounced_step_key_active_high;  
    
    wire single_pulse_clk_for_processor;   
    wire processor_actual_reset;

    wire [31:0] pc_from_processor_main;         
    wire [31:0] instr_from_processor_main;
    wire [31:0] reg_value_for_display_from_main;


    
    Debouncer reset_debouncer_unit (
        .clk(CLOCK_50),
        .button_in(KEY_RESET), 
        .button_out(debounced_reset_key_active_high)
    );
   
    assign processor_actual_reset = debounced_reset_key_active_high;
	 
    Debouncer step_clk_debouncer_unit (
        .clk(CLOCK_50),
        .button_in(KEY_STEP_CLK), 
        .button_out(debounced_step_key_active_high)
    );

   
    SinglePulse clk_pulse_generator_unit (
        .clk(CLOCK_50),                             
        .trigger_in(debounced_step_key_active_high), 
        .pulse_out(single_pulse_clk_for_processor)
    );


    main riscv_processor_core (
        .clk(single_pulse_clk_for_processor),
        .reset(processor_actual_reset),
        .PC_I(pc_from_processor_main),
        .Instr_I(instr_from_processor_main), 
        .debug_reg_read_addr_in(SW_REG_SELECT),
        .debug_reg_data_out(reg_value_for_display_from_main)
    );

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