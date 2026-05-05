`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 23:41:35
// Design Name: 
// Module Name: CLA_16
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


module CLA_16(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output PG,     
    output GG,      
    output [15:0] Sum
);

wire [3:0] P, G;
wire [4:1] C;

CLL_4 cll (
    .P(P),
    .G(G),
    .Cin(Cin),
    .C(C), //include C4
    .PG(PG),
    .GG(GG)
);

CLA_4 bit0(.A(A[3:0]),.B(B[3:0]),.Cin(Cin),.Sum(Sum[3:0]),.PG(P[0]),.GG(G[0]));
CLA_4 bit1(.A(A[7:4]),.B(B[7:4]),.Cin(C[1]),.Sum(Sum[7:4]),.PG(P[1]),.GG(G[1]));
CLA_4 bit2(.A(A[11:8]),.B(B[11:8]),.Cin(C[2]),.Sum(Sum[11:8]),.PG(P[2]),.GG(G[2]));
CLA_4 bit3(.A(A[15:12]),.B(B[15:12]),.Cin(C[3]),.Sum(Sum[15:12]),.PG(P[3]),.GG(G[3]));

endmodule
