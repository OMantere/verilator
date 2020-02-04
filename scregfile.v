`include "dec5e.v"
`include "dffe32.v"
module scregfile(
    input wire [4:0] rna,
    input wire [4:0] rnb,
    input wire [31:0] d,
    input wire [4:0] wn,
    input wire we,
    input wire clk,
    input wire clrn,
    output wire [31:0] qa,
    output wire [31:0] qb
);
    wire [31:0] e; 
    wire [31:0] q [31:0];
 
    assign q[0] = 0;
    assign qa = q[rna];
    assign qb = q[rnb];
 
    dec5e inst_dec(wn, we, e);

    genvar i;
    generate
        for(i = 1; i < 32; i = i + 1)  begin
            dffe32 inst_dffe32(d, e[i], clk, clrn, q[i]);
        end
    endgenerate

endmodule
