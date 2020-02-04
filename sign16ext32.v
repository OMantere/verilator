module sign16ext32(
    input wire sext,
    input wire [15:0] in,
    output wire [31:0] out,
);
    always @(*) begin
        if sext begin
            out = { { 16{ in[15] } }, in };
        end
        else begin
            out = { { 16{ 0 } }, in };
        end
    end
endmodule
