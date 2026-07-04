`timescale 1ns / 1ps

module parity_checker_tb;

    reg [7:0] data_in;
    reg received_parity;

    wire checker_out;

    parity_checker uut
    (
        .data_in(data_in),
        .received_parity(received_parity),
        .checker_out(checker_out)
    );

    initial
    begin

        $dumpfile("parity_checker.vcd");
        $dumpvars(0, parity_checker_tb);

        //------------------------------------------------------
        // Correct Odd Parity
        //------------------------------------------------------

        data_in = 8'hAA;
        received_parity = 0;

        #20;

        //------------------------------------------------------
        // Wrong Parity
        //------------------------------------------------------

        received_parity = 1;

        #20;

        //------------------------------------------------------
        // Another Correct Frame
        //------------------------------------------------------

        data_in = 8'hCC;
        received_parity = ~(^8'hCC);

        #20;

        //------------------------------------------------------
        // Wrong Frame
        //------------------------------------------------------

        received_parity = ~(^8'hCC) ^ 1'b1;

        #20;

        $finish;

    end

endmodule