module lfsr_4bit (
    input  wire       clk,
    input  wire       rst,
    output reg  [3:0] q
);

    wire feedback = q[3] ^ q[2];

    always @(posedge clk) begin
        if (rst) begin
            q <= 4'b0001;
        end else begin
            q <= {q[2:0], feedback};
        end
    end

endmodule
