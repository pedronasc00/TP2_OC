module ALU_Control(
	ALUOp, Funct, Operation
);
input wire [1:0]ALUOp;
input wire [3:0]Funct;
output reg [3:0]Operation;

always@ (*)
begin
	case(ALUOp)
		2'b00: //ld,sd
		begin
			Operation = 4'b0010;
		end
		
		2'b01: //Beq
		begin
			Operation = 4'b0110;
		end
		
		2'b10: //R-Type
		begin
		case(Funct)
			4'b0000:
			begin
				Operation = 4'b0010;
			end
			
			4'b1000:
			begin
				Operation = 4'b0110;
			end
			
			4'b0111:
			begin
				Operation = 4'b0000;
			end
			
			4'b0110:
			begin
				Operation = 4'b0001;
			end
		endcase	
		end
	endcase	
end
endmodule
