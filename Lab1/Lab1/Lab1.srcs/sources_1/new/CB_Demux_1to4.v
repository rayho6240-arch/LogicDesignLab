`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/09 17:17:14
// Design Name: 
// Module Name: CB_Demux_1to4
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


module CB_Demux_1to4(
    input channel,
    input [1:0] dst_sel,
    output dst_0,
    output dst_1,
    output dst_2,
    output dst_3
);

    wire f_dst_0, f_dst_1;

    Demux_1to2 M0(
    .channel(channel),
    .dst_sel(dst_sel[0]),
    .dst_0(f_dst_0),
    .dst_1(f_dst_1)
    );

    
    Demux_1to2 M1(
    .channel(f_dst_0),
    .dst_sel(dst_sel[1]),
    .dst_0(dst_0),
    .dst_1(dst_2)
    );
    
    Demux_1to2 M2(
    .channel(f_dst_1),
    .dst_sel(dst_sel[1]),
    .dst_0(dst_1),
    .dst_1(dst_3)
    );

endmodule
