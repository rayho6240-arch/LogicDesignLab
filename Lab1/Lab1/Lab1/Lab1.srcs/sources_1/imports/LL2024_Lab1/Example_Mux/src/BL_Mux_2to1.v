module BL_Mux_2to1(
    input src_0,
    input src_1,
    input src_sel,
    output channel
);
    
   assign channel = (src_sel)? src_1:src_0;
    
endmodule
