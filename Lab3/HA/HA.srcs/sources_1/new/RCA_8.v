`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 16:59:11
// Design Name: 
// Module Name: RCA_8
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


module RCA_8(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Sum,
    output Cout
    );
    
    wire c1, cx;
    
    RCA_4 lowerFour(
        .A(A[3:0]),
        .B(B[3:0]),
        .Cin(Cin),
        .Sum(Sum[3:0]),
        .Cout(c1)
    );
    RCA_4 higherFour(
        .A(A[7:4]),
        .B(B[7:4]),
        .Cin(c1),
        .Sum(Sum[7:4]),
        .Cout(Cout)
    );
    
endmodule
