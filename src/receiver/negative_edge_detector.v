`timescale 1ns / 1ps

module negative_edge_detector
(
    input  wire det_clk,
    input  wire det_rst_n,
    input  wire det_input,

    output reg  det_output
);

    //----------------------------------------------------------
    // Previous sampled value
    //----------------------------------------------------------

    reg previous;

    //----------------------------------------------------------
    // Detect falling edge
    //----------------------------------------------------------

    always @(posedge det_clk or negedge det_rst_n)
    begin
        if(!det_rst_n)
        begin
            previous   <= 1'b1;     // UART idle state
            det_output <= 1'b0;
        end
        else
        begin
            // Falling edge detection
            if(previous && !det_input)
                det_output <= 1'b1;
            else
                det_output <= 1'b0;

            // Store current sample
            previous <= det_input;
        end
    end

endmodule