`timescale 1ns / 100ps
`include "riscv.v"

module testbench();
reg clk, reset;
wire [63:0]Result, PC_Output;
wire [31:0]Instruction;

riscv tb( 
    .clk(clk), .reset(reset), .Result(Result), .Instruction(Instruction), .PC_Output(PC_Output)
);

/*riscv RP1(
	.clk(clk),
	.reset(reset)
);*/
	
initial
begin

	$dumpfile("riscv.vcd");
    $dumpvars(0, testbench);
	$display("teste");
    clk = 0;
    #30000 $finish;

	/*clk = 1'b0;
	reset = 1'b1;
	
	#10 reset = 1'b0;*/
end
	
always begin
	#10 clk = ~ clk;
	
end
	
endmodule