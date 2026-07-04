`timescale 1ns / 1ps

module uart_tx
(
    input  wire       sys_clk,
    input  wire       rst_n,
    input  wire       tx_enable,
    input  wire [7:0] tx_data_in,
    input  wire       even_odd,

    output wire       serial_out,
    output wire       busy
);

    //==========================================================
    // Internal Signals
    //==========================================================

    wire baud_clk;
    wire parity_bit;
    wire load;
    wire shift;

    //==========================================================
    // Baud Generator
    //==========================================================

    baud_generator baud_gen
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .baud_clk(baud_clk)
    );

    //==========================================================
    // Parity Generator
    //==========================================================

    parity_generator parity_gen
    (
        .tx_data_in(tx_data_in),
        .even_odd(even_odd),
        .parity_bit(parity_bit)
    );

    //==========================================================
    // TX FSM
    //==========================================================

    tx_fsm transmitter_fsm
    (
        .baud_clk(baud_clk),
        .rst_n(rst_n),
        .tx_enable(tx_enable),
        .busy(busy),
        .load(load),
        .shift(shift)
    );

    //==========================================================
    // PISO Register
    //==========================================================

    piso piso_register
    (
        .baud_clk(baud_clk),
        .reg_rst_n(rst_n),
        .load(load),
        .shift(shift),
        .p_data_in(tx_data_in),
        .parity_bit(parity_bit),
        .serial_out(serial_out)
    );

endmodule