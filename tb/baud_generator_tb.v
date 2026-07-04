`timescale 1ns / 1ps

module baud_generator_tb;

    reg sys_clk;
    reg rst_n;
    wire baud_clk;

    // Instantiate DUT
    baud_generator uut
    (
        .sys_clk(sys_clk),
        .rst_n(rst_n),
        .baud_clk(baud_clk)
    );

    // Generate 64 MHz system clock
    // Period = 15.625 ns
    initial
    begin
        sys_clk = 0;
        forever #7.8125 sys_clk = ~sys_clk;
    end

    // Stimulus
    initial
    begin
        rst_n = 0;

        #30;
        rst_n = 1;

        // Run long enough to observe multiple baud clock periods
        #500;

        $finish;
    end

    // Monitor values
    initial
    begin
        $monitor("Time = %0t ns | rst_n = %b | baud_clk = %b",
                 $time, rst_n, baud_clk);
    end

    // Generate waveform
    initial
    begin
        $dumpfile("baud_generator.vcd");
        $dumpvars(0, baud_generator_tb);
    end

endmodule