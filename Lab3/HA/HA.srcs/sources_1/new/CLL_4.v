`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 18:02:17
// Design Name: 
// Module Name: CLL_4
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

module CLL_4(
    input [3:0] P,
    input [3:0] G,
    input Cin,
    output [4:1] C, //包含了最終的進位(c4)
    output PG,
    output GG
);

    assign C[1] = G[0] | (P[0] & Cin);
    
    assign C[2] = G[1]
                 | (P[1] & G[0])
                 | (P[1] & P[0] & Cin);

    assign C[3] = G[2]
                 | (P[2] & G[1])
                 | (P[2] & P[1] & G[0])
                 | (P[2] & P[1] & P[0] & Cin);

    assign C[4] = G[3]
                 | (P[3] & G[2])
                 | (P[3] & P[2] & G[1])
                 | (P[3] & P[2] & P[1] & G[0])
                 | (P[3] & P[2] & P[1] & P[0] & Cin);


// group propagate
    assign PG = P[0] & P[1] & P[2] & P[3];
// group generate
    assign GG = G[3]
              | (P[3] & G[2])
              | (P[3] & P[2] & G[1])
              | (P[3] & P[2] & P[1] & G[0]);

endmodule
