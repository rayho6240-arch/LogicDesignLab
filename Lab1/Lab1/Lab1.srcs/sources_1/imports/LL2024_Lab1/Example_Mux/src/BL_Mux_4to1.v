module BL_Mux_4to1(
    input src_0,
    input src_1,
    input src_2,
    input src_3,
    input [1:0] src_sel,
    output channel
);
    
    assign channel = (src_sel == 2'b00) ? src_0 :
                     (src_sel == 2'd1)  ? src_1 :
                     (src_sel == 2'b10) ? src_2 : src_3;
    
    
    
endmodule
