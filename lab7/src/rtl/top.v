module Top #(
    parameter integer WAIT_BASE_CYCLES = 125_000_000,
    parameter integer WAIT_STEP_CYCLES = 15_000_000,
    parameter integer HIT_CYCLES       = 250_000_000
) (
    input  wire       clk,
    input  wire       rst,
    input  wire [3:0] btn,
    output wire [3:0] led
);

    wire [3:0] lfsr_out;

    lfsr_4bit random_gen (
        .clk(clk),
        .rst(rst),
        .q(lfsr_out)
    );

    single_mole #(
        .WAIT_BASE_CYCLES(WAIT_BASE_CYCLES),
        .WAIT_STEP_CYCLES(WAIT_STEP_CYCLES),
        .HIT_CYCLES(HIT_CYCLES)
    ) mole0 (
        .clk(clk),
        .rst(rst),
        .button(btn[0]),
        .lfsr_val(lfsr_out),
        .led(led[0])
    );

    single_mole #(
        .WAIT_BASE_CYCLES(WAIT_BASE_CYCLES),
        .WAIT_STEP_CYCLES(WAIT_STEP_CYCLES),
        .HIT_CYCLES(HIT_CYCLES)
    ) mole1 (
        .clk(clk),
        .rst(rst),
        .button(btn[1]),
        .lfsr_val({lfsr_out[0], lfsr_out[3:1]}),
        .led(led[1])
    );

    single_mole #(
        .WAIT_BASE_CYCLES(WAIT_BASE_CYCLES),
        .WAIT_STEP_CYCLES(WAIT_STEP_CYCLES),
        .HIT_CYCLES(HIT_CYCLES)
    ) mole2 (
        .clk(clk),
        .rst(rst),
        .button(btn[2]),
        .lfsr_val(lfsr_out ^ 4'b1010),
        .led(led[2])
    );

    single_mole #(
        .WAIT_BASE_CYCLES(WAIT_BASE_CYCLES),
        .WAIT_STEP_CYCLES(WAIT_STEP_CYCLES),
        .HIT_CYCLES(HIT_CYCLES)
    ) mole3 (
        .clk(clk),
        .rst(rst),
        .button(btn[3]),
        .lfsr_val({lfsr_out[1:0], lfsr_out[3:2]}),
        .led(led[3])
    );

endmodule
