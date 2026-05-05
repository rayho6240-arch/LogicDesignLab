`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/04 15:41:45
// Design Name: 
// Module Name: D_FlipFlop
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_FF(
    input clk,
    input D,
    output Q,Q_n
    );
    
    wire con;
    
    Gated_D_Latch master(
    .D(D),
    .En(~clk),
    .Q(con),      // Master 的輸出接到中間線
    .Q_n()
    );
    
    
    Gated_D_Latch slaver(
    .D(con),
    .En(clk),
    .Q(Q),      // Master 的輸出接到中間線
    .Q_n(Q_n)
    );

    
endmodule
