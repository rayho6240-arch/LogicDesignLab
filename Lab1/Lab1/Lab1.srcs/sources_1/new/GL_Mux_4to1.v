`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/09 18:07:54
// Design Name: 
// Module Name: GL_Mux_4to1
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


module GL_Mux_4to1(
    input src_0,
    input src_1,
    input src_2,
    input src_3,
    input [1:0] src_sel,
    output channel
);

    wire src_sel_0_n, src_sel_1_n;
    wire f_src_0, f_src_1, f_src_2, f_src_3;
    wire f_src_01, f_src_23;
    wire f_src_a, f_src_b;
    
    not(src_sel_0_n, src_sel[0]);
    not(src_sel_1_n, src_sel[1]);
    and(f_src_0, src_sel_0_n, src_0);
    and(f_src_1, src_sel[0], src_1);
    and(f_src_2, src_sel_0_n, src_2);
    and(f_src_3, src_sel[0], src_3);
    or(f_src_01, f_src_0, f_src_1);
    or(f_src_23, f_src_2, f_src_3);
    and(f_src_a, f_src_01, src_sel_1_n);
    and(f_src_b, f_src_23, src_sel[1]);
    or(channel, f_src_a, f_src_b);
    
endmodule
