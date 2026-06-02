module single_mole #(
    parameter integer WAIT_BASE_CYCLES = 125_000_000,
    parameter integer WAIT_STEP_CYCLES = 15_000_000,
    parameter integer HIT_CYCLES       = 250_000_000
) (
    input  wire       clk,
    input  wire       rst,
    input  wire       button,
    input  wire [3:0] lfsr_val,
    output reg        led
);

    localparam IDLE = 2'd0;
    localparam WAIT = 2'd1;
    localparam UP   = 2'd2;
    localparam [31:0] WAIT_BASE = WAIT_BASE_CYCLES;
    localparam [31:0] WAIT_STEP = WAIT_STEP_CYCLES;
    localparam [31:0] HIT_TIME  = HIT_CYCLES;

    reg [1:0] state;
    reg [31:0] timer;
    reg [31:0] wait_limit;
    reg button_d;

    wire button_rise = button && !button_d;

    always @(posedge clk) begin
        if (rst) begin
            state      <= IDLE;
            timer      <= 32'd0;
            wait_limit <= WAIT_BASE;
            led        <= 1'b0;
            button_d   <= 1'b0;
        end else begin
            button_d <= button;

            case (state)
                IDLE: begin
                    state      <= WAIT;
                    timer      <= 32'd0;
                    wait_limit <= WAIT_BASE + (lfsr_val * WAIT_STEP);
                    led        <= 1'b0;
                end

                WAIT: begin
                    led <= 1'b0;
                    if (timer >= wait_limit) begin
                        state <= UP;
                        timer <= 32'd0;
                    end else begin
                        timer <= timer + 32'd1;
                    end
                end

                UP: begin
                    led <= 1'b1;
                    if (button_rise || timer >= HIT_TIME) begin
                        state      <= WAIT;
                        timer      <= 32'd0;
                        wait_limit <= WAIT_BASE + (lfsr_val * WAIT_STEP);
                        led        <= 1'b0;
                    end else begin
                        timer <= timer + 32'd1;
                    end
                end

                default: begin
                    state <= IDLE;
                    timer <= 32'd0;
                    led   <= 1'b0;
                end
            endcase
        end
    end

endmodule
