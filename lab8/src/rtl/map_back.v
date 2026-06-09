module map_back(
    output reg [63:0] upper_frame,
    output reg [63:0] upper_frame,
    output reg [31:0] redun
);

    localparam [63:0] upper_pacman_0 = {
        8'b00100100,
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100,
        8'b00100100,
        8'b00100100,
        8'b00000000
    };
     
    localparam [63:0] lower_pacman_0 = {
        8'b00000000,
        8'b00100100,
        8'b00100100, 
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100,
        8'b00100100
        
    };
    localparam [31:0] redun = {
        8'b00100100, 
        8'b00000000, 
        8'b00000000, 
        8'b00100100
    };

wire [0:63] upper_mirror, lower_mirror;
wire [0:31] redun_mirror;
assign upper_mirror = upper_pacman_0;
assign lower_mirror = lower_pacman_0;
assign redun_mirror = redun;

integer i;
always @(*) begin
    for (i = 0; i < 64; i = i + 1) begin
        upper_frame[i] = upper_mirror[i];
        lower_frame[i] = lower_mirror[i];
    end
end

integer j;
always @(*) begin
    for (j = 0; j < 32; j = j + 1) begin
        redun[i] = redun_mirror[i];
    end
end

always@(*)begin
    upper_frame = upper_pacman_0;
end

endmodule