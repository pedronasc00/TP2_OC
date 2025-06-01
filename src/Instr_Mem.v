module Instr_Mem (
    Ender_Instr, Instrucao
);

    input wire [31:0] Ender_Instr;
    output reg [31:0] Instrucao;
    
    reg [31:0] Mem [0:31];

initial begin
    $readmemb("src/instr_gp22.txt", Mem);
end

always @(Ender_Instr) begin
    Instrucao = Mem[Ender_Instr >> 2];
end

endmodule