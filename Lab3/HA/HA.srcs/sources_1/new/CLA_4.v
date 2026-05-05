`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 21:58:22
// Design Name: 
// Module Name: CLA_4
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
module CLA_4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] Sum,
    output PG,
    output GG
);

wire [3:0] P, G;
wire [4:1] C;

// =====================
// CLL（算 carry）
CLL_4 cll (
    .P(P),
    .G(G),
    .Cin(Cin),
    .C(C),
    .PG(PG),
    .GG(GG)
);

// =====================
// PFA （算 Sum）
PFA fa0(.A(A[0]), .B(B[0]), .Cin(Cin),  .P(P[0]), .G(G[0]), .Sum(Sum[0]));
PFA fa1(.A(A[1]), .B(B[1]), .Cin(C[1]), .P(P[1]), .G(G[1]), .Sum(Sum[1]));
PFA fa2(.A(A[2]), .B(B[2]), .Cin(C[2]), .P(P[2]), .G(G[2]), .Sum(Sum[2]));
PFA fa3(.A(A[3]), .B(B[3]), .Cin(C[3]), .P(P[3]), .G(G[3]), .Sum(Sum[3]));

endmodule
