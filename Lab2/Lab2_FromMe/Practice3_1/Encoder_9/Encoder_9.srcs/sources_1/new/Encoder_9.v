`timescale 1ns / 1ps

module Encoder_9(
    input [8:0] in,      // 配合 Testbench 的 reg [8:0] in
    output reg [3:0] BCD
    );

    always @(*) begin
        // 優先權編碼邏輯：由高位元往低位元判斷
        // 假設 in[8] 為最高優先級，對應數字 9 (或依實驗手冊定義)
        if (in[8]) begin
            BCD = 4'd9;
        end else if (in[7]) begin
            BCD = 4'd8;
        end else if (in[6]) begin
            BCD = 4'd7;
        end else if (in[5]) begin
            BCD = 4'd6;
        end else if (in[4]) begin
            BCD = 4'd5;
        end else if (in[3]) begin
            BCD = 4'd4;
        end else if (in[2]) begin
            BCD = 4'd3;
        end else if (in[1]) begin
            BCD = 4'd2;
        end else if (in[0]) begin
            BCD = 4'd1;
        end else begin
            BCD = 4'd0; // 沒有任何按鍵按下時輸出 0
        end 
    end

endmodule