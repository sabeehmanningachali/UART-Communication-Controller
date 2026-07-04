`timescale 1ns / 1ps

module piso_tb;

    reg baud_clk;
    reg reg_rst_n;

    reg load;
    reg shift;

    reg [7:0] p_data_in;
    reg parity_bit;

    wire serial_out;

    piso uut
    (
        .baud_clk(baud_clk),
        .reg_rst_n(reg_rst_n),
        .load(load),
        .shift(shift),
        .p_data_in(p_data_in),
        .parity_bit(parity_bit),
        .serial_out(serial_out)
    );

    // Baud clock
    initial
    begin
        baud_clk = 0;
        forever #10 baud_clk = ~baud_clk;
    end

    initial
    begin

        $dumpfile("piso.vcd");
        $dumpvars(0,piso_tb);

        reg_rst_n = 0;
        load = 0;
        shift = 0;

        p_data_in = 8'hAA;
        parity_bit = 1'b1;

        #25;

        reg_rst_n = 1;

        // Load frame
        @(posedge baud_clk);
        load = 1;

        @(posedge baud_clk);
        load = 0;

        // Shift out all 11 bits
        repeat(11)
        begin
            @(posedge baud_clk);
            shift = 1;
        end

        @(posedge baud_clk);
        shift = 0;

        #40;

        $finish;

    end

endmodule