module Top (
  input clk,
  input rst,
  input [3:0] btn,
  output [31:0] matrix,
  output [3:0] display_HP,
  output [2:0] collision
);
// ...
endmodule
/*
Pin mapping 
matrix[0]   | ◯◯◯◯◯◯◯◯ matrix[15]
matrix[1]   i ◯◯◯◯◯◯◯◯ matrix[14]
matrix[2]   5 ◯◯◯◯◯◯◯◯ matrix[13]
matrix[3]   8 ◯◯◯◯◯◯◯◯ matrix[12]
matrix[4]   8 ◯◯◯◯◯◯◯◯ matrix[11]
matrix[5]   A ◯◯◯◯◯◯◯◯ matrix[10]
matrix[6]   W ◯◯◯◯◯◯◯◯ matrix[9 ]
matrix[7]   | ◯◯◯◯◯◯◯◯ matrix[8 ]
-----------------------------------------
matrix[16]  | ◯◯◯◯◯◯◯◯ matrix[31]
matrix[17]  i ◯◯◯◯◯◯◯◯ matrix[30]
matrix[18]  5 ◯◯◯◯◯◯◯◯ matrix[29]
matrix[19]  8 ◯◯◯◯◯◯◯◯ matrix[28]
matrix[20]  8 ◯◯◯◯◯◯◯◯ matrix[27]
matrix[21]  A ◯◯◯◯◯◯◯◯ matrix[26]
matrix[22]  W ◯◯◯◯◯◯◯◯ matrix[25]
matrix[23]  | ◯◯◯◯◯◯◯◯ matrix[24]
*/