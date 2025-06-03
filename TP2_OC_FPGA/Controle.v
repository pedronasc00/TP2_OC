module Controle(
	Opcode, Branch, MemRead, MemtoReg, 
 	MemWrite, ALUSrc, RegWrite, ALUOp
);

input wire [6:0] Opcode;
output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0] ALUOp;

localparam TYPE_R = 7'b0110011;
localparam TYPE_S = 7'b0100011;
localparam TYPE_B = 7'b1100011;
localparam I_LOAD = 7'b0000011;
localparam I_ARITH = 7'b0010011;

always@(*) begin
	Branch = 1'b0;
    MemRead = 1'b0;
    MemtoReg = 1'b0; 
    MemWrite = 1'b0;
    ALUSrc = 1'b0;
    RegWrite = 1'b0;
    ALUOp = 2'bxx;

	case (Opcode)
		TYPE_R: begin
    		Branch = 1'b0;
    		MemRead = 1'b0;
    		MemtoReg = 1'b0; 
    		MemWrite = 1'b0;
    		ALUSrc = 1'b0;   
    		RegWrite = 1'b1; 
    		ALUOp = 2'b10;
		end
		I_LOAD: begin
			Branch = 1'b0;
			MemRead = 1'b1;
			MemtoReg = 1'b1;
			MemWrite = 1'b0;
		    ALUSrc = 1'b1;
		    RegWrite = 1'b1;
		    ALUOp = 2'b00;
		end
		TYPE_S: begin
			Branch = 1'b0;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			MemWrite = 1'b1;
		    ALUSrc = 1'b1;
		    RegWrite = 1'b0;
		    ALUOp = 2'b00;
		end
		TYPE_B: begin
			Branch = 1'b1;
			MemRead = 1'b0;
			MemtoReg = 1'bx;
			MemWrite = 1'b0;
		    ALUSrc = 1'b0;
		    RegWrite = 1'b0;
		    ALUOp = 2'b01;
		end
		I_ARITH: begin
			Branch = 1'b0;
			MemRead = 1'b0;
        	MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
			ALUOp = 2'b11;
		end
	endcase
end
endmodule