`timescale 1ns / 1ps

module parity_generator_tb;

    reg  [7:0] tx_data_in;
    reg        even_odd;
    wire       parity_bit;

    parity_generator uut
    (
        .tx_data_in(tx_data_in),
        .even_odd(even_odd),
        .parity_bit(parity_bit)
    );

    initial
    begin

        $dumpfile("parity_generator.vcd");
        $dumpvars(0, parity_generator_tb);

        $display("---------------------------------------------");
        $display(" Data      Mode      Parity");
        $display("---------------------------------------------");

        // 00000000
        tx_data_in = 8'h00; even_odd = 0; #10;
        $display("%b   EVEN      %b", tx_data_in, parity_bit);

        tx_data_in = 8'h00; even_odd = 1; #10;
        $display("%b   ODD       %b", tx_data_in, parity_bit);

        // 11111111
        tx_data_in = 8'hFF; even_odd = 0; #10;
        $display("%b   EVEN      %b", tx_data_in, parity_bit);

        tx_data_in = 8'hFF; even_odd = 1; #10;
        $display("%b   ODD       %b", tx_data_in, parity_bit);

        // 10101010
        tx_data_in = 8'hAA; even_odd = 0; #10;
        $display("%b   EVEN      %b", tx_data_in, parity_bit);

        tx_data_in = 8'hAA; even_odd = 1; #10;
        $display("%b   ODD       %b", tx_data_in, parity_bit);

        // 11001100
        tx_data_in = 8'hCC; even_odd = 0; #10;
        $display("%b   EVEN      %b", tx_data_in, parity_bit);

        tx_data_in = 8'hCC; even_odd = 1; #10;
        $display("%b   ODD       %b", tx_data_in, parity_bit);

        // Random test
        tx_data_in = 8'h5D; even_odd = 0; #10;
        $display("%b   EVEN      %b", tx_data_in, parity_bit);

        tx_data_in = 8'h5D; even_odd = 1; #10;
        $display("%b   ODD       %b", tx_data_in, parity_bit);

        $display("---------------------------------------------");

        #10;
        $finish;

    end

endmodule