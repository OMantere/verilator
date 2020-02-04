module sccontrolunit(
    input wire z,
    input wire [5:0] op,
    input wire [5:0] func,
    output reg m2reg,
    output reg [1:0] pcsrc,
    output reg wmem,
    output reg jal,
    output reg sext,
    output reg [3:0] aluc,
    output reg shift,
    output reg aluimm,
    output reg wreg,
    output reg regrt
);
    // R-format funccodes
    parameter f_add = 6'b100000;
    parameter f_sub = 6'b000010;
    parameter f_and = 6'b100100;
    parameter f_or  = 6'b100101;
    parameter f_xor = 6'b100110;
    parameter f_sll = 6'b000000;
    parameter f_srl = 6'b000010;
    parameter f_sra = 6'b000011;
    parameter f_jr  = 6'b001000;

    // I- and J-format opcodes
    parameter o_rop  = 6'b000000;  // R-format opcode is zero
    parameter o_addi = 6'b001000;
    parameter o_andi = 6'b001100;
    parameter o_ori  = 6'b001101;
    parameter o_xori = 6'b001110;
    parameter o_lw   = 6'b100011;
    parameter o_sw   = 6'b101011;
    parameter o_beq  = 6'b000100;
    parameter o_bne  = 6'b000101;
    parameter o_lui  = 6'b001111;
    parameter o_j    = 6'b000010;
    parameter o_jal  = 6'b000011;

    always @(*) begin
        case (op)
            o_rop: begin
                aluimm = 0;
                sext = 1'bx;
            end
            o_addi: begin
                aluc = 4'bx000;
                pcsrc = 2'b00;
                wreg = 1;
                shift = 0;
                aluimm = 1;
                sext = 1;
            end
            o_andi: begin
                aluc = 4'bx001;
                pcsrc = 2'b00;
                wreg = 1;
                shift = 0;
                aluimm = 1;
                sext = 0;
            end
            o_ori: begin
                aluc = 4'bx101;
                pcsrc = 2'b00;
                wreg = 1;
                shift = 0;
                aluimm = 1;
                sext = 0;
            end
            o_xori: begin
                aluc = 4'bx010;
                pcsrc = 2'b00;
                wreg = 1;
                shift = 0;
                aluimm = 1;
                sext = 0;
            end
            o_lw: begin
                aluc = 4'bx000;
                pcsrc = 2'b00;
                wreg = 1;
                shift = 0;
                aluimm = 1;
                sext = 1;
            end
            o_sw: begin
                aluc = 4'bx000;
                pcsrc = 2'b00;
                wreg = 0;
                shift = 0;
                aluimm = 1;
                sext = 1;
            end
            o_beq: begin
                aluc = 4'bx010;
                wreg = 0;
                shift = 0;
                aluimm = 0;
                sext = 1;
                if (z)
                    pcsrc = 2'b01;
                else
                    pcsrc = 2'b00;
            end
            o_bne: begin
                aluc = 4'bx010;
                wreg = 0;
                shift = 0;
                aluimm = 0;
                sext = 1;
                if (z)
                    pcsrc = 2'b00;
                else
                    pcsrc = 2'b01;
            end
            o_lui: begin
                wreg = 1;
                aluc = 4'bx110;
                pcsrc = 2'b00;
                shift = 1'bx;
                aluimm = 1;
                sext = 1'bx;
            end
            o_j: begin
                wreg = 0;
                aluc = 4'bxxxx;
                pcsrc = 2'b11;
                shift = 1'bx;
                aluimm = 1'bx;
                sext = 1'bx;
            end
            o_jal: begin
                wreg = 1;
                aluc = 4'bxxxx;
                pcsrc = 2'b11;
                shift = 1'bx;
                aluimm = 1'bx;
                sext = 1'bx;
            end
        endcase

        wmem  = op == o_sw;
        regrt = op != o_rop;
        jal   = op == o_jal;
        m2reg = op == o_lw;

    end

    always @(*) begin
        if (op == o_rop) begin
            case (func)
                f_add: begin
                    aluc = 4'bx000;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 0;
                end
                f_sub: begin
                    aluc = 4'bx100;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 0;
                end
                f_and: begin
                    aluc = 4'bx001;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 0;
                end
                f_or: begin
                    aluc = 4'bx101;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 0;
                end
                f_xor: begin
                    aluc = 4'bx010;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 0;
                end
                f_sll: begin
                    aluc = 4'b0011;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 1;
                end
                f_srl: begin
                    aluc = 4'b0111;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 1;
                end
                f_sra: begin
                    aluc = 4'b1111;
                    pcsrc = 2'b00;
                    wreg = 1;
                    shift = 1;
                end
                f_jr: begin
                    aluc = 4'bxxxx;
                    pcsrc = 2'b10;
                    wreg = 0;
                    shift = 1'bx;
                end
            endcase
        end
    end
endmodule
