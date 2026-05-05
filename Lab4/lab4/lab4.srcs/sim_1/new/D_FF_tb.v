`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: D_FF_tb
// Description: Testbench for D Flip-Flop
//////////////////////////////////////////////////////////////////////////////////

module D_FF_tb();

    reg clk, d;
    wire q, q_n;

    // 實例化待測模組 (DUT)
    D_FF dut(
        .clk(clk),
        .D(d),
        .Q(q),
        .Q_n(q_n)
    );

    // 產生時脈，週期為 10ns (5ns Low, 5ns High)
    always #5 clk = ~clk;  

    initial begin
        // 1. 初始化所有 reg 訊號
        clk = 0; 
        d = 0;
        
        $display ("\n\n* Simulation Start !! *");
  
  
        // 3. 給予測試波形 (刻意錯開 clk 翻轉的 5, 10, 15... 邊緣)
        #7  d = 1;  // 在 t = 7 改變 (這時 clk 是 1，等到 t=10 才會觸發下一個上升緣)
        #10 d = 0;  // 在 t = 17 改變
        #14 d = 1;  // 在 t = 31 改變
        #12 d = 0;  // 在 t = 43 改變
        
        #20; // 再多等一段時間觀察最後狀態
        
        $display ("* Simulation End !! *\n");
        $finish();
    end

endmodule