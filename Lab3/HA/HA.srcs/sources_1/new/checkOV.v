`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/04/15 09:12:47
// Design Name: 
// Module Name: checkOV
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


module checkOV(
    input AsignBit,
    input BsignBit,
    input SumsignBit,
    output OV
    );
    
    assign OV = (AsignBit == BsignBit) & (SumsignBit != AsignBit);
    
endmodule
