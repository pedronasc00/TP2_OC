module Data_Mem (
    clk, reset, ReadData, WriteData,
    MemSum, MemWrite, MemRead, Funct3
);

    input wire [31:0] MemSum;
    input wire [31:0] WriteData;
    input wire clk, MemWrite, MemRead, reset;
    input wire [2:0] Funct3;
    output reg [31:0] ReadData;

    reg [31:0] Mem [0:63];
    integer i;

    initial begin
        for (i = 0; i < 64; i = i + 1)
            Mem[i] <= 32'b0;
        Mem[0] <= 32'h0A000000;
    end

    wire [31:0] Palavra_Sum = MemSum & 32'hFFFFFFFC;
    wire [5:0] idPalavra = Palavra_Sum >> 2;
    wire [1:0] bytePalavra = MemSum[1:0];

    reg [31:0] Palavra_lida;
    reg [31:0] Palavra_temp;
    reg [7:0] Byte_Selec;

    always @(*) begin
        Palavra_lida = Mem[idPalavra];

        if (MemRead) begin
            if (Funct3 == 3'b000) begin
                case (bytePalavra)
                    2'b00: Byte_Selec = Palavra_lida[7:0];
                    2'b01: Byte_Selec = Palavra_lida[15:8];
                    2'b10: Byte_Selec = Palavra_lida[23:16];
                    2'b11: Byte_Selec = Palavra_lida[31:24];
                    default: Byte_Selec = 8'hx;
                endcase
                ReadData = {{24{Byte_Selec[7]}}, Byte_Selec};
            end else begin
                ReadData = 32'bx;
            end
        end else begin
            ReadData = 32'bx;
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            ReadData <= 32'b0;
            for (i = 0; i < 64; i = i + 1)
                Mem[i] <= 32'b0;
        end else if (MemWrite && Funct3 == 3'b000) begin
            Palavra_temp = Mem[idPalavra];
            case (bytePalavra)
                2'b00: Palavra_temp[7:0]   = WriteData[7:0];
                2'b01: Palavra_temp[15:8]  = WriteData[7:0];
                2'b10: Palavra_temp[23:16] = WriteData[7:0];
                2'b11: Palavra_temp[31:24] = WriteData[7:0];
            endcase
            Mem[idPalavra] <= Palavra_temp;
        end
    end

endmodule