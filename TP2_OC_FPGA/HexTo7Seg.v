module HexTo7Seg (
    input [3:0] hex_in,
    output reg [6:0] segments_out
);
    always @(*) begin
        case (hex_in)
            4'h0: segments_out = 7'b1000000;
            4'h1: segments_out = 7'b1111001;
            4'h2: segments_out = 7'b0100100;
            4'h3: segments_out = 7'b0110000;
            4'h4: segments_out = 7'b0011001;
            4'h5: segments_out = 7'b0010010;
            4'h6: segments_out = 7'b0000010;
            4'h7: segments_out = 7'b1111000;
            4'h8: segments_out = 7'b0000000;
            4'h9: segments_out = 7'b0010000;
            4'hA: segments_out = 7'b0001000;
            4'hB: segments_out = 7'b0000011;
            4'hC: segments_out = 7'b1000110;
            4'hD: segments_out = 7'b0100001;
            4'hE: segments_out = 7'b0000110;
            4'hF: segments_out = 7'b0001110;
            default: segments_out = 7'b1111111;
        endcase
    end
endmodule