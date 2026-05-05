`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/03/16 23:10:50
// Design Name: 
// Module Name: Decoder_7S2
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


module Decoder_7S2(
    input [3:0] BCD,
    output reg [6:0] out_1, out_0
    );
    
localparam S7_0 = 7'b0000001;
localparam S7_1 = 7'b1001111;
localparam S7_2 = 7'b0010010;
localparam S7_3 = 7'b0000110;
localparam S7_4 = 7'b1001100;
localparam S7_5 = 7'b0100100;
localparam S7_6 = 7'b0100000;
localparam S7_7 = 7'b0001111;
localparam S7_8 = 7'b0000000;
localparam S7_9 = 7'b0000100;    
    
always@(*) begin
    case(BCD)
      4'd0: begin
          out_1 = S7_0;
          out_0 = S7_0;
      end

      4'd1: begin
          out_1 = S7_0;
          out_0 = S7_1;
      end
      
      4'd2: begin
          out_1 = S7_0;
          out_0 = S7_2;
      end
      
      4'd3: begin
          out_1 = S7_0;
          out_0 = S7_3;
      end
      
      4'd4: begin
          out_1 = S7_0;
          out_0 = S7_4;
      end

      4'd5: begin
          out_1 = S7_0;
          out_0 = S7_5;
      end

      4'd6: begin
          out_1 = S7_0;
          out_0 = S7_6;
      end
      
      4'd7: begin
          out_1 = S7_0;
          out_0 = S7_7;
      end
      
      4'd8: begin
          out_1 = S7_0;
          out_0 = S7_8;
      end
      
      4'd9: begin
          out_1 = S7_0;
          out_0 = S7_9;
      end
      
      4'd10: begin
          out_1 = S7_1;
          out_0 = S7_0;
      end
      
      4'd11: begin
          out_1 = S7_1;
          out_0 = S7_1;
      end
      
      4'd12: begin
          out_1 = S7_1;
          out_0 = S7_2;
      end
      
      4'd13: begin
          out_1 = S7_1;
          out_0 = S7_3;
      end
      
      4'd14: begin
          out_1 = S7_1;
          out_0 = S7_4;
      end
      
      default: begin
          out_1 = S7_1;
          out_0 = S7_5;
      end
    endcase
end

endmodule
