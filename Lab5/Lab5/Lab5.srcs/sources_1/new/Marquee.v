`define CYCLE_HS 25'd31249999

module Marquee (
    input clk, rst,
    output [3:0] led
);

    // 狀態定義
    localparam A = 3'd0;
    localparam B = 3'd1;
    localparam C = 3'd2;
    localparam D = 3'd3;
    localparam E = 3'd4;
    localparam F = 3'd5;

    reg [3:0] cs, ns;
    reg [24:0] timer_8ns;
    wire passed_quar;

    // LED 輸出邏輯
    assign led = (cs == A) ? 4'b0001 : 
                 (cs == B) ? 4'b0010 : 
                 (cs == C) ? 4'b0100 :
                 (cs == D) ? 4'b1000 :
                 (cs == E) ? 4'b0100 :
                 (cs == F) ? 4'b0010 : 4'b0001;

    // 判斷是否過半秒 (0.5s)
    assign passed_quar = (timer_8ns == `CYCLE_HS);

    // 狀態暫存器 (Current State Register)
    always @(posedge clk or posedge rst) begin
        
        if (rst) 
            cs <= A;
        else     
            cs <= ns;
    end

    // 次態邏輯 (Next State Logic)
    always @(*) begin
        case (cs)
            A   : ns = (passed_quar) ? B : A;
            B   : ns = (passed_quar) ? C : B;
            C   : ns = (passed_quar) ? D : C;
            D   : ns = (passed_quar) ? E : D;
            E   : ns = (passed_quar) ? F : E;   
            F   : ns = (passed_quar) ? A : F;        
            default : ns = A;
        endcase
    end

    // 計時器邏輯 (Timer Logic)
    always @(posedge clk or posedge rst) begin
        if (rst)
            timer_8ns <= 25'd0;
        else if (passed_quar)
            timer_8ns <= 25'd0;
        else
            timer_8ns <= timer_8ns + 25'd1;
    end

endmodule