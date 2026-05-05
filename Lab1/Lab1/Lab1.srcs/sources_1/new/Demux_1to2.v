`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/09 17:30:39
// Design Name: 
// Module Name: Demux_1to2
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


module Demux_1to2(
    input channel,
    input dst_sel,
    output dst_0,
    output dst_1
);

    assign dst_0 = ~dst_sel & channel;
    assign dst_1 = dst_sel & channel;
    
endmodule
