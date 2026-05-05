`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 23:15:16
// Design Name: 
// Module Name: CLA_64
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


module CLA_64(
    input [63:0] A,
    input [63:0] B,
    input Cin,
    output [63:0] Sum,
    output Cout
    );
    
    wire [3:0] P, G;
    wire [4:1]C;
    
    CLL_4 cll (
        .P(P),
        .G(G),
        .Cin(Cin),
        .C(C),
        .PG(PG),
        .GG(GG)
    );
    
    CLA_16 bit0(.A(A[15:0]),.B(B[15:0]),.Cin(Cin),.Sum(Sum[15:0]),.PG(P[0]),.GG(G[0]));
    CLA_16 bit1(.A(A[31:16]),.B(B[31:16]),.Cin(C[1]),.Sum(Sum[31:16]),.PG(P[1]),.GG(G[1]));
    CLA_16 bit2(.A(A[47:32]),.B(B[47:32]),.Cin(C[2]),.Sum(Sum[47:32]),.PG(P[2]),.GG(G[2]));
    CLA_16 bit3(.A(A[63:48]),.B(B[63:48]),.Cin(C[3]),.Sum(Sum[63:48]),.PG(P[3]),.GG(G[3]));
    
    assign Cout=C[4];
       
endmodule
