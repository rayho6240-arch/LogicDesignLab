`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: D_FF_tb
// Description: Testbench for D Flip-Flop
//////////////////////////////////////////////////////////////////////////////////

module SR_Latch_tb();

    reg s,r;
    wire q, q_n;

    // 實例化待測模組 (DUT)
    SR_Latch dut(
        .S(s),
        .R(r),
        .Q(q),
        .Q_n(q_n)
    );


//note: yours test data be set in "initial"
    initial begin
        // 1. 初始化所有 reg 訊號
        s = 0; 
        r = 0;
        
        $display ("\n\n* Simulation Start !! *");
  
  
        // 3. 給予測試波形 (刻意錯開 clk 翻轉的 5, 10, 15... 邊緣)
        #5  s = 0; r=0;
        #5  s = 1; r=0; 
        #5  s = 0; r=1; 
        #5  s = 1; r=1; 
        
        #10; 
        
        $display ("* Simulation End !! *\n");
        $finish();
    end

endmodule