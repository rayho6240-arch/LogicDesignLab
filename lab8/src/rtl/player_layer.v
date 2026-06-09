module player_layer(
    input clk,
    input rst,
    input btn_left,
    input btn_right,
    output [15:0] led_port
);


    wire clk_out;
    wire move_pulse;
    freq_div  freqD1(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_out),
        .scroll_pulse(move_pulse)
    );


//左右shift 3 bit 就可以達到
    localparam [63:0] player = {
        8'b00000000, 
        8'b00000000, 
        8'b00000000, 
        8'b00000000, 
        8'b00000000, 
        8'b00011000,
        8'b00011000,
        8'b00011000
    };

//跑道移動的邏輯寫在外面，不要跟S2D搞混了(S2D 的刷頻是為了讓畫面完善處理結構的問題，跟跑道移動的邏輯是分開的)
    reg [63 : 0] vram ;
    reg [1:0] count ;
 
    always@(posedge clk)begin
        if (rst)begin
            vram_player <= 64'd0;
        end
        else if (vram_player==64'd0)begin
           vram <= {player};
        end

        //往左平移
        else if (btn_left) begin
            if (move_pulse && move_count <= 2'b3 )begin
                vram <= {vram_player[62:0] , vram[63]} ;  //注意一下這樣是向下刷還是向上刷  //最右邊的(上)是bit'159
                count <= count + 2'b1;
                if (count == 2'd3)  count <= 2'd0;
            end
        end   

        //往右平移
        else if (btn_right) begin
            if (move_pulse && move_count <= 2'b3 )begin
                vram <= {vram_player[0] , vram[63:1]} ;  //注意一下這樣是向下刷還是向上刷  //最右邊的(上)是bit'159
                count <= count + 2'b1;
                if (count == 2'd3)  count <= 2'd0;
            end
        end   
        
    end 


    siginal2display player(
        .map(vram_player),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(led_port)
    );

endmodule
