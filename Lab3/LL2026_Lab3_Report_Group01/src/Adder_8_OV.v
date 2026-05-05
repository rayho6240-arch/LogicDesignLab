`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/15 09:11:27
// Design Name: 
// Module Name: Adder_8_OV
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


module Adder_8_OV(
    input [7:0] A,
    input [7:0] B,
    input Cin,
    output [7:0] Sum,
    output OV
    );
    
    wire Cout;
    RCA_8 signAdder(
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
    
    
    checkOV checker(
        .AsignBit(A[7]),
        .BsignBit(B[7]),
        .SumsignBit(Sum[7]),
        .OV(OV)
    );

    
endmodule
