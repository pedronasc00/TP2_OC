module Mux (
    num1, num2, sel, data_S
);

    input wire [31:0] num1;
    input wire [31:0] num2;
    input wire sel;
    output reg [31:0] data_S;

always @(*) begin
    if (sel == 1'b0) begin
        data_S <= num1;
    end
    else begin
        data_S <= num2;
    end
end
  
endmodule