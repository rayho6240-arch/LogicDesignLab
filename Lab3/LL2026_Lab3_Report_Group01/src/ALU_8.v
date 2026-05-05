`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/15 13:49:52
// Design Name: 
// Module Name: ALU_8
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


module ALU_8(
    input [7:0] A,
    input [7:0] B,
    input OP,
    output [7:0] Sum,
    output OV
    );
    
    
    wire [7:0] preNewB;
    wire preCout;
    PreOp preprocessing(
        .B(B),
        .OP(OP),
        .newB(preNewB),
        .Cout(preCout)
    );
    
    
    Adder_8_OV adder(
        .A(A),
        .B(preNewB),
        .Cin(preCout),
        .Sum(Sum),
        .OV(OV)
    );
    
   
    
endmodule
