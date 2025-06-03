module somador (
    a, b, soma
);
    
    input wire [31:0] a, b;
    output reg [31:0] soma;

always@(*) begin
	soma = a + b;
end
endmodule