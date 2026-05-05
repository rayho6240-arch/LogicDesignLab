
`define CYCLE_200S  28'd249_999_999  // 2秒
`define CYCLE_100S  28'd124_999_999  // 1秒
`define CYCLE_050S  28'd62_499_999   // 0.5秒
`define CYCLE_025S  28'd31_249_999   // 0.25秒
`define CYCLE_50    25'd31249999     // 50ms 的防彈跳計數值


module control_Marquee(
    input clk,
    input rst,
    input  [1:0] slc,     
    output [3:0] led,     
    output [3:0] modeLed  
);

    localparam speed0 = 2'd0;
    localparam speed1 = 2'd1; 
    localparam speed2 = 2'd2; 
    localparam speed3 = 2'd3; 

    localparam A = 3'd0, B = 3'd1, C = 3'd2, D = 3'd3, E = 3'd4, F = 3'd5;
    
    reg [2:0] cs, ns;
    reg [27:0] timer;     
    reg [1:0] mode;       


    wire [1:0] slc_deb;   // 存放防彈跳後的訊號
    wire [1:0] slc_pulse; // 存放單脈衝訊號

    // slc[0] (Speed up)
    BTN_DEB   deb_btn0 (
        .clk(clk), 
        .rst(rst), 
        .btn(slc[0]),     
        .btn_deb(slc_deb[0])
    );
    
    Pulse_GEN pul_btn0 (
        .clk(clk), 
        .rst(rst), 
        .in(slc_deb[0]),  
        .out(slc_pulse[0])
    );

    // slc[1] (Slow down)
    BTN_DEB   deb_btn1 (
        .clk(clk), 
        .rst(rst), 
        .btn(slc[1]),     
        .btn_deb(slc_deb[1])
    );
    Pulse_GEN pul_btn1 (
        .clk(clk), 
        .rst(rst), 
        .in(slc_deb[1]),  
        .out(slc_pulse[1])
    );


    wire speed_up   = slc_pulse[0];
    wire slow_down  = slc_pulse[1];



    // Speed Mode Control
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            mode <= speed0;  
        end else begin
            if (speed_up && mode < speed3)
                mode <= mode + 1;
            else if (slow_down && mode > speed0)
                mode <= mode - 1;
        end
    end

    //marquee logic
    wire [27:0] current_limit = 
        (mode == speed0) ? `CYCLE_200S :
        (mode == speed1) ? `CYCLE_100S :
        (mode == speed2) ? `CYCLE_050S : `CYCLE_025S;
                
    wire time_up = (timer >= current_limit);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            timer <= 28'd0;
        end else if (time_up) begin
            timer <= 28'd0;
        end else begin
            timer <= timer + 28'd1;
        end
    end


    // maquree (FSM)
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


    // Output Logic
    reg [3:0] led_out;
    always @(*) begin
        case(cs)
            A: led_out = 4'b0001; 
            B: led_out = 4'b0010;
            C: led_out = 4'b0100;
            D: led_out = 4'b1000; 
            E: led_out = 4'b0100;
            F: led_out = 4'b0010;
            default: led_out = 4'b0001;
        endcase
    end
    assign led = led_out;

    reg [3:0] modeLed_out;
    always @(*) begin
        case(mode)
            speed0: modeLed_out = 4'b0001; 
            speed1: modeLed_out = 4'b0010; 
            speed2: modeLed_out = 4'b0100; 
            speed3: modeLed_out = 4'b1000; 
            default: modeLed_out = 4'b0001;
        endcase
    end
    assign modeLed = modeLed_out;

endmodule
