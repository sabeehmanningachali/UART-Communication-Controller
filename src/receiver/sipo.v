`timescale 1ns / 1ps

module sipo
(
    input  wire       reg_clk,
    input  wire       reg_rst_n,
    input  wire       load,
    input  wire       shift,
    input  wire       serial_data_in,

    output reg [7:0]  parallel_data_out,
    output reg        received_parity
);

    //----------------------------------------------------------
    // Shift Register
    //----------------------------------------------------------

    reg [10:0] shift_reg;

    //----------------------------------------------------------
    // Shift / Load Logic
    //----------------------------------------------------------

    always @(posedge reg_clk or negedge reg_rst_n)
    begin
        if(!reg_rst_n)
        begin
            shift_reg         <= 11'd0;
            parallel_data_out <= 8'd0;
            received_parity   <= 1'b0;
        end

        else
        begin

            //--------------------------------------------------
            // Shift serial data
            //--------------------------------------------------

            if(shift)
                shift_reg <= {serial_data_in, shift_reg[10:1]};

            //--------------------------------------------------
            // Parallel load
            //--------------------------------------------------

            if(load)
            begin
                parallel_data_out <= shift_reg[8:1];
                received_parity   <= shift_reg[9];
            end

        end
    end

endmodule