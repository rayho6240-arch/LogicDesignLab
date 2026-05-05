module Pulse_GEN(
    input clk, rst,
    input in,
    output out
);

    reg lastState; 

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            lastState <= 1'b0;
        end 
        else begin
            lastState <= in; 
        end
    end

    // [add]當「現在是 1」但「剛才是 0」時，輸出一個週期的 1
    assign out = (in == 1'b1) && (lastState == 1'b0);

endmodule