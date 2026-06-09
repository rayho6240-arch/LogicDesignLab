
module practice1(
    input clk,
    input rst,
    output [15:0] led_port
);

    wire clk_out;
    freq_div_p1  freqD1(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    wire [63:0] upper_frame;
    map_p1 MAP (
        .upper_frame(upper_frame)
    );


    siginal2display_p1 S2D(
        .map(upper_frame),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(led_port)
    );


endmodule 
