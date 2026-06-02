`timescale 1ns / 1ps

//for implement 
`define CYCLE_10 27'd124999999
`define CYCLE_05 27'd62499999
`define CYCLE_STEP 27'd624999  // 0.5s 要走完 100 階，所以每階是 624999 cycles

// for simulation
//`define CYCLE_10   27'd5000    // 5000 個 clk 就換色 (50us)
//`define CYCLE_05   27'd2500    // 2500 個 clk 開始變暗
//`define CYCLE_STEP 27'd25      // 25 個 clk 亮度就加 1 (呼吸一輪只要 50us)


module OneRGB (
    input clk, rst,
    output led_b, led_g, led_r
);

reg [2:0] cs, ns;
reg [7:0] phase_counter;
reg [7:0] threshold_b, threshold_g, threshold_r;

reg [26:0] timer;
// 新增一個專門控制步進的計數器，避免使用 % 運算
reg [26:0] step_timer; 

wire passed_1s;
wire passed_05s;
wire pass_01s; // 雖然名字叫 01s，但我們維持你的命名，實際功能是步進觸發

assign passed_1s  = (timer >= `CYCLE_10); 
assign passed_05s = (timer >= `CYCLE_05);
// 當 step_timer 數到目標值時，觸發一個 clk 的高位準
assign pass_01s   = (step_timer == `CYCLE_STEP); 

reg [7:0] bright_threshold;

localparam RED    = 3'd0;
localparam ORANGE = 3'd1;
localparam YELLOW = 3'd2;
localparam GREEN  = 3'd3; 
localparam BLUE   = 3'd4; 
localparam PURPLE = 3'd5;
localparam WHITE  = 3'd6;

// --- 步進計數器邏輯 ---
always @(posedge clk or posedge rst) begin
    if (rst) begin
        step_timer <= 27'd0;
    end else if (passed_1s || pass_01s) begin
        step_timer <= 27'd0;
    end else begin
        step_timer <= step_timer + 27'd1;
    end
end

// --- 修改部分：呼吸亮度控制 ---
always @(posedge clk or posedge rst) begin
    if (rst) begin
        bright_threshold <= 8'd0;
    end 
    else if (passed_1s) begin
        bright_threshold <= 8'd0; // 換色時重置亮度，從暗開始變亮
    end 
    else if (pass_01s) begin
        if (!passed_05s) begin // 前 0.5 秒：漸亮
            if (bright_threshold < 8'd100)
                bright_threshold <= bright_threshold + 8'd1;
        end else begin         // 後 0.5 秒：漸暗
            if (bright_threshold > 8'd0)
                bright_threshold <= bright_threshold - 8'd1;
        end
    end
end



// PWM 相位計數器
always @(posedge clk or posedge rst) begin
    if (rst) begin
        phase_counter <= 8'd0;
    end else begin
        phase_counter <= (phase_counter >= 8'd199) ? 8'd0 : phase_counter + 8'd1;
    end
end

// 狀態機下一個狀態邏輯
always @(*) begin
    case(cs)
        RED    : ns = (passed_1s) ? ORANGE : RED;
        ORANGE : ns = (passed_1s) ? YELLOW : ORANGE;
        YELLOW : ns = (passed_1s) ? GREEN  : YELLOW;
        GREEN  : ns = (passed_1s) ? BLUE   : GREEN;
        BLUE   : ns = (passed_1s) ? PURPLE : BLUE;
        PURPLE : ns = (passed_1s) ? WHITE  : PURPLE; 
        WHITE  : ns = (passed_1s) ? RED    : WHITE;
        default: ns = RED;
   endcase
end

// 總計時器邏輯
always @(posedge clk or posedge rst) begin
    if (rst) 
        timer <= 27'd0;
    else if (passed_1s)
        timer <= 27'd0;
    else 
        timer <= timer + 27'd1;
end
    
// 狀態切換
always @(posedge clk or posedge rst) begin
    if (rst)
        cs <= RED;
    else
        cs <= ns;
end

// 顏色閾值設定
always @(*) begin
    case(cs)
        RED:    begin threshold_b = 8'd0;   threshold_g = 8'd0;   threshold_r = 8'd100; end
        ORANGE: begin threshold_b = 8'd0;   threshold_g = 8'd40;  threshold_r = 8'd100; end
        YELLOW: begin threshold_b = 8'd0;   threshold_g = 8'd100; threshold_r = 8'd100; end
        GREEN:  begin threshold_b = 8'd0;   threshold_g = 8'd100; threshold_r = 8'd0;   end    
        BLUE:   begin threshold_b = 8'd100; threshold_g = 8'd0;   threshold_r = 8'd0;   end    
        PURPLE: begin threshold_b = 8'd100; threshold_g = 8'd0;   threshold_r = 8'd100; end    
        WHITE:  begin threshold_b = 8'd100; threshold_g = 8'd100; threshold_r = 8'd100; end
        default:begin threshold_b = 8'd0;   threshold_g = 8'd0;   threshold_r = 8'd0;   end
    endcase
end

// 最終輸出
assign led_b = ((phase_counter < threshold_b) && (phase_counter < bright_threshold));
assign led_g = ((phase_counter < threshold_g) && (phase_counter < bright_threshold));
assign led_r = ((phase_counter < threshold_r) && (phase_counter < bright_threshold));

endmodule