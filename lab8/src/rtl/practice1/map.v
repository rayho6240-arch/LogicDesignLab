module map(
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
always@(*)begin
    upper_frame <= upper_pacman_0;
end

endmodule