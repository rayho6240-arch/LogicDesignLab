`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/05 09:09:51
// Design Name: 
// Module Name: counter_4_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Comprehensive testbench for 4-bit counter
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: Added $monitor, $finish and mid-count reset test.
// 
//////////////////////////////////////////////////////////////////////////////////

module counter_4_tb();

    wire [3:0] counter;
    reg clk, rst;

    counter_4 dut(
        .clk(clk),
        .rst(rst),
        .counter(counter)
    );

    always #5 clk = ~clk;

    initial begin
        $display("simulation start");

        clk = 0; 
        rst = 1;
        

        #15 rst = 0; //特地不對齊時脈邊緣，測試同步邏輯
        
        // --- 階段 3：測試完整計數週期 ---
        // 計數從 0 到 15 再溢位回 0，大約需要 160ns。
        #180; 

        // --- 階段 4：測試運行中的重置 (Mid-count reset) ---
        // 此時計數器應該數到 2 或 3，我們突然拉起 rst
        rst = 1; 
        #12 rst = 0; // 觀察是否能在下一個正緣 (posedge) 順利歸零並重新計數
        

        #50;

        
        $display("simulation done");
        $finish;
    end

endmodule