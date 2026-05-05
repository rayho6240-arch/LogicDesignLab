`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/15 09:11:27
// Design Name: 
// Module Name: PreOP
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


module PreOp(
    input [7:0] B,
    input OP,
    output [7:0] newB,
    output Cout
    );


    assign newB = OP ? ~B : B; 
    assign Cout = OP;
    
   
endmodule