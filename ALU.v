module ALU (
    num1, num2, ALUop, S, zero
);
    input wire [31:0] num1;
    input wire [31:0] num2;
    input wire [3:0] ALUop;
    output reg [31:0] S;
    output reg zero;

always @(*) begin
    S = 32'dx;
    case (ALUop)
        4'b0000:
            S = num1 - num2;
        4'b0001:
            S = num1 + num2;
        4'b0010:
            S = num1 & num2;
        4'b0011:
            S = num1 | num2;
        4'b1100:
            S = num1 >> num2[5:0];
        default: 
            S = 32'dx;
    endcase
    zero = (S == 32'b0);
end
    
endmodule