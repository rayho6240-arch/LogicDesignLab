`define CYCLE_CNT_FOR_12500HZ 10000 // Assuming clk_in is 125MHz, this will give us a 12500Hz output clock
module freq_div (
  input clk_in,
  input rst,
  output reg clk_out
);
  reg [15:0] counter;

  always @(posedge clk_in or posedge rst) begin
    if (rst) begin
      counter <= 16'b0;
      clk_out <= 1'b0;
    end 
    else begin
      counter <= counter + 1;
      if (counter == `CYCLE_CNT_FOR_12500HZ/2 - 1) begin // 為甚麼要-1？: 因為counter從0開始計數，所以當counter達到CYCLE_CNT_FOR_12500HZ/2 - 1時，實際上已經經過了CYCLE_CNT_FOR_12500HZ/2個時鐘週期
        clk_out <= ~clk_out; // Toggle the output clock
        counter <= 16'b0; // Reset the counter
      end
    end
  end
  endmodule
