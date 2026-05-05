`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Gated_SR_Latch_tb 
// Description: Testbench for Gated SR Latch
//////////////////////////////////////////////////////////////////////////////////

module Gated_SR_Latch_tb();

    // 1. 宣告訊號
    reg s, r, e;
    wire q, q_n;

    // 2. 實例化待測模組 (DUT)
    // 確保這裡的名稱與你 Design Sources 裡的 Gated_SR_Latch 一致
    Gated_SR_Latch dut(
        .S(s),
        .R(r),   
        .En(e),
        .Q(q),
        .Q_n(q_n)
    );

    // 3. 測試波形：完全在 initial 區塊內手動精準控制，避免多重驅動
    initial begin
        // --- 初始化所有 reg 訊號 ---
        e = 0; 
        s = 0;
        r = 0;
        
        $display ("\n\n* Simulation Start !! *");
        $monitor("Time=%0t ns | E=%b, S=%b, R=%b | Q=%b, Q_n=%b", $time, e, s, r, q, q_n);

        // --- 測試階段 ---
        
        // 1. 打開門 (E=1)，強迫 Reset，消除初始的未知狀態 (x)
        #10 e = 1; s = 0; r = 1;  // 預期結果: Q=0
        
        // 2. 關上門 (E=0)，這時嘗試給 Set 訊號
        #10 e = 0; s = 1; r = 0;  // 預期結果: 因為門關著，訊號進不去，Q 保持 0
        
        // 3. 打開門 (E=1)，剛剛的 Set 訊號終於進去了
        #10 e = 1; s = 1; r = 0;  // 預期結果: Q=1
        
        // 4. 打開門 (E=1)，測試 Hold (保持) 狀態
        #10 e = 1; s = 0; r = 0;  // 預期結果: Q 保持 1
        
        // 5. 關上門 (E=0)，這時嘗試給 Reset 訊號
        #10 e = 0; s = 0; r = 1;  // 預期結果: 因為門關著，不會被 Reset，Q 保持 1
        
        // 6. 打開門 (E=1)，讓 Reset 訊號進去
        #10 e = 1; s = 0; r = 1;  // 預期結果: Q=0
        
        // 7. 測試 Invalid (不合法) 狀態
        #10 e = 1; s = 1; r = 1;  // 預期結果: 觀察你的電路 Q 和 Q_n 會發生什麼事
        
        #20; 
        
        $display ("* Simulation End !! *\n");
        $finish();
    end

endmodule