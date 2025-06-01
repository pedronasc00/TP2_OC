module Registradores (
    clk, reset, RegWrite,
    WriteData, rs1, rs2, 
    WriteRegister, ReadData1, ReadData2
);

    input wire clk;
    input wire reset; 
    input wire RegWrite;
    input wire [31:0] WriteData; 
    input wire [4:0] rs1; 
    input wire [4:0] rs2; 
    input wire [4:0] WriteRegister;
    output reg [31:0] ReadData1; 
    output reg [31:0] ReadData2;

    reg [31:0] Registrador [0:31];
    integer i;

initial begin
    for (i = 0; i < 32; i = i + 1) begin
        Registrador[i] = 32'b0;
    end
end

always @(posedge clk) begin
    if (reset) begin
        for(i = 0; i < 32; i = i + 1) begin
		    Registrador[i] <= 32'b0;
	    end
    end 
    else if (RegWrite == 1'b1 && WriteRegister != 5'b00000) begin
		Registrador[WriteRegister] <= WriteData;
	end
end

always@(*) begin
	if (rs1 == 5'b00000) begin
		ReadData1 = 32'b0; 
	end 
    else begin
		ReadData1 = Registrador[rs1];
	end

    if (rs2 == 5'b00000) begin
		ReadData2 = 32'b0;
	end 
    else begin
		ReadData2 = Registrador[rs2];
	end
end
    
endmodule