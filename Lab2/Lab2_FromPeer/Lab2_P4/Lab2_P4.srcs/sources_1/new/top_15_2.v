`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/17 00:28:36
// Design Name: 
// Module Name: top_15_2
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


module top_15_2(
    input [15:1] in,
    output [3:0] BCD,
    output [6:0] out_1, out_0
    );
    
    Encoder_15 m1(
    .in(in),
    .BCD(BCD)
    );
    
    Decoder_7S2 m2(
    .BCD(BCD),
    .out_1(out_1),
    .out_0(out_0)
    );
    
endmodule
