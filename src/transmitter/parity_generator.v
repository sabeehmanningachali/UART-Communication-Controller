`timescale 1ns / 1ps

module parity_generator
(
    input  wire [7:0] tx_data_in,
    input  wire       even_odd,
    output wire       parity_bit
);

    // even_odd = 0 -> Even parity
    // even_odd = 1 -> Odd parity

    assign parity_bit = even_odd ? ~(^tx_data_in) : (^tx_data_in);

endmodule