module adder(
    a, b, out 
);
    input wire [63:0]a, b;
    output reg [63:0]out;

always@(*) begin
	out = a + b;
end
endmodule