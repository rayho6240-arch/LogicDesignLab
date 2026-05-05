`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/16 22:41:33
// Design Name: 
// Module Name: Decorder_7S1
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


module Decoder_7S1(
    input [3:0] BCD,
    output reg [6:0] out
    );
    
localparam S7_0 = 7'b0000001;
localparam S7_1 = 7'b1001111;
localparam S7_2 = 7'b0010010;
localparam S7_3 = 7'b0000110;
localparam S7_4 = 7'b1001100;
localparam S7_5 = 7'b0100100;
localparam S7_6 = 7'b0100000;
localparam S7_7 = 7'b0001111;
localparam S7_8 = 7'b0000000;
localparam S7_9 = 7'b0000100;
localparam S7_A = 7'b0001000;
localparam S7_b = 7'b1100000;
localparam S7_c = 7'b1110010;
localparam S7_d = 7'b1000010;
localparam S7_E = 7'b0110000;
localparam S7_F = 7'b0111000;
    
always@(*)begin
    if (BCD == 4'd0)         out = S7_0;
    else if (BCD == 4'd1)    out = S7_1;
    else if (BCD == 4'd2)    out = S7_2;
    else if (BCD == 4'd3)    out = S7_3;
    else if (BCD == 4'd4)    out = S7_4;
    else if (BCD == 4'd5)    out = S7_5;
    else if (BCD == 4'd6)    out = S7_6;
    else if (BCD == 4'd7)    out = S7_7;
    else if (BCD == 4'd8)    out = S7_8;
    else if (BCD == 4'd9)    out = S7_9;
    else if (BCD == 4'd10)   out = S7_A;
    else if (BCD == 4'd11)   out = S7_b;
    else if (BCD == 4'd12)   out = S7_c;
    else if (BCD == 4'd13)   out = S7_d;
    else if (BCD == 4'd14)   out = S7_E;
    else                     out = S7_F;
end

endmodule
