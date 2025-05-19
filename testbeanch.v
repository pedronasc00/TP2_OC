`timescale 1ns / 1ps

module testbench_riscv;

    reg clk;
    reg reset;

    wire [63:0] tb_pc_output;
    wire [31:0] tb_instruction;
    wire [63:0] tb_reg_x5, tb_reg_x6, tb_reg_x7, tb_reg_x8, tb_reg_x9, tb_reg_x10, tb_reg_x11, tb_reg_x12, tb_reg_x13;

    riscv DUT (
        .clk(clk),
        .reset(reset),
        .PC_Output(tb_pc_output),
        .Instruction(tb_instruction)
    );

    assign tb_reg_x5 = DUT.Reg.Register[5];
    assign tb_reg_x6 = DUT.Reg.Register[6];
    assign tb_reg_x7 = DUT.Reg.Register[7];
    assign tb_reg_x8 = DUT.Reg.Register[8];
    assign tb_reg_x9 = DUT.Reg.Register[9];
    assign tb_reg_x10 = DUT.Reg.Register[10];
    assign tb_reg_x11 = DUT.Reg.Register[11];
    assign tb_reg_x12 = DUT.Reg.Register[12];
    assign tb_reg_x13 = DUT.Reg.Register[13];

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpvars(0, testbeanch);
        $display("Iniciando Testbench RISC-V...");
        reset = 1;
        #20;
        reset = 0;
        $display("Reset liberado. Iniciando execução do programa.");

        #300;

        $display("--- Resultados da Simulação ---");
        $display("PC Final: %h", tb_pc_output);

        $display("Registradores:");
        $display("x5  (R5)  = %d (0x%h)", tb_reg_x5, tb_reg_x5);
        $display("x6  (R6)  = %d (0x%h)", tb_reg_x6, tb_reg_x6);
        $display("x7  (R7)  = %d (0x%h)", tb_reg_x7, tb_reg_x7);
        $display("x8  (R8)  = %d (0x%h)", tb_reg_x8, tb_reg_x8);
        $display("x9  (R9)  = %d (0x%h)", tb_reg_x9, tb_reg_x9);
        $display("x10 (R10) = %d (0x%h)", tb_reg_x10, tb_reg_x10);
        $display("x11 (R11) = %d (0x%h)", tb_reg_x11, tb_reg_x11);
        $display("x12 (R12) = %d (0x%h)", tb_reg_x12, tb_reg_x12);
        $display("x13 (R13) = %d (0x%h)", tb_reg_x13, tb_reg_x13);

        $display("Verifique o log da Data_Memory para o valor no endereço 8 (deve ser 5).");

        $display("--- Fim da Simulação ---");
        $finish;
    end

endmodule