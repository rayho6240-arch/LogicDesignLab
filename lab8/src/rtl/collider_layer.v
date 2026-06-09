module collider_layer(
    input clk,
    input rst,
    output [15:0] upper_led_port,
    output [15:0] lower_led_port
);

    wire clk_out;
    wire scroll_pulse;

    freq_div freqD1(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_out),
        .scroll_pulse(scroll_pulse),
        .move_pulse()
    );

    reg [7:0] lfsr;
    reg [127:0] collider_vram;
    reg [3:0] spawn_gap;    //距離下一次生成障礙物，還要空幾列。

    wire feedback = lfsr[7] ^ lfsr[5] ^ lfsr[4] ^ lfsr[3];   //數學家找出來的好函數
    wire [15:0] collider_pattern =
        (lfsr[1:0] == 2'd0) ? 8'b00000011 :  //其中的lfsr 會一直變(跟著clk)
        (lfsr[1:0] == 2'd1) ? 8'b00011000 :  //決定哪條跑道
        (lfsr[1:0] == 2'd2) ? 8'b11000000 :
                                8'b00011000;


    wire [7:0] new_collider_row = (spawn_gap == 3'd0) ? collider_pattern : 8'b0000_0000; //等待歸零，生成一個

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lfsr <= 8'hAD;
            vram_collider <= 128'd0;
            spawn_gap <= 3'd0;
        end
        else if (scroll_pulse) begin
            lfsr <= {lfsr[6:0], feedback};
            vram_collider <= {new_collider_row, vram_collider[127:8]}; //最後面的，被推掉了

            if (spawn_gap == 3'd0) begin //spwan歸零重新取一個隨機的等待時間//隨著scroll_pulse
                spawn_gap <= {2'b00, lfsr[1:0]} + 4'd5;  //會讓spwan_gap 有隨機的部分 //基數為5隨機加上0~3
            end
            else begin //開始等待
                spawn_gap <= spawn_gap - 3'd1;
            end
        end
    end


    siginal2display upper_S2D(
        .map(collider_vram [159:96]),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(upper_led_port)
    );

    siginal2display upper_S2D(
        .map(collider_vram[95:0]),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(lower_led_port)
    );





localparam [15:0] right_collider = {
    8'b00000011,
    8'b00000011
};
localparam [15:0] left_collider = {
    8'b11000000, 
    8'b11000000 
};
localparam [15:0] mid_collider = {
    8'b00011000,
    8'b00011000
};



endmodule
