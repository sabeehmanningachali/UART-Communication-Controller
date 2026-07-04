`timescale 1ns / 1ps

module sipo_tb;

    reg reg_clk;
    reg reg_rst_n;
    reg load;
    reg shift;
    reg serial_data_in;

    wire [7:0] parallel_data_out;
    wire received_parity;

    //----------------------------------------------------------
    // DUT
    //----------------------------------------------------------

    sipo uut
    (
        .reg_clk(reg_clk),
        .reg_rst_n(reg_rst_n),
        .load(load),
        .shift(shift),
        .serial_data_in(serial_data_in),
        .parallel_data_out(parallel_data_out),
        .received_parity(received_parity)
    );

    //----------------------------------------------------------
    // Clock
    //----------------------------------------------------------

    initial
    begin
        reg_clk = 0;
        forever #10 reg_clk = ~reg_clk;
    end

    //----------------------------------------------------------
    // Stimulus
    //----------------------------------------------------------

    initial
    begin

        $dumpfile("sipo.vcd");
        $dumpvars(0, sipo_tb);

        reg_rst_n      = 0;
        load           = 0;
        shift          = 0;
        serial_data_in = 1;

        //------------------------------------------------------
        // Reset
        //------------------------------------------------------

        #25;
        reg_rst_n = 1;

        shift = 1;

        //------------------------------------------------------
        // UART Frame
        //
        // Start
        // D0-D7 (0xAA = 10101010)
        // Parity (odd = 0)
        // Stop
        //------------------------------------------------------

        // Start
        serial_data_in = 0; @(posedge reg_clk);

        // D0
        serial_data_in = 0; @(posedge reg_clk);

        // D1
        serial_data_in = 1; @(posedge reg_clk);

        // D2
        serial_data_in = 0; @(posedge reg_clk);

        // D3
        serial_data_in = 1; @(posedge reg_clk);

        // D4
        serial_data_in = 0; @(posedge reg_clk);

        // D5
        serial_data_in = 1; @(posedge reg_clk);

        // D6
        serial_data_in = 0; @(posedge reg_clk);

        // D7
        serial_data_in = 1; @(posedge reg_clk);

        // Parity (odd)
        serial_data_in = 0; @(posedge reg_clk);

        // Stop
        serial_data_in = 1; @(posedge reg_clk);

        //------------------------------------------------------
        // Finish shifting
        //------------------------------------------------------

        shift = 0;

        @(posedge reg_clk);

        //------------------------------------------------------
        // Load parallel data
        //------------------------------------------------------

        load = 1;

        @(posedge reg_clk);

        load = 0;

        //------------------------------------------------------

        #100;

        $finish;

    end

endmodule