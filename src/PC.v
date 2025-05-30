module PC(
	clk, reset, PC_E, PC_S
);

	input wire clk,reset; 
    input wire [31:0] PC_E;
	output reg[31:0]PC_S;

initial begin
  PC_S = 32'b0;
end

always@(posedge clk) begin
	if(reset)
		PC_S <= 32'b0;
	else
		PC_S <= PC_E;
end
endmodule