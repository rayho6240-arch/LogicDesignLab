`timescale 1ns / 1ps
`define SIMULATION // 開啟快速模擬模式

module tb_OneRGB();

    // 訊號定義
    reg clk;
    reg rst;
    wire led_r, led_g, led_b;

    // 實例化被測模組 (UUT)
    OneRGB uut (
        .clk(clk),
        .rst(rst),
        .led_r(led_r),
        .led_g(led_g),
        .led_b(led_b)
    );

    // 產生 100MHz 時脈 (週期 10ns)
    always #5 clk = ~clk;

    initial begin
        // 初始化
        clk = 0;
        rst = 1;
        
        // 釋放重置
        #100;
        rst = 0;
        
        // 顯示資訊
        $display("開始模擬變色呼吸燈...");
        
        // 模擬足夠長的時間來觀察至少 3 個顏色變化
        // 在快速模擬模式下，這只需要幾毫秒
        #2000000; 
        
        $display("模擬結束");
        $finish;
    end

    // 監控狀態切換 (選用，方便你在 Console 看結果)
    always @(uut.cs) begin
        $display("時間: %t | 狀態變更為: %d", $time, uut.cs);
    end

endmodule