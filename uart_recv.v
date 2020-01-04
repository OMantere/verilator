`timescale 1ns / 1ps

module uart_recv(
        input wire CLK,
        input wire UART_RX,
        output wire [7:0] o_data,
        output wire o_recv
    );  
    parameter idle = 0, start = 1, data = 2, stop = 3, finish = 4;
    parameter timer_max = 10416;
    reg [13:0] timer = 0;
    reg rx_bit = 0;
    reg [2:0] state = 0;
    reg recv = 0;
    reg [7:0] data_reg = 0;
    reg [2:0] index = 0;

    assign o_recv = recv;
    assign o_data = data_reg;
    
    always @ (posedge CLK) begin
        rx_bit <= UART_RX;
    end
    
    always @ (posedge CLK) begin
        case (state)
            idle: begin
                recv <= 0;
                timer <= 0;
                index <= 0;

                if (rx_bit == 0) begin
                    state <= start;
                end
            end

            start: begin
                if (timer < (timer_max) / 2) begin
                    timer <= timer + 1;
                end
                else begin
                    timer <= 0;
                    if (rx_bit == 0) begin
                        state <= data;
                    end
                    else begin
                        state <= idle;
                    end
                end
            end

            data: begin
                if (timer < timer_max) begin
                    timer <= timer + 1;
                end
                else begin
                    data_reg[index] <= rx_bit;
                    timer <= 0;
                    if (index == 7) begin
                        state <= stop;
                    end
                    else begin
                        index <= index + 1;
                    end
                end
            end

            stop: begin
                if (timer < timer_max) begin
                    timer <= timer + 1;
                end
                else begin
                    recv <= 1;
                    state <= finish;
                    timer <= 0;
                end
            end

            finish: begin
                recv <= 0;
                state <= idle;
            end

        endcase
    end 
    
endmodule
