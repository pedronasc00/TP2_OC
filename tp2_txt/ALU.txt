module ALU(
	 Number1, Number2, ALUOp, Result, Zero
);
	input wire [63:0] Number1;
	input wire [63:0] Number2;
	input wire [3:0] ALUOp;
	output reg [63:0] Result;
	output reg Zero;
		
always @(*)
begin
	case (ALUOp)
			4'b0000:  //
				Result = Number1 & Number2;
			4'b0001: 
				Result = Number1 | Number2;
			4'b0010: 
				Result = Number1 + Number2;
			4'b0110: 
				Result = Number1 - Number2;
			4'b1100: 
				Result = ~(Number1 | Number2);

	endcase
end
endmodule 