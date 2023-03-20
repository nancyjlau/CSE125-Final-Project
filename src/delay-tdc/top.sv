module top(
    input [0:0] clk,
    input [0:0] reset,
    input [0:0] uart_rx,
    output [0:0] uart_tx
);

    reg [7:0] uart_data;
    wire [9:0] stage_delays;

    tdc tdc_inst (
        .clk(clk),
        .reset(reset),
        .uart_data(uart_data),
        .stage_delays(stage_delays)
    );

    wire [3:0] binary_position;

    priority_encoder priority_encoder_inst (
        .thermometric(stage_delays),
        .binary_position(binary_position)
    );

    wire rx_idle;
    reg rx_ready;
    reg rx_eop;

    uart_rx uart_rx_inst (
        .clk(clk),
        .rx(uart_rx),
        .rx_ready(rx_ready),
        .rx_data(uart_data),
        .rx_idle(rx_idle),
        .rx_eop(rx_eop)
    );

    wire tx_busy;

    uart_tx uart_tx_inst (
        .clk(clk),
        .tx_start(rx_ready || rx_eop),
        .tx_data(binary_position), 
        .tx(uart_tx),
        .tx_busy(tx_busy)
    );

endmodule
