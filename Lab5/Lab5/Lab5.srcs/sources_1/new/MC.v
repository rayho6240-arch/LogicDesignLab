module MC (
    input clk, rst,
    input up_pulse, down_pulse,
    output [3:0] led
);

    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'd0;
        end 
        else begin
            if (up_pulse) begin
                count <= count + 4'd1;   
            end 
            else if (down_pulse) begin
                count <= count - 4'd1;   
            end
        end
    end

    assign led = count;

endmodule