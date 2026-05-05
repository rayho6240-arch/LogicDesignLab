`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/09 17:15:08
// Design Name: 
// Module Name: top_4
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


module top_4(
    input [3:0] src,
    input [1:0] src_sel,
    input [1:0] dst_sel,
    output [3:0] dst,
    output channel
);

    GL_Mux_4to1 M0(
    .src_0(src[0]),
    .src_1(src[1]),
    .src_2(src[2]),
    .src_3(src[3]),
    .src_sel(src_sel),
    .channel(channel)
    );
    
    CB_Demux_1to4 M1(
    .channel(channel),
    .dst_sel(dst_sel),
    .dst_0(dst[0]),
    .dst_1(dst[1]),
    .dst_2(dst[2]),
    .dst_3(dst[3])
    );
    
endmodule
