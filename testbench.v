module testbench(
    input wire clk,
    input reg rx,
    output wire data
);
    wire clk;
    reg rx;
    wire [7:0] data;
    wire recv;
    reg [9:0] tosend = 10'b0101010101;
    reg [3:0] k;
    reg [16:0] i;

    uart_recv uart(clk, rx, data, recv);

    //initial begin
        //for(k = 0; k < 10; k = k + 1) begin
            //assign rx = tosend[k];    
            //$display("rx %b", rx);
            //for(i = 0; i < 10416; i = i + 1) begin
                //clk = 1;
                //clk = 0;
            //end
        //end
        //$display("recv %b", recv);
        //$display("data %b", data);
        //$finish;
    //end
endmodule
