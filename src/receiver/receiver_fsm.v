`timescale 1ns / 1ps

module receiver_fsm
(
    input  wire fsm_clk,             // Baud clock
    input  wire fsm_rst_n,           // Active-low reset
    input  wire start_detect_bit,    // From negative edge detector

    output reg  load,
    output reg  shift,
    output reg  busy
);

    //----------------------------------------------------------
    // State Encoding
    //----------------------------------------------------------

    localparam IDLE  = 3'b000;
    localparam SYNC  = 3'b001;
    localparam SHIFT = 3'b010;
    localparam LOAD  = 3'b011;
    localparam WAIT  = 3'b100;

    reg [2:0] current_state;
    reg [2:0] next_state;

    reg [3:0] bit_count;

    //----------------------------------------------------------
    // State Register
    //----------------------------------------------------------

    always @(posedge fsm_clk or negedge fsm_rst_n)
    begin
        if(!fsm_rst_n)
        begin
            current_state <= IDLE;
            bit_count <= 4'd0;
        end
        else
        begin
            current_state <= next_state;

            if(current_state == SHIFT)
                bit_count <= bit_count + 1'b1;
            else
                bit_count <= 4'd0;
        end
    end

    //----------------------------------------------------------
    // Next-State Logic
    //----------------------------------------------------------

    always @(*)
    begin
        case(current_state)

            //--------------------------------------------------
            IDLE:
            begin
                if(start_detect_bit)
                    next_state = SYNC;
                else
                    next_state = IDLE;
            end

            //--------------------------------------------------
            // Wait exactly one baud clock after start detection
            //--------------------------------------------------
            SYNC:
            begin
                next_state = SHIFT;
            end

            //--------------------------------------------------
            SHIFT:
            begin
                if(bit_count == 4'd10)
                    next_state = LOAD;
                else
                    next_state = SHIFT;
            end

            //--------------------------------------------------
            LOAD:
            begin
                next_state = WAIT;
            end

            //--------------------------------------------------
            WAIT:
            begin
                next_state = IDLE;
            end

            default:
                next_state = IDLE;

        endcase
    end

    //----------------------------------------------------------
    // Output Logic
    //----------------------------------------------------------

    always @(*)
    begin
        load  = 1'b0;
        shift = 1'b0;
        busy  = 1'b0;

        case(current_state)

            IDLE:
            begin
                busy = 1'b0;
            end

            SYNC:
            begin
                busy = 1'b1;
            end

            SHIFT:
            begin
                busy  = 1'b1;
                shift = 1'b1;
            end

            LOAD:
            begin
                busy = 1'b1;
                load = 1'b1;
            end

            WAIT:
            begin
                busy = 1'b0;
            end

        endcase
    end

endmodule