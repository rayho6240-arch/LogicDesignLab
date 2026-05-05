`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/05 08:48:22
// Design Name: 
// Module Name: counter_4
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


module counter_4(
    input clk,
    input rst,
    output reg [3:0]counter
    );
    
    
    always@(posedge clk)begin
    
        if(rst)
            counter<=4'd0; 
        else 
            counter <= counter + 4'd1; //for overflow case it will let these four bit be 0000
    
    end
    
    
endmodule
