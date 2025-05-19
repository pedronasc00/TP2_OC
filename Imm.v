module Imm (
    Instr, imm_data
);

    input wire [31:0]Instr;
    output reg [31:0]imm_data;

    localparam I_LOAD = 7'b0000011;
    localparam I_ARITH = 7'b0010011;
    localparam S_TYPE = 7'b0100011;
    localparam B_TYPE = 7'b1100011;

    wire [6:0] Opcode = Instr[6:0];

always @(*) begin
    imm_data = 32'dx;
    case(Opcode)
        I_LOAD, I_ARITH: begin
            imm_data = {{20{Instr[31]}}, Instr[31:20]};
        end
        S_TYPE:  begin
            imm_data = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
        end
        B_TYPE: begin
            imm_data = {{19{Instr[31]}}, Instr[31], Instr[7], Instr[30:25], Instr[11:8], 1'b0};
        end
        default: imm_data = 32'dx;
    endcase
end
endmodule