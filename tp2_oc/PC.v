module PC(
	 PC_In, clk, reset, PC_Out
);
input wire [63:0] PC_In;
	input wire clk,reset;
	output reg[63:0] PC_Out;
initial begin
  PC_Out = 0;
end
	always@(posedge clk)
	begin
		if(reset)
			PC_Out <= 0;
		else
			PC_Out <= PC_In;
	end
endmodule

module Soma4(
  input wire [63:0]PC_In,
  output reg [63:0]Sum
);

  always @ (*) begin
    Sum <= PC_In + 64'b0000000000000000000000000000000000000000000000000000000000000100;
  end
endmodule


module PC_Next(
  input wire [63:0] Number1, Number2,
  input wire branchAnd, clk,
  output reg [63:0] PC_Next
);

  always @ (posedge clk) begin
    if(branchAnd) begin
      PC_Next <= Number1 + Number2;
    end
    else if(~branchAnd) begin
      PC_Next <= Number1 + 4;
    end
  end
endmodule
