module Top (
  input clk,
  input rst,
  input [3:0] btn,
  output [31:0] matrix,     // (8+8)*2=32
  output [3:0] display_HP,  // btn 上面的四個led
  output [2:0] collision
); 


  wire lower_led_port, upper_led_port;
  backGround_layer back(
    .clk(clk),
    .rst(rst),
    .upper_led_port(upper_led_port),
    .lower_led_port(lower_led_port)
  )

  wire [15:0] player_led_port
  player_layer player(
    .clk(clk),
    .rst(rst),
    .btn_left(btn[0]),
    .btn_right(btn[2]),
    .led_port(player_led_port)
  );






endmodule
