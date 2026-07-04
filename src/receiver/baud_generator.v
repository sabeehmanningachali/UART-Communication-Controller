`timescale 1ns / 1ps

module baud_generator #(
    parameter CLK_FREQ  = 64_000_000,
    parameter BAUD_RATE = 4_000_000
)
(
    input  wire sys_clk,
    input  wire rst_n,
    output reg  baud_clk
);

    localparam integer DIVIDE_COUNT = CLK_FREQ / (2 * BAUD_RATE);

    reg [$clog2(DIVIDE_COUNT)-1:0] counter;

    always @(posedge sys_clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            counter  <= 0;
            baud_clk <= 0;
        end
        else
        begin
            if (counter == DIVIDE_COUNT-1)
            begin
                counter  <= 0;
                baud_clk <= ~baud_clk;
            end
            else
            begin
                counter <= counter + 1;
            end
        end
    end

endmodule