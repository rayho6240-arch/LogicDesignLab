`timescale 1ns / 1ps
`define CYCLE 8.0

module top_tb;

    reg clk;
    reg rst;
    reg [3:0] btn;
    wire [3:0] led;

    integer hit_count;

    always #(`CYCLE / 2) clk = ~clk;

    Top #(
        .WAIT_BASE_CYCLES(8),
        .WAIT_STEP_CYCLES(2),
        .HIT_CYCLES(20)
    ) dut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .led(led)
    );

    task press_lit_button;
        begin
            wait (led != 4'b0000);
            @(posedge clk);
            btn = led;
            @(posedge clk);
            @(posedge clk);
            btn = 4'b0000;
            hit_count = hit_count + 1;
        end
    endtask

    initial begin
        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");

        clk = 1'b0;
        rst = 1'b1;
        btn = 4'b0000;
        hit_count = 0;

        repeat (4) @(posedge clk);
        rst = 1'b0;

        repeat (12) press_lit_button();

        repeat (10) @(posedge clk);

        if (hit_count == 12) begin
            $display("PASS: hit %0d moles", hit_count);
        end else begin
            $display("FAIL: hit_count = %0d", hit_count);
        end

        $display("----------------------");
        $display("--- Simulation End ---");
        $display("----------------------");
        $finish;
    end

endmodule
