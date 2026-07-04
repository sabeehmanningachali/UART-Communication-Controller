`timescale 1ns / 1ps

module tx_fsm
(
    input  wire baud_clk,
    input  wire rst_n,
    input  wire tx_enable,

    output reg busy,
    output reg load,
    output reg shift
);

    //==========================================================
    // State Encoding
    //==========================================================

    localparam IDLE  = 2'b00;
    localparam LOAD  = 2'b01;
    localparam SHIFT = 2'b10;
    localparam WAIT  = 2'b11;

    reg [1:0] current_state;
    reg [1:0] next_state;

    // Counts transmitted bits
    reg [3:0] bit_count;

    //==========================================================
    // State Register
    //==========================================================

    always @(posedge baud_clk or negedge rst_n)
    begin
        if(!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    //==========================================================
    // Bit Counter
    //==========================================================

    always @(posedge baud_clk or negedge rst_n)
    begin
        if(!rst_n)
            bit_count <= 4'd0;

        else
        begin
            case(current_state)

                IDLE:
                    bit_count <= 4'd0;

                LOAD:
                    bit_count <= 4'd0;

                SHIFT:
                begin
                    if(bit_count < 4'd10)
                        bit_count <= bit_count + 1'b1;
                    else
                        bit_count <= 4'd0;
                end

                WAIT:
                    bit_count <= 4'd0;

            endcase
        end
    end

    //==========================================================
    // Next State Logic
    //==========================================================

    always @(*)
    begin

        case(current_state)

            IDLE:
            begin
                if(tx_enable)
                    next_state = LOAD;
                else
                    next_state = IDLE;
            end

            LOAD:
            begin
                next_state = SHIFT;
            end

            SHIFT:
            begin
                if(bit_count == 4'd10)
                    next_state = WAIT;
                else
                    next_state = SHIFT;
            end

            WAIT:
            begin
                next_state = IDLE;
            end

            default:
                next_state = IDLE;

        endcase

    end

    //==========================================================
    // Output Logic
    //==========================================================

    always @(*)
    begin

        busy  = 1'b0;
        load  = 1'b0;
        shift = 1'b0;

        case(current_state)

            IDLE:
            begin
                busy  = 1'b0;
                load  = 1'b0;
                shift = 1'b0;
            end

            LOAD:
            begin
                busy  = 1'b1;
                load  = 1'b1;
                shift = 1'b0;
            end

            SHIFT:
            begin
                busy  = 1'b1;
                load  = 1'b0;
                shift = 1'b1;
            end

            WAIT:
            begin
                busy  = 1'b0;
                load  = 1'b0;
                shift = 1'b0;
            end

        endcase

    end

endmodule