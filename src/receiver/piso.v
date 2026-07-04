`timescale 1ns / 1ps

module piso
(
    input  wire       baud_clk,
    input  wire       reg_rst_n,
    input  wire       load,
    input  wire       shift,
    input  wire [7:0] p_data_in,
    input  wire       parity_bit,

    output wire       serial_out
);

    reg [10:0] shift_reg;

    always @(posedge baud_clk or negedge reg_rst_n)
    begin
        if(!reg_rst_n)
        begin
            shift_reg <= 11'b11111111111;
        end

        else if(load)
        begin
            // {STOP, PARITY, DATA[7:0], START}
            shift_reg <= {1'b1, parity_bit, p_data_in, 1'b0};
        end

        else if(shift)
        begin
            // Shift right, fill MSB with logic 1 (idle level)
            shift_reg <= {1'b1, shift_reg[10:1]};
        end
    end

    assign serial_out = shift_reg[0];

endmodule