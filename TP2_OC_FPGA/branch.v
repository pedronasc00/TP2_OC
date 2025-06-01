module branch(
   Branch, zero, Branch_S
);
  input wire Branch, zero;
  output reg Branch_S;

always@(*) begin
    if (Branch == 1'b1 && zero == 1'b1) begin
      Branch_S = 1'b1;
    end 
    else begin
      Branch_S = 1'b0;
    end
end
endmodule

