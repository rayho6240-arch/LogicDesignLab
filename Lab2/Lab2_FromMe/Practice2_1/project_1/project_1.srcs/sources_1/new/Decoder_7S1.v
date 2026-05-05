`timescale 1ns / 1ps



`define S7_0 7'b0000001
`define S7_1 7'b1001111
`define S7_2 7'b0010010
`define S7_3 7'b0000110
`define S7_4 7'b1001100
`define S7_5 7'b0100100
`define S7_6 7'b0100000
`define S7_7 7'b0001111 
`define S7_8 7'b0000000
`define S7_9 7'b0000100
`define S7_A 7'b0001000
`define S7_b 7'b1100000
`define S7_C 7'b1110010 
`define S7_d 7'b1000010
`define S7_E 7'b0110000
`define S7_F 7'b0111000

module Decoder_7S1(
    input [3:0] BCD,
    output [6:0] out  
    );

    assign out = (BCD == 4'd0) ? `S7_0 :
                 (BCD == 4'd1) ? `S7_1 :
                 (BCD == 4'd2) ? `S7_2 :
                 (BCD == 4'd3) ? `S7_3 :
                 (BCD == 4'd4) ? `S7_4 :
                 (BCD == 4'd5) ? `S7_5 :
                 (BCD == 4'd6) ? `S7_6 :
                 (BCD == 4'd7) ? `S7_7 :
                 (BCD == 4'd8) ? `S7_8 :
                 (BCD == 4'd9) ? `S7_9 :
                 (BCD == 4'd10) ? `S7_A :
                 (BCD == 4'd11) ? `S7_b : 
                 (BCD == 4'd12) ? `S7_C :
                 (BCD == 4'd13) ? `S7_d :
                 (BCD == 4'd14) ? `S7_E : `S7_F; 
                                           
endmodule