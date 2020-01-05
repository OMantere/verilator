module code;
    module add1(a, b, ci, s, co);
        input a, b;
        input ci;
        output s;
        output co;
        wire p = a | b;
        wire g = a & b;
        assign co = (p & ci) | g;
        assign s = (p & ~g) ^ ci;
    endmodule

    module add4(a, b, ci, s, co);
        input [3:0] a, b;
        input ci;
        output [3:0] s;
        output co;
        wire [2:0] c;
        add1 a0(a[0], b[0], ci, s[0], c[0]);
        add1 a1(a[1], b[1], c[0], s[1], c[1]);
        add1 a2(a[2], b[2], c[1], s[2], c[2]);
        add1 a3(a[3], b[3], c[2], s[3], c0);
    endmodule

    wire [3:0] x, y, z;

    initial begin $display("Hello World");
        x = 2, y = 1;
        #10;
        $display("2 + 1 = ")
        $display(add4(2, 1, 0, ))
    $finish; end
endmodule
