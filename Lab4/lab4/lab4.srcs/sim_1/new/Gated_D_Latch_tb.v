`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Gated_D_Latch_tb 
// Description: Testbench for Gated D Latch
//////////////////////////////////////////////////////////////////////////////////

module Gated_D_Latch_tb(); // 建議把名字改成符合實際功能的名稱

    reg d, e;
    wire q, q_n;


    Gated_D_Latch dut(
        .D(d),
        .En(e),   
        .Q(q),
        .Q_n(q_n)
    );


    always #5 d = ~d;

    initial begin
        // 1. 初始化所有 reg 訊號
        e = 0; 
        d = 0;
        
        $display ("\n\n* Simulation Start !! *");
        $monitor("Time=%0t ns | En=%b, D=%b | Q=%b, Q_n=%b", $time, e, d, q, q_n);

        // 2. 測試波形：刻意把 e 改變的時間點跟 d 錯開 (d 在 5, 10, 15... 改變)
        #7  e = 1;  // t=7，打開門 (這時 D 應該是 1，Q 會跟著變 1)
        #11 e = 0;  // t=18，關上門 (這時 D 是 1，Q 應該要保持 1)
        #14 e = 1;  // t=32，打開門 (測試途中 D 發生變化，Q 應該要即時跟著變)
        #15 e = 0;  // t=47，關上門
        #10 e = 1;  // t=57，打開門
        
        #20; 
        
        $display ("* Simulation End !! *\n");
        $finish();
    end

endmodule