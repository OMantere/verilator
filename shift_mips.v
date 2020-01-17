module shift_mips(
    input wire [4:0] sa,
    input wire [31:0] d,
    input wire right,
    input wire arith,
    output wire [31:0] sh
);
    assign sh = (d << sa) & !right & !arith | (d >> sa) & right & !arith | (d <<< sa) & !right & arith | (d >>> sa) & right & arith;
endmodule;
