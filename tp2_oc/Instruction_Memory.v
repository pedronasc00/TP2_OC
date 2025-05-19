  
module Instruction_Memory(
     Inst_Address, Instruction
);
input wire [63:0]Inst_Address;
    output reg [31:0]Instruction;

reg [63:0]Mem[31:0];

initial begin
        $readmemb("instrucao.txt",Mem);
end
  always @ (Inst_Address) begin
        Instruction = Mem[Inst_Address>>2];
    end

endmodule 