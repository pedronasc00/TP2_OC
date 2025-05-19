module ALUc (
    ALUop, Funct, Op
);
    
    input wire [1:0] ALUOp;
    input wire [3:0] Funct;
    output reg [3:0] Op;

always @(*) begin
    Op = 4'dx;
    case (ALUOp)
        2'b00: begin // ld, sb
            Op = 4'b0001; //ADD
        end
        2'b01: begin //beq
            Op = 4'b0000; //SUB
        end
        2'b10: begin
            case (Funct)
                4'b0000: begin
                    Op = 4'0001;
                end
               4'b1000: begin
				    Op = 4'b0000;
			    end
			    4'b0111: begin
				    Op = 4'b0010;
			    end
                4'b0101: begin
                    Op = 4'b1100;
                end
                default: Op = 4'dx;
            endcase
        end
        2'b11: begin
            Op = 4'b0011;
        end
        default: Op = 4'dx;
    endcase
end
endmodule