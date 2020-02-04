`include "sccontrolunit.v"
`include "scregfile.v"
`include "scinstmem.v"
`include "alu.v"
`include "scdatamem.v"
module sccpu(
    input wire clk,
    input wire clrn,
    output wire [31:0] inst,
    output reg [31:0] pc,
    output wire [31:0] aluout,
    output wire [31:0] memout
);
    wire [31:0] p4;
    reg [31:0] new_pc;

    wire [5:0] op;
    wire [5:0] func;
    wire [25:0] addr;
    wire [15:0] imm;
    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;
    wire [4:0] sa;

    assign op   = inst[31:26];
    assign rs   = inst[25:21];
    assign rt   = inst[20:16];
    assign rd   = inst[15:11];
    assign sa   = inst[10:6];
    assign func = inst[5:0];
    assign imm  = inst[15:0];
    assign addr = inst[25:0];

    wire [31:0] imm32;

    wire [31:0] a;
    wire [31:0] b;
    wire [31:0] r;
    wire [31:0] qa;
    wire [31:0] qb;
    wire [31:0] d;
    wire [31:0] do;
    wire [31:0] result;
    wire [4:0] wn;
    wire [4:0] reg_dest;

    wire sext;
    wire regrt;
    wire z;
    wire m2reg;
    wire [1:0] pcsrc;
    wire wmem;
    wire jal;
    wire [3:0] aluc;
    wire shift;
    wire aluimm;
    wire wreg; 

    assign p4 = pc + 4;
    assign imm32 = sext ? { { 16{ imm[15] } }, imm } : { 16'b0, imm };

    assign a = shift ? sa : qa;
    assign b = aluimm ? imm32 : qb;
    assign result = m2reg ? do : r;
    assign reg_dest = regrt ? rt : rd;
    assign wn = reg_dest | {5{jal}};
    assign d = jal ? p4 : result;

    always @(posedge clk) begin
        if (clrn)
            pc <= new_pc;
        else
            pc <= 0;
    end

    always @(*) begin
        case (pcsrc)
            2'b00: new_pc = p4;
            2'b01: new_pc = p4 + (imm32 << 2);
            2'b10: new_pc = qa;
            2'b11: new_pc = {p4[31:28], addr[25:0], 2'b00};
        endcase
    end

    alu inst_alu(a, b, aluc, r, z);
    scregfile inst_regfile(rs, rt, d, wn, wreg, clk, clrn, qa, qb);
    scinstmem inst_instmem(pc, inst);
    scdatamem inst_datamem(clk, do, qb, r, wmem);
    sccontrolunit inst_sccontrol(z, op, func, m2reg, pcsrc, wmem, jal, sext, aluc, shift, aluimm, wreg, regrt);

    assign aluout = r;
    assign memout = do;
endmodule
