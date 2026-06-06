module backGround_layer(
    input clk,
    input rst,
    output [15:0] upper_led_port,
    output [15:0] lower_led_port
);

    wire clk_out;
    wire scroll_pulse;
    freq_div  freqD1(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_out),
        .scroll_pulse(scroll_pulse)
    );


    localparam [63:0] upper_pacman_0 = {
        8'b00100100,
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100,
        8'b00100100,
        8'b00100100,
        8'b00000000
    };
     
    localparam [63:0] lower_pacman_0 = {
        8'b00000000,
        8'b00100100,
        8'b00100100, 
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100,
        8'b00100100
        
    };
    localparam [31:0] redun = {
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100
    };


//跑道移動的邏輯寫在外面，不要跟S2D搞混了(S2D 的刷頻是為了讓畫面完善處理結構的問題，跟跑道移動的邏輯是分開的)
    reg [159 : 0] vram ;
    always@(posedge clk)begin

        if (rst)begin
            vram <= 160'd0;
        end
        else if (vram==160'd0)begin
           vram <= {upper_pacman_0, lower_pacman_0, redun};
        end
        else if (scroll_pulse)begin
            vram <= {vram[7:0] , vram[159:8]} ;  //注意一下這樣是向下刷還是向上刷  //最右邊的(上)是bit'159
        end   

    end 


//負責旋轉與刷頻(視覺暫留)，腳位賦值
//注意，最左邊(up) 是 127 不是 0
//最後[31:0]是redun
    siginal2display upper_S2D(
        .map(vram[159:96]),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(upper_led_port)
    );
    siginal2display lower_S2D(
        .map(vram[95:32]),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(lower_led_port)
    );



endmodule 

