module dffe32(
    input wire [31:0] d,
    input wire e,
    input wire clk,
    input wire clrn,
    output wire [31:0] q
);
    reg [31:0] q_reg;

    always @ (negedge clrn or posedge clk) begin
        if (!clrn) begin
            q_reg <= 0;
        end
        else if (e) begin
           q_reg <= d;  
        end
    end

    assign q = q_reg;
endmodule
