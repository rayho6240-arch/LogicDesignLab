`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/16 23:30:53
// Design Name: 
// Module Name: Encoder_9
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


module Encoder_9(
    input [9:1] in,
    output reg [3:0] BCD
    );
    
always@(*) begin
    if(in[9])      BCD = 4'd9;
    else if(in[8]) BCD = 4'd8;
    else if(in[7]) BCD = 4'd7;
    else if(in[6]) BCD = 4'd6;
    else if(in[5]) BCD = 4'd5;
    else if(in[4]) BCD = 4'd4;
    else if(in[3]) BCD = 4'd3;
    else if(in[2]) BCD = 4'd2;
    else if(in[1]) BCD = 4'd1;
    else BCD = 4'd0;
end

endmodule
