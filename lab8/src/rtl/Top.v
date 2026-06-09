module Top (
  input clk,
  input rst,
  input [3:0] btn,
  output [31:0] matrix,     // (8+8)*2=32
  output [15:0] led,
  output [3:0] display_HP,  // btn 上面的四個led
  output [2:0] collision    // ?????
); 


  wire [15:0] lower_back_led, upper_back_led;
  backGround_layer back(
    .clk(clk),
    .rst(rst),
    .upper_led_port(upper_back_led),
    .lower_led_port(lower_back_led)
  );

/*
  wire [15:0] player_led_port;
  player_layer player(
    .clk(clk),
    .rst(rst),
    .btn_left(btn[0]),
    .btn_right(btn[2]),
    .led_port(player_led_port)
  );

  wire [15:0] upper_collider_led, lower_collider_led;
  collider_layer collider(
    .clk(clk),
    .rst(rst),
    .upper_led_port(upper_collider_led),
    .lower_led_port(lower_collider_led)
  );


//碰撞扣血//沒有檢查
  wire hit_now; 
  reg hit_delay;  //撞到的當下會有無敵時間，以免一次撞擊直接歸零//Control 訊號
  reg [2:0] hp;

  assign hit_now = |(player_led_port & lower_collider_led); //特殊運算符號: 把所有and 的結果 or 起來

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      hp <= 3'd4;
      hit_delay <= 1'b0;
    end
    else begin
      hit_delay <= hit_now;

      if (hit_now && !hit_delay && hp != 2'd0) begin
        hp <= hp - 3'd1;
      end
    end
  end

  assign display_HP =
      (hp == 3'd4) ? 4'b1111 :
      (hp == 3'd3) ? 4'b0111 :
      (hp == 3'd2) ? 4'b0011 :
      (hp == 3'd1) ? 4'b0001 :
                     4'b0000;

  assign collision = {hp == 2'd0, hit_now, hit_now && !hit_delay}; //???????

//TODO：開始與結束頁面
//沒血顯示失敗//存活夠久顯示贏了//開始介面按任意鍵進入遊戲



  assign matrix[31:16] = upper_back_led | upper_collider_led;
  assign matrix[15:0]  = lower_back_led | lower_collider_led | player_led_port;
*/
assign led[15:0]  = lower_back_led;

endmodule

