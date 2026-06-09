module map_p1(
    output reg [63:0] upper_frame
);

parameter upper_pacman_0={
    8'b00111100,
    8'b01000100, 
    8'b10001000, 
    8'b10010001,
    8'b10001000,
    8'b01000100,
    8'b00111000,
    8'b00000000
};

wire [0:63] upper_mirror;
assign upper_mirror = upper_pacman_0;

integer i;
always @(*) begin
    for (i = 0; i < 64; i = i + 1) begin
        upper_frame[i] = upper_mirror[i];
    end
end


endmodule