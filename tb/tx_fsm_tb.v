`timescale 1ns / 1ps

module tx_fsm_tb;

    reg baud_clk;
    reg rst_n;
    reg tx_enable;

    wire busy;
    wire load;
    wire shift;

    tx_fsm uut
    (
        .baud_clk(baud_clk),
        .rst_n(rst_n),
        .tx_enable(tx_enable),
        .busy(busy),
        .load(load),
        .shift(shift)
    );

    // Baud clock generation
    initial
    begin
        baud_clk = 0;
        forever #10 baud_clk = ~baud_clk;
    end

    initial
    begin

        $dumpfile("tx_fsm.vcd");
        $dumpvars(0, tx_fsm_tb);

        rst_n = 0;
        tx_enable = 0;

        #30;

        rst_n = 1;

        #40;

        // Start transmission
        tx_enable = 1;

        #20;

        tx_enable = 0;

        // Allow complete transmission
        #300;

        $finish;

    end

endmodule