`timescale 1ns / 1ps

module receiver_fsm_tb;

    reg baud_clk;
    reg rst_n;
    reg start_detect_bit;

    wire load;
    wire shift;
    wire busy;

    receiver_fsm uut
    (
        .fsm_clk(baud_clk),
        .fsm_rst_n(rst_n),
        .start_detect_bit(start_detect_bit),
        .load(load),
        .shift(shift),
        .busy(busy)
    );

    //----------------------------------------------------------
    // Baud Clock (20 ns period)
    //----------------------------------------------------------

    initial
    begin
        baud_clk = 0;
        forever #10 baud_clk = ~baud_clk;
    end

    //----------------------------------------------------------
    // Dumpfile
    //----------------------------------------------------------

    initial
    begin
        $dumpfile("receiver_fsm.vcd");
        $dumpvars(0, receiver_fsm_tb);
    end

    //----------------------------------------------------------
    // Stimulus
    //----------------------------------------------------------

    initial
    begin

        rst_n = 0;
        start_detect_bit = 0;

        #30;
        rst_n = 1;

        // Detect start bit
        #35;
        start_detect_bit = 1;

        #20;
        start_detect_bit = 0;

        // Allow enough baud clocks for:
        // SYNC + SHIFT + LOAD + WAIT

        #500;

        $finish;

    end

endmodule