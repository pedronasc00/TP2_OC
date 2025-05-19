module Registers(
    clk, 
     reset, 
     RegWrite,
     WriteData, 
     RS1, 
     RS2, 
     WriteRegister,
     ReadData1, 
     ReadData2
);

	input wire clk;
    input wire reset; 
    input wire RegWrite;
    input wire [63:0]WriteData; 
    input wire [4:0]RS1; 
    input wire [4:0]RS2; 
    input wire [4:0]WriteRegister;
    output reg [63:0]ReadData1; 
    output reg [63:0]ReadData2;

reg [63:0] Register [31:0];
integer i;

initial
begin
	for(i=0; i < 32; i = i + 1)
	begin
		Register[i] <= 0;
	end
end

always@(posedge clk)begin
	

    if (RegWrite == 1)begin
		Register[WriteRegister] = WriteData;
		
	end
end
always@(*)begin
	

	if(reset)
	begin
		ReadData1 = 64'd0;
		ReadData2 = 64'd0;
	end
	else
	begin
		ReadData1 = Register[RS1];
		ReadData2 = Register[RS2];
	end	
end	

endmodule