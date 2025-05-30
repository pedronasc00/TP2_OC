module ALUc (
    ALUop, Funct, Op
);
    
    input wire [1:0] ALUop;
    input wire [3:0] Funct;
    output reg [3:0] Op;

always @(*) begin
    Op = 4'dx;
    case (ALUop)
        2'b00: begin 
            Op = 4'b0001; 
        end
        2'b01: begin 
            Op = 4'b0000; 
        end
        2'b10: begin 
            case (Funct)
                4'b0000: begin 
                    Op = 4'b0001; 
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
                4'b0110: begin 
                    Op = 4'b0011; 
                end
                default: Op = 4'dx;
            endcase
        end
        2'b11: begin 
            case (Funct[2:0]) 
                3'b000: Op = 4'b0001; 
                3'b111: Op = 4'b0010; 
                3'b110: Op = 4'b0011; 
                
                default: Op = 4'dx;
            endcase
        end
        default: Op = 4'dx;
    endcase
end
endmodule