`timescale 1ns / 1ps

module negative_edge_detector_tb;

    reg det_clk;
    reg det_rst_n;
    reg det_input;

    wire det_output;

    //----------------------------------------------------------
    // DUT
    //----------------------------------------------------------

    negative_edge_detector uut
    (
        .det_clk(det_clk),
        .det_rst_n(det_rst_n),
        .det_input(det_input),
        .det_output(det_output)
    );

    //----------------------------------------------------------
    // Clock
    //----------------------------------------------------------

    initial
    begin
        det_clk = 0;
        forever #10 det_clk = ~det_clk;
    end

    //----------------------------------------------------------
    // Stimulus
    //----------------------------------------------------------

    initial
    begin

        $dumpfile("negative_edge_detector.vcd");
        $dumpvars(0, negative_edge_detector_tb);

        det_rst_n = 0;
        det_input = 1;

        #30;
        det_rst_n = 1;

        //------------------------------------------------------
        // Falling edge -> should detect
        //------------------------------------------------------

        #40;
        det_input = 0;

        #40;
        det_input = 1;

        //------------------------------------------------------
        // Another falling edge
        //------------------------------------------------------

        #60;
        det_input = 0;

        #40;
        det_input = 1;

        //------------------------------------------------------
        // Stay high
        //------------------------------------------------------

        #80;

        //------------------------------------------------------
        // Stay low (should only pulse once)
        //------------------------------------------------------

        det_input = 0;

        #80;

        $finish;

    end

endmodule