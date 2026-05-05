`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/14 16:39:30
// Design Name: 
// Module Name: FA
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

module FA(
    input A,
    input B,
    input Cin,
    output Sum,  
    output Cout  
    );
    
    wire c1, c2, f;
      
    HA HAfirst(
        .A(A),
        .B(B),
        .Sum(c1),
        .Cout(c2)
    );
    

    HA HASecond(
        .A(c1),
        .B(Cin), 
        .Sum(Sum),
        .Cout(f)
    );
        
    or(Cout, c2, f);
    
endmodule