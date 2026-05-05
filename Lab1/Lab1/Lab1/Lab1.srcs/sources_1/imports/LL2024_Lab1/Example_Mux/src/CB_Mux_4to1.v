module CB_Mux_4to1(
    input src_0,
    input src_1,
    input src_2,
    input src_3,
    input [1:0] src_sel,
    output channel
);
    
    // filtered src_0 and src_1 & filtered src_2 and src_3
    wire f_src_01, f_src_23;
    
    // select src_0 or select src_1
    BL_Mux_2to1 M0(
    .src_0(src_0),
    .src_1(src_1),
    .src_sel(src_sel[0]),
    .channel(f_src_01)
    );
    
    // select src_2 or select src_3
    BL_Mux_2to1 M1(
    .src_0(src_2),
    .src_1(src_3),
    .src_sel(src_sel[0]),
    .channel(f_src_23)
    );
    
    // selecr f_src_01 or select f_src_23
    BL_Mux_2to1 M2(
    .src_0(f_src_01),
    .src_1(f_src_23),
    .src_sel(src_sel[1]),
    .channel(channel)
    );

endmodule