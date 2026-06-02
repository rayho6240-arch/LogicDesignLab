`timescale 1ns / 1ps
//for implement
`define CYCLE_20 28'd250000000
`define CYCLE_10 28'd125000000
`define CYCLE_05 28'd62500000
`define CYCLE_025 28'd31250000

//for simulation
//`define CYCLE_20   28'd4000    // 模式0：4000個 clk 換色
//`define CYCLE_10   28'd2000    // 模式1：2000個 clk 換色
//`define CYCLE_05   28'd1000    // 模式2：1000個 clk 換色
//`define CYCLE_025  28'd500     // 模式3：500個 clk 換色 (極速)

module Speed_rainbow_breath (
    input clk, //125hz
    input rst,
    input [1:0] btn,
    output led_r,led_g,led_b,
    output [3:0] led
);
localparam RED = 3'd0, ORANGE = 3'd1, YELLOW = 3'd2, GREEN = 3'd3, 
               BLUE = 3'd4, PURPLE = 3'd5, WHITE = 3'd6;
reg [2:0] cs, ns;
reg [7:0] phase_counter;
reg [7:0] threshold_b, threshold_g, threshold_r;
reg [27:0] timer;
reg [27:0] step_timer; 

reg [27:0]color_limit; 
reg [27:0]dim_limit; 
reg [27:0] step_limit; // 動態步進限制

wire passed_color_limit;
wire passed_dim_limit;
wire pass_step; 
assign passed_color_limit  = (timer >= color_limit); 
assign passed_dim_limit = (timer >= dim_limit);
assign pass_step   = (step_timer >= step_limit);

reg [7:0] bright_threshold;
reg [2:0] mode;

wire [1:0] btn_deb;
//wire [1:0] btn_gen;
wire [1:0] btn_long_pulse;
BTN_DEB deb0(
    .clk(clk), 
    .rst(rst),
    .btn(btn[0]),
    .btn_deb(btn_deb[0])
);
Long_Press_Controller lp0 (
    .clk(clk),
    .rst(rst),
    .btn_deb(btn_deb[0]),
    .out_pulse(btn_long_pulse[0])
);
/*Pulse_GEN gen0(
    .clk(clk), 
    .rst(rst),
    .in(btn_deb[0]),
    .out(btn_gen[0])
);*/

BTN_DEB deb1(
    .clk(clk), 
    .rst(rst),
    .btn(btn[1]),
    .btn_deb(btn_deb[1])
);
Long_Press_Controller lp1 (
    .clk(clk),
    .rst(rst),
    .btn_deb(btn_deb[1]),
    .out_pulse(btn_long_pulse[1])
);

/*Pulse_GEN gen1(
    .clk(clk), 
    .rst(rst),
    .in(btn_deb[1]),
    .out(btn_gen[1])
);*/





always@(posedge clk or posedge rst)begin
    if(rst)begin
        mode<=3'd0;
    end
    else if (btn_long_pulse[0])begin
        if(mode<3'd3)   mode<=mode+1;
    end
    else if (btn_long_pulse[1])begin
        if(mode>3'd0)   mode<=mode-1;
    end
end


// 2. 動態調整時間與步進 (修正呼吸速度)
always @(*) begin
    case(mode)
        3'd0: begin color_limit = `CYCLE_20;  step_limit = `CYCLE_20 / 200; end
        3'd1: begin color_limit = `CYCLE_10;  step_limit = `CYCLE_10 / 200; end
        3'd2: begin color_limit = `CYCLE_05;  step_limit = `CYCLE_05 / 200; end
        3'd3: begin color_limit = `CYCLE_025; step_limit = `CYCLE_025 / 200; end
        default: begin color_limit = `CYCLE_20; step_limit = `CYCLE_20 / 200; end
    endcase
    dim_limit = color_limit >> 1; // 除以 2
end



// 總計時器邏輯
always @(posedge clk or posedge rst) begin
    if (rst) 
        timer <= 27'd0;
    else if (passed_color_limit)
        timer <= 27'd0;
    else 
        timer <= timer + 27'd1;
end

// --- 步進計數器邏輯 ---
always @(posedge clk or posedge rst) begin
    if (rst) begin
        step_timer <= 27'd0;
    end else if (passed_color_limit || pass_step) begin
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
    else if (passed_color_limit) begin
        bright_threshold <= 8'd0; // 換色時重置亮度，從暗開始變亮
    end 
    else if (pass_step) begin
        if (!passed_dim_limit) begin // 前 0.5 秒：漸亮
            if (bright_threshold < 8'd100)
                bright_threshold <= bright_threshold + 8'd1;
        end else begin         // 後 0.5 秒：漸暗
            if (bright_threshold > 8'd0)
                bright_threshold <= bright_threshold - 8'd1;
        end
    end
end


// PWM 相位計數器(rgb分配)
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
        RED    : ns = (passed_color_limit) ? ORANGE : RED;
        ORANGE : ns = (passed_color_limit) ? YELLOW : ORANGE;
        YELLOW : ns = (passed_color_limit) ? GREEN  : YELLOW;
        GREEN  : ns = (passed_color_limit) ? BLUE   : GREEN;
        BLUE   : ns = (passed_color_limit) ? PURPLE : BLUE;
        PURPLE : ns = (passed_color_limit) ? WHITE  : PURPLE; 
        WHITE  : ns = (passed_color_limit) ? RED    : WHITE;
        default: ns = RED;
   endcase
end


// 狀態切換(rgb分配)
always@(posedge clk or posedge rst)begin
    if(rst)
        cs<=RED;
    else
        cs<=ns;
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


assign led_b = ((phase_counter < threshold_b) && (phase_counter < bright_threshold));
assign led_g = ((phase_counter < threshold_g) && (phase_counter < bright_threshold));
assign led_r = ((phase_counter < threshold_r) && (phase_counter < bright_threshold));


assign led = (mode == 3'd0) ? 4'b0001 :
             (mode == 3'd1) ? 4'b0010 :
             (mode == 3'd2) ? 4'b0100 :
             (mode == 3'd3) ? 4'b1000 : 4'b0000;


endmodule