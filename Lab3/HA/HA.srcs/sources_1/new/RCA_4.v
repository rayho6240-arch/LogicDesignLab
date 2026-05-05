`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 16:51:24
// Design Name: 
// Module Name: RCA_4
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


module RCA_4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output Cout
    );
    
    wire c1, c2, c3; 
    
    FA S1(
        .A(A[0]),
        .B(B[0]),
        .Cin(Cin),   
        .Sum(Sum[0]),  
        .Cout(c1)   
    );
    
    FA S2(
        .A(A[1]),
        .B(B[1]),
        .Cin(c1),
        .Sum(Sum[1]),  
        .Cout(c2)     
    );
        
    FA S3(
        .A(A[2]),
        .B(B[2]),
        .Cin(c2),
        .Sum(Sum[2]),  
        .Cout(c3)     
    );
    
    FA S4(
        .A(A[3]),
        .B(B[3]),
        .Cin(c3),     
        .Sum(Sum[3]),  
        .Cout(Cout)   
    );
    
endmodule
