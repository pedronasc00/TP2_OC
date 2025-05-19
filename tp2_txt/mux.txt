module mux(
     Number1, Number2, sel, data_out
);
input wire [63:0]Number1;
    input wire [63:0]Number2; 
	input wire sel;
    output reg [63:0]data_out;
always@(*) begin
    

if (sel==1'b0)begin
    data_out <= Number1;
end
else begin
    data_out <= Number2;
end
end
//assign data_out = sel? Number1 : Number2;   //sel = sinal de controle sempre 1 bit

endmodule
