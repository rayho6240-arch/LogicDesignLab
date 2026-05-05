`define CYCLE_50 25'd31249999

module BTN_DEB (
    input clk, rst,
    input btn,
    output btn_deb
);

localparam stable0  = 2'b00;
localparam unstable = 2'b01;
localparam stable1  = 2'b11; 

// 修正 1：補上位元寬度
reg [1:0] ns, cs;
reg [24:0] timer_50ms;

wire passed_50ms;
assign passed_50ms = (timer_50ms == `CYCLE_50);

// --- Timer 計數邏輯 ---
always @(posedge clk or posedge rst) begin
    if (rst) 
        timer_50ms <= 25'd0;
    // 修正 5：只有在 unstable 狀態才計數，否則歸零
    else if (cs == unstable) begin
        if (passed_50ms)
            timer_50ms <= 25'd0;
        else  
            timer_50ms <= timer_50ms + 25'd1;
    end 
    else begin
        timer_50ms <= 25'd0;
    end
end
    
// --- FSM 狀態暫存器 ---
always @(posedge clk or posedge rst) begin
    if (rst) 
        cs <= stable0;
    else     
        cs <= ns; // 修正 3：移除不必要的 lastState，保持簡潔
end
    
// --- FSM 下一個狀態邏輯 ---
always @(*) begin
    case(cs)
        stable0 : 
            ns = (btn) ? unstable : stable0;
            
        unstable: 
            // 修正 4：計時滿 50ms 後，直接檢查 btn 的「真實狀態」
            // 若 btn 還是 1，代表真的按下了 (stable1)
            // 若 btn 變回 0，代表只是雜訊，退回 stable0
            ns = (passed_50ms) ? (btn ? stable1 : stable0) : unstable;
            
        stable1 : 
            ns = (~btn) ? unstable : stable1;
            
        default : 
            ns = stable0;
    endcase
end     

// 補上遺漏的輸出賦值
assign btn_deb = (cs == stable1);

endmodule