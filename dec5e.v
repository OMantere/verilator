// Balanced tree decoder
// http://course.ece.cmu.edu/~ece447/s13/lib/exe/fetch.php?media=goodrtl-parkin.pdf
module dec5e(
    input wire [4:0] n,
    input wire ena,
    output wire [31:0] e
);
    wire [3:0] da = 1'b1 << n[1:0];
    wire [7:0] db = 1'b1 << n[4:2];
    wire [31:0] db_vec = {
        {4{db[7]}},
        {4{db[6]}},
        {4{db[5]}},
        {4{db[4]}},
        {4{db[3]}},
        {4{db[2]}},
        {4{db[1]}},
        {4{db[0]}}
    };
    wire [31:0] da_vec = {8{da}};
    assign e = ena ? db_vec & da_vec : 0;
endmodule
