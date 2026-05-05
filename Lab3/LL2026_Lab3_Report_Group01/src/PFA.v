`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 17:49:54
// Design Name: 
// Module Name: PFA
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


module PFA(
    input A,
    input B,
    input Cin,
    output P,
    output G,
    output Sum
);

    assign P = A ^ B;
    assign G = A & B;
    assign Sum = P ^ Cin;

endmodule
