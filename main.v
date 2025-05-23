`include "somador.v"
`include "ALU.v"
`include "ALUc.v"
`include "Mux.v"
`include "Controle.v"
`include "Data_Mem.v"
`include "PC.v"
`include "Registradores.v"
`include "Imm.v"
`include "branch.v"
`include "Instr_Mem.v"

module main(
	input wire clk,
	input wire reset,
	output wire [31:0] PC_I,
	output wire [31:0] Instr_I
);
// Fios do caminho de dados
wire [31:0] PC_S;
wire [31:0] PC4;
wire [31:0] PC_branch;
wire [31:0] PC_Mux; 
wire [31:0] Instr;    
wire [31:0] Imm;
wire [31:0] ReadData1;
wire [31:0] ReadData2;
wire [31:0] ALUmux; 
wire [31:0] ALUr;   
wire [31:0] DataMem_ReadOut;
wire [31:0] WriteB;   

// Fios de Controle
wire Branch_beq_ctrl; 
wire MemRead_ctrl;    
wire MemReg_ctrl;     
wire MemWrite_ctrl;   
wire ALUctrl_src;     
wire RegWrite_ctrl;   
wire [1:0] ALUop_ctrl; 
wire [3:0] ALUselOp;   
wire ALUzero;
wire Branch_flag;     

// Decodificação de campos da instrução (usando 'Instr' como fonte)
wire [6:0] opcode = Instr[6:0];
wire [4:0] rd = Instr[11:7];
wire [2:0] funct3 = Instr[14:12];
wire [4:0] rs1 = Instr[19:15];
wire [4:0] rs2 = Instr[24:20];
wire [6:0] funct7 = Instr[31:25];

// Saídas de depuração
assign PC_I = PC_S;
assign Instr_I = Instr;

PC Program_Counter (
    .PC_E(PC_Mux), 
    .clk(clk),
    .reset(reset),
    .PC_S(PC_S)
);

somador soma4 (
    .a(PC_S),
    .b(32'd4),
    .soma(PC4) 
);

Instr_Mem Instrucao_Memoria (
    .Ender_Instr(PC_S),
    .Instrucao(Instr)
);

Controle Main_Control (
    .Opcode(opcode),
    .Branch(Branch_beq_ctrl), 
    .MemRead(MemRead_ctrl),     
    .MemtoReg(MemReg_ctrl),   
    .MemWrite(MemWrite_ctrl),   
    .ALUSrc(ALUctrl_src),      
    .RegWrite(RegWrite_ctrl),  
    .ALUOp(ALUop_ctrl)          
);

Registradores Reg_File(
    .clk(clk),
	.reset(reset),
	.RegWrite(RegWrite_ctrl),
    .WriteData(WriteB),
	.rs1(rs1),
	.rs2(rs2),
	.WriteRegister(rd), 
    .ReadData1(ReadData1),
	.ReadData2(ReadData2)
);

Imm Immediate_Generator (
    .Instr(Instr),
    .imm_data(Imm)
);

ALUc Alu_Control_Unit (
    .ALUop(ALUop_ctrl),
    .Funct({funct7[5], funct3}),
    .Op(ALUselOp)
);

Mux Alu_mux_operand2 (
    .num1(ReadData2),
    .num2(Imm),
    .sel(ALUctrl_src), 
    .data_S(ALUmux)
);

ALU Main_ALU (
    .num1(ReadData1),
    .num2(ALUmux),
    .ALUop(ALUselOp),
    .S(ALUr),
    .zero(ALUzero)
);

somador pc_adder_branch (
    .a(PC_S),
    .b(Imm),
    .soma(PC_branch) 
);

branch branch_logic (
    .Branch(Branch_beq_ctrl),
    .zero(ALUzero),
    .Branch_S(Branch_flag)   
);

Data_Mem Data_Mem_Module ( 
    .clk(clk),
    .reset(reset),
    .MemSum(ALUr),
    .WriteData(ReadData2),
    .MemWrite(MemWrite_ctrl),
    .MemRead(MemRead_ctrl),    
    .ReadData(DataMem_ReadOut),
    .Funct3(funct3)
);

Mux writeback_mux (
    .num1(ALUr),
    .num2(DataMem_ReadOut), 
    .sel(MemReg_ctrl),      
    .data_S(WriteB)
);

Mux pc_next_mux (
    .num1(PC4),
    .num2(PC_branch),
    .sel(Branch_flag),
    .data_S(PC_Mux) 
);

endmodule