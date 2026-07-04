`timescale 1ns / 1ps

module uart_tx_tb;

    reg sys_clk;
    reg rst_n;
    reg tx_enable;
    reg [7:0] tx_data_in;
    reg even_odd;

    wire serial_out;
    wire busy;

    uart_tx uut
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .tx_enable(tx_enable),
        .tx_data_in(tx_data_in),
        .even_odd(even_odd),
        .serial_out(serial_out),
        .busy(busy)
    );

    //----------------------------------------------------------
    // 64 MHz System Clock
    //----------------------------------------------------------

    initial
    begin
        sys_clk = 1'b0;
        forever #7.8125 sys_clk = ~sys_clk;
    end

    //----------------------------------------------------------
    // Stimulus
    //----------------------------------------------------------

    initial
    begin

        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);

        rst_n      = 0;
        tx_enable  = 0;
        tx_data_in = 8'h00;
        even_odd   = 1'b1;

        //------------------------------------------------------
        // Reset
        //------------------------------------------------------

        #30;
        rst_n = 1;

        //------------------------------------------------------
        // Send AA
        //------------------------------------------------------

        #50;

        tx_data_in = 8'hAA;
        tx_enable  = 1;

        @(posedge busy);
        tx_enable = 0;

        @(negedge busy);

        //------------------------------------------------------
        // Send CC
        //------------------------------------------------------

        #100;

        tx_data_in = 8'hCC;
        tx_enable  = 1;

        @(posedge busy);
        tx_enable = 0;

        @(negedge busy);

        //------------------------------------------------------

        #100;

        $finish;

    end

endmodule