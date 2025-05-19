module branch(
   Branch, Zero, branch_out
);
  input wire Branch, Zero;
  output reg branch_out;

always@(*)
begin
case(Branch)
	1'b1:
				if(Zero == 1'b0) 
				begin
					branch_out = 1'b0;
				end
				else
				begin
					branch_out = 1'b1;
				end	
	1'b0:
	begin
		branch_out = 1'b0;	
	end
endcase
end
endmodule


