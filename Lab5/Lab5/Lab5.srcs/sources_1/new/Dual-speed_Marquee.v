

`define CYCLE_050S  26'd62499999  // 0.5秒的計數值
`define CYCLE_025S  26'd31249999  // 0.25秒的計數值

module DualSpeed_Marquee (
    input clk, rst,
    output [3:0] led,
    output led4_g, led5_g 
);

    // 狀態定義
    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    reg [2:0] cs, ns;      
    reg [25:0] timer_8ns;  
    reg round;             
    
    wire passed_quar;
    

    wire [25:0] target_count = (round == 0) ? (`CYCLE_050S) : `CYCLE_025S;
    assign passed_quar = (timer_8ns >= target_count);

    // --- round fsm 偵測一圈結束就，切換速度mode ---
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            round <= 1'b0;
        end 
        else if (passed_quar && cs == F) begin
            round <= ~round; // 跑完一整圈 A->F，回到 A 之前翻轉模式
        end
    end

    // LED 輸出邏輯 
    assign led = (cs == A) ? 4'b0001 : 
                 (cs == B) ? 4'b0010 : 
                 (cs == C) ? 4'b0100 :
                 (cs == D) ? 4'b1000 :
                 (cs == E) ? 4'b0100 :
                 (cs == F) ? 4'b0010 : 4'b0001;
                 
    // 題目要求的指示燈邏輯
    assign led4_g = (round == 0); // 第一輪輸出 1
    assign led5_g = (round == 1); // 第二輪輸出 1

    // 狀態暫存器 
    always @(posedge clk or posedge rst) begin
        if (rst) cs <= A;
        else     cs <= ns;
    end

    // 次態邏輯 
    always @(*) begin
        case (cs)
            A : ns = (passed_quar) ? B : A;
            B : ns = (passed_quar) ? C : B;
            C : ns = (passed_quar) ? D : C;
            D : ns = (passed_quar) ? E : D;
            E : ns = (passed_quar) ? F : E;   
            F : ns = (passed_quar) ? A : F;        
            default : ns = A;
        endcase
    end

    // 計時器邏輯
    always @(posedge clk or posedge rst) begin
        if (rst)
            timer_8ns <= 26'd0;
        else if (passed_quar)
            timer_8ns <= 26'd0;
        else
            timer_8ns <= timer_8ns + 26'd1;
    end

endmodule




/*
`define CYCLE_050S  26'd62499999  // 0.5秒的計數值
`define CYCLE_025S  26'd31249999  // 0.25秒的計數值

module DualSpeed_Marquee(
    input clk, rst,
    output [3:0] led,
    output led4_g, led5_g    //新增
    );

    // 
    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;

    reg [2:0] cs, ns;
    reg [25:0] timer;
    reg round; 

    
    wire [25:0] current_limit = (round == 0) ? `CYCLE_050S : `CYCLE_025S;
    wire time_up = (timer >= current_limit);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            timer <= 26'd0;
            round <= 1'b0;
        end 
        
        else if (time_up) begin
            timer <= 26'd0;
            if (cs == F) round <= ~round; 
        end 
        
        else begin
            timer <= timer + 26'd1;
        end
    end

    // --- FSM ---
    always @(posedge clk or posedge rst) begin
        if (rst) cs <= A;
        else if (time_up) cs <= ns;
    end

    always @(*) begin
        case (cs)
            A : ns = B;
            B : ns = C;
            C : ns = D;
            D : ns = E;
            E : ns = F;
            F : ns = A;
            default : ns = A;
        endcase
    end

    // ---  輸出邏輯 ---
    // 跑馬燈 LED
    assign led = (cs == A) ? 4'b0001 :
                 (cs == B) ? 4'b0010 :
                 (cs == C) ? 4'b0100 :
                 (cs == D) ? 4'b1000 :
                 (cs == E) ? 4'b0100 :
                 (cs == F) ? 4'b0010 : 4'b0001;

    // Round LED
    assign led4_g = (round == 0); // 第一輪亮
    assign led5_g = (round == 1); // 第二輪亮

endmodule
*/
