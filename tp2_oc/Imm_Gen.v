  
module Imm_Gen(
 instruction, imm_data
);
input wire [31:0]instruction;
 output reg  [63:0]imm_data;

wire [51:0] complement1 = 52'b1111111111111111111111111111111111111111111111111111;
wire [51:0] complement0 = 52'b0000000000000000000000000000000000000000000000000000;
wire [11:0] data1; //ld
wire [11:0] data2; //sd
wire [11:0] data3; //beq
wire [1:0] mode;   //sinal de controle 

assign data1 = instruction[31:20]; //se for 1 vai ser load
assign data2[4:0] = instruction[11:7]; 
assign data2[11:5] = instruction[31:25];
assign data3[3:0] = instruction[11:8];
assign data3[9:4] = instruction[30:25];
assign data3[10] = instruction[7];
assign data3[11] = instruction[31];
assign mode = instruction[6:5];

always@(*)
begin
if (mode == 2'b00)begin
    if (instruction[31]) begin
        imm_data[11:0] = data1[11:0];
        imm_data[63:12] = complement1;
    end
    else begin
        imm_data[11:0] = data1[11:0];
        imm_data[63:12] = complement0;
    end
end

else if (mode == 2'b01) begin
      if (instruction[31]) begin
        imm_data[11:0] = data2[11:0];
        imm_data[63:12] = complement1;
    end
    else begin
        imm_data[11:0] = data2[11:0];
        imm_data[63:12] = complement0;
    end
end

else begin
    if (instruction[31]) begin
        imm_data[11:0] = data3[11:0];
        imm_data[63:12] = complement1;
    end
    else begin
        imm_data[11:0] = data3[11:0];
        imm_data[63:12] = complement0;
    end
end


end
endmodule