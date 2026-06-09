`define CYCLE_CNT_FOR_12500HZ 10000 // Assuming clk_in is 125MHz, this will give us a 12500Hz output clock
`define CYCLE_CNT_FOR_100MS 12500000
module freq_div (
  input clk_in,
  input rst,
  output reg clk_out,
  output reg scroll_pulse, //需要reg 是因為我在always@(clk) 裡面賦值
  output reg move_pluse
);
  reg [15:0] counter_12500HZ;
  reg [23:0] counter_100ms;  //For background scroll
  reg [23:0] counter_10ms;   //For player move

  always @(posedge clk_in or posedge rst) begin
    if (rst) begin
      counter_12500HZ <= 16'b0;
      counter_100ms <= 23'b0;
    
      clk_out <= 1'b0;
      scroll_pulse <= 1'b0;
    end 



    else begin
      counter_12500HZ <= counter_12500HZ + 1;
      counter_100ms <= counter_100ms + 1;


      if (counter_12500HZ == `CYCLE_CNT_FOR_12500HZ/2 - 1) begin // 為甚麼要-1？: 因為counter從0開始計數，所以當counter達到CYCLE_CNT_FOR_12500HZ/2 - 1時，實際上已經經過了CYCLE_CNT_FOR_12500HZ/2個時鐘週期
        clk_out <= ~clk_out; // Toggle the output clock
        counter_12500HZ <= 16'b0; // Reset the counter
      end



      if (counter_100ms == `CYCLE_CNT_FOR_100MS - 1) begin // 100ms = 100000us, 12500Hz = 1/12500s = 80us, 所以100ms需要12500Hz的時鐘週期數為100000us / 80us = 1250
        scroll_pulse <=1'b1; // Toggle the move pulse
        counter_100ms <= 23'b0; // Reset the counter
      end

      if (counter_10ms == `CYCLE_CNT_FOR_100MS/10 - 1)begin
        move_pulse <=1'b1;
        counter_10ms <=23'b0;
      end 




    end
  end



  endmodule
