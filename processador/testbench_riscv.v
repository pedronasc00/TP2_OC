`timescale 1ns/1ps

`include "processador/main.v"

module testbench_riscv;

    reg clk;
    reg reset;
    wire [31:0] PC_I;
    wire [31:0] Instr_I;

    parameter CLK_PERIOD = 10;
    parameter SIMULATION_CYCLES = 32;

    main dut (
        .clk(clk),
        .reset(reset),
        .PC_I(PC_I),
        .Instr_I(Instr_I)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    integer i;
    initial begin
        reset = 1'b1;
        #(2 * CLK_PERIOD);

        reset = 1'b0;
        $display("[%0t ns] Reset released.", $time);
        
        repeat (SIMULATION_CYCLES) @(posedge clk);
        
        $display("\n=========================================================");
        $display("\n----- Valores Finais - Registradores -----\n");
        for (i = 0; i < 32; i = i + 1) begin 
            $display("Registrador [%2d]: %8d", i, $signed(dut.Reg_File.Registrador[i]));
        end
        $display("=========================================================");
        $finish;
    end
endmodule