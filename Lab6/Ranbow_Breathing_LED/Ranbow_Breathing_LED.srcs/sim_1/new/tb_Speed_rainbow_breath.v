`timescale 1ns / 1ps
`define SIMULATION

module tb_Speed_rainbow_breath();

    reg clk;
    reg rst;
    reg [1:0] btn;
    wire led_r, led_g, led_b;
    wire [3:0] led;

    // 實例化模組
    Speed_rainbow_breath uut (
        .clk(clk),
        .rst(rst),
        .btn(btn),
        .led_r(led_r),
        .led_g(led_g),
        .led_b(led_b),
        .led(led)
    );

    // 時脈產生 100MHz
    always #5 clk = ~clk;

    initial begin
        // 1. 初始化
        clk = 0;
        rst = 1;
        btn = 2'b00;
        #100;
        rst = 0; // 釋放重置
        
        $display("開始模擬：模式 0 (最慢)");
        #100000; // 在模式 0 跑一段時間 (100us)

        // 2. 模擬按下 btn[0] 切換到模式 1
        // 注意：因為你有 DEB 和 Long_Press，按鈕要持續一段時間
        $display("按下 btn[0]：切換至模式 1");
        btn[0] = 1;
        #20000;  // 假設長按 20us (視你的 Long_Press 設定而定)
        btn[0] = 0;
        #100000;

        // 3. 模擬再次按下 btn[0] 切換到模式 2
        $display("按下 btn[0]：切換至模式 2");
        btn[0] = 1;
        #20000;
        btn[0] = 0;
        #100000;

        $display("模擬結束");
        $finish;
    end

endmodule