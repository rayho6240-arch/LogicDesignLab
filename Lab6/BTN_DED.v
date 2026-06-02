
//for implement
`define CYCLE_50 26'd624999

//for simulation
//`define CYCLE_50 26'd10 // 模擬時只要 10 個 clock 就通過
module BTN_DEB (
    input clk, rst,
    input btn,
    output btn_deb
);

localparam stable0  = 3'b000;
localparam unstable = 3'b001;
localparam stable1  = 3'b011;

 


reg [2:0] ns, cs;
reg [24:0] timer_50ms;

wire passed_50ms;
assign passed_50ms = (timer_50ms == `CYCLE_50);

// --- Timer 計數邏輯 ---
always @(posedge clk or posedge rst) begin
    if (rst) 
        timer_50ms <= 25'd0;
    
    else if (cs == unstable) begin
        if (passed_50ms)
            timer_50ms <= 25'd0;
            
        else if (btn) 
            timer_50ms <= timer_50ms + 25'd1;
            
        else    
            timer_50ms <= 25'd0;
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
        cs <= ns; 
end
    
// --- FSM 下一個狀態邏輯 ---
always @(*) begin
    case(cs)
        stable0 : 
            ns = (btn) ? unstable : stable0;
            
        unstable: 
            ns = passed_50ms ? stable1 : unstable  ;
            
        stable1 : 
            ns = (~btn) ? unstable : stable1;
            
        default : 
            ns = stable0;
    endcase
end     

// 補上遺漏的輸出賦值
assign btn_deb = (cs == stable1);

endmodule