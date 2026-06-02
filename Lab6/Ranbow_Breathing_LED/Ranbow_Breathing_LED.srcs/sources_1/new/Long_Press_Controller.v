module Long_Press_Controller (
    input clk,          // 125MHz
    input rst,
    input btn_deb,      // 來自防彈跳模組的穩定訊號
    output reg out_pulse
);

    // 定義時間參數 (以 125MHz 為例)
    //for implement
    parameter LONG_PRESS_THRESHOLD = 28'd125_000_000; // 0.5 秒判定為長按
    parameter REPEAT_INTERVAL      = 28'd50_000_000; // 長按時每 0.4 秒跳一次
    //for simulation
    //parameter LONG_PRESS_THRESHOLD = 28'd100; // 0.5 秒判定為長按
    //parameter REPEAT_INTERVAL      = 28'd40; // 長按時每 0.4 秒跳一次
    reg [27:0] timer;
    reg long_press_mode; // 是否已進入長按連發狀態

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            timer <= 28'd0;
            out_pulse <= 1'b0;
            long_press_mode <= 1'b0;
        end 
        else begin
            if (btn_deb) begin
                if (!long_press_mode) begin
                    // 階段 1：剛按下或正在等待進入長按
                    if (timer == 28'd0) begin
                        out_pulse <= 1'b1; // 按下瞬間發出第一個脈波
                        timer <= timer + 28'd1;
                    end else if (timer >= LONG_PRESS_THRESHOLD) begin
                        out_pulse <= 1'b1; // 達到 0.5s，發出長按後第一個連發脈波
                        timer <= 28'd1;    // 重置計數器給連發間隔用
                        long_press_mode <= 1'b1;
                    end else begin
                        out_pulse <= 1'b0;
                        timer <= timer + 28'd1;
                    end
                end else begin
                    // 階段 2：已經在連發模式
                    if (timer >= REPEAT_INTERVAL) begin
                        out_pulse <= 1'b1;
                        timer <= 28'd1;
                    end else begin
                        out_pulse <= 1'b0;
                        timer <= timer + 28'd1;
                    end
                end
            end 
            else begin
                // 按鍵放開，全部重置
                timer <= 28'd0;
                out_pulse <= 1'b0;
                long_press_mode <= 1'b0;
            end
        end
    end
endmodule