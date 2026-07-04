`timescale 1ns / 1ps

module uart_rx
(
    input  wire sys_clk,
    input  wire rst_n,

    input  wire serial_data_in,

    output wire [7:0] parallel_data_out,
    output wire data_valid,
    output wire busy
);

    //----------------------------------------------------------
    // Internal Signals
    //----------------------------------------------------------

    wire baud_clk;

    wire start_detect_bit;

    wire shift;
    wire load;

    wire received_parity;

    //----------------------------------------------------------
    // Baud Generator
    //----------------------------------------------------------

    baud_generator baud_gen
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .baud_clk(baud_clk)
    );

    //----------------------------------------------------------
    // Negative Edge Detector
    //----------------------------------------------------------

    negative_edge_detector neg_edge_detector
    (
        .det_clk(baud_clk),
        .det_rst_n(rst_n),
        .det_input(serial_data_in),
        .det_output(start_detect_bit)
    );

    //----------------------------------------------------------
    // Receiver FSM
    //----------------------------------------------------------

    receiver_fsm receiver_controller
    (
        .fsm_clk(baud_clk),
        .fsm_rst_n(rst_n),
        .start_detect_bit(start_detect_bit),

        .load(load),
        .shift(shift),
        .busy(busy)
    );

    //----------------------------------------------------------
    // SIPO Register
    //----------------------------------------------------------

    sipo receiver_shift_register
    (
        .reg_clk(baud_clk),
        .reg_rst_n(rst_n),

        .load(load),
        .shift(shift),

        .serial_data_in(serial_data_in),

        .parallel_data_out(parallel_data_out),
        .received_parity(received_parity)
    );

    //----------------------------------------------------------
    // Parity Checker
    //----------------------------------------------------------

    parity_checker parity_check
    (
        .data_in(parallel_data_out),
        .received_parity(received_parity),
        .checker_out(data_valid)
    );

endmodule