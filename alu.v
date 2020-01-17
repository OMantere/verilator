`timescale 1ns / 1ps

module alu(
    input wire [31:0] a,
    input wire signed [31:0] b,
    input wire [3:0] aluc,
    output wire [31:0] r,
    output wire z
);
    wire [1:0] select;
    wire toggle;
    wire arith;
    assign select = aluc[1:0];
    assign toggle = aluc[2];
    assign arith = aluc[3];
    
    wire [31:0] s;
    assign s = toggle ? a - b : a + b;

    wire [31:0] and_or;
    assign and_or = toggle ? a | b : a & b;

    wire [31:0] xor_lui;
    assign xor_lui = toggle ? {b[15:0], 16'h0} : (a ^ b);

    reg [31:0] res;
    reg [31:0] sh;
    wire [4:0] sa;
    assign sa = a[4:0];

    always @(*) begin
        if (toggle) begin
            if (arith)
                sh = b >>> sa;
            else
                sh = b >> sa;
        end
        else begin
            if (arith)
                sh = b <<< sa;
            else
                sh = b << sa;
        end
    end

    always @(*) begin
        case (select)
            2'h0 : res = s;
            2'h1 : res = and_or;
            2'h2 : res = xor_lui;
            2'h3 : res = sh;
        endcase
    end

    assign r = res;
    assign z = r == 0;

endmodule

