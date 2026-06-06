
module practice1(
    input clk,
    input rst,
    output [15:0] led_port
);

    wire clk_out;
    freq_div  freqD1(
        .clk_in(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    wire [63:0] upper_frame;
    localparam [63:0] upper_pacman_0 = {
        8'b00111100,
        8'b01000100, 
        8'b10001000, 
        8'b10010001,
        8'b10001000,
        8'b01000100,
        8'b00111000,
        8'b00000000
    };
    assign upper_frame = upper_pacman_0;
    


    siginal2display S2D(
        .map(upper_frame),
        .clk_125000HZ(clk_out),
        .rst(rst),
        .led_port(led_port)
    );


endmodule 
