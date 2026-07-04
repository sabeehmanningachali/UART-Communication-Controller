`timescale 1ns / 1ps

module uart_system
(
    input wire sys_clk,
    input wire rst_n,

    input wire tx_enable,
    input wire [7:0] tx_data_in,
    input wire even_odd,

    output wire [7:0] parallel_data_out,
    output wire data_valid,

    output wire tx_busy,
    output wire rx_busy
);

    //----------------------------------------------------------
    // Internal Serial Wire
    //----------------------------------------------------------

    wire serial_line;

    //----------------------------------------------------------
    // UART Transmitter
    //----------------------------------------------------------

    uart_tx transmitter
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),

        .tx_enable(tx_enable),
        .tx_data_in(tx_data_in),
        .even_odd(even_odd),

        .serial_out(serial_line),
        .busy(tx_busy)
    );

    //----------------------------------------------------------
    // UART Receiver
    //----------------------------------------------------------

    uart_rx receiver
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),

        .serial_data_in(serial_line),

        .parallel_data_out(parallel_data_out),
        .data_valid(data_valid),
        .busy(rx_busy)
    );

endmodule