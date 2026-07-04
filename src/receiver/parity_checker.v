`timescale 1ns / 1ps

module parity_checker
(
    input  wire [7:0] data_in,
    input  wire       received_parity,

    output reg        checker_out
);

always @(*)
begin
    checker_out = (received_parity == ~(^data_in));
end

endmodule