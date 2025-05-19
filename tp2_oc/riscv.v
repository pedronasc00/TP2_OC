`include "adder.v" 
`include "ALU_Control.v"
`include "ALU.v"
`include "branch.v"
`include "Control.v"
`include "Data_Memory.v"
`include "Imm_Gen.v"
`include "Instruction_Memory.v"
`include "mux.v"
`include "registers.v"
`include "PC.v"

module riscv(
     clk, reset, Result, Instruction, PC_Output
);
input wire clk, reset;
output wire [63:0]PC_Output; 
wire[63:0]PC_Input; // PC
output wire [31:0]Instruction; //Instruction memory 
wire [63:0]ReadData1, ReadData2, WriteData2; //Registers
output wire [63:0]Result; //ALU 
wire [6:0]opcode; 
wire [4:0]WriteRegister; 
wire [2:0]funct3; 
wire [6:0]funct7; //Instruction
wire [63:0]mux1, mux2, mux3; 
wire [63:0]Read_Data; //Data memory
wire [63:0]Imm_Gen; //Extension
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, Zero, branch_out; //Controler
wire [1:0]ALUOp; wire [3:0]Operation; //ALU control
wire [63:0]out1; //adder1
wire [63:0]out2; //adder2
wire [63:0]sum, Num1, Num2; //PC

 PC Program_Counter( 
	.PC_In(mux1),
	.clk(clk),
	.reset(reset),
	.PC_Out(PC_Output)
);

Soma4 Program_Counter1(
   .PC_In(PC_Input),
   .Sum(sum)
);

PC_Next Program_Counter2( 
	.Number1(Num1),
	.Number2(Num2),
	.clk(clk),
	.branchAnd(Branch),
	.PC_Next(sum)
);

ALU ALU_Result( 
	.Number1(ReadData1),
	.Number2(mux2),
	.ALUOp(Operation),
	.Result(Result),
	.Zero(Zero)
);

Registers Reg(
    .clk(clk), 
	.reset(reset), 
	.RegWrite(RegWrite),
    .WriteData(mux3), 
	.RS1(Instruction[19:15]), 
	.RS2(Instruction[24:20]), 
	.WriteRegister(Instruction[11:7]),
    .ReadData1(ReadData1), 
	.ReadData2(ReadData2)
);

branch Branch_Control(
	.Branch(Branch),  
	.Zero(Zero),
	.branch_out(branch_out)
);

mux mux_PC( //mux branch
    .Number1(out1), 
	.Number2(out2), 
	.sel(branch_out), 
    .data_out(mux1)
);

mux mux_ALU(
    .Number1(ReadData2), 
	.Number2(Imm_Gen), 
	.sel(ALUSrc),
    .data_out(mux2)
);

mux mux_exit( //mux datamemory
    .Number1(Read_Data), 
	.Number2(Result), 
	.sel(MemtoReg),
    .data_out(mux3)
);

Instruction_Memory IM(
	.Inst_Address(PC_Output),
	.Instruction(Instruction)
);

Data_Memory DM(
	.Mem_Addr(Result), 
	.Write_Data(ReadData2),
	.clk(clk), 
	.MemWrite(MemWrite), 
	.MemRead(MemRead),
	.Read_Data(Read_Data),
	.reset(reset)
);

Imm_Gen Extension(
    .instruction(Instruction),
    .imm_data(Imm_Gen)
);

Control Controler(
	.Opcode(opcode),
	.Branch(Branch), 
	.MemRead(MemRead), 
	.MemtoReg(MemtoReg), 
	.MemWrite(MemWrite), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite),
	.ALUOp(ALUOp)
);

ALU_Control AC(
	.ALUOp(ALUOp),
	.Funct({Instruction[30], Instruction[14:12]}), 
	.Operation(Operation)
);

adder A1(
    .a(PC_Output), 
	.b(64'd4),
    .out(out1) 
);

adder A2(
    .a(PC_Output), 
	.b(Imm_Gen<<1), 
    .out(out2) 
);
endmodule 


