module GL_Mux_2to1(
    input src_0,
    input src_1,
    input src_sel,
    output channel
);
    
    // filtered src_0 & filtered src_1
    wire f_src_0, f_src_1;
    
    // ~src_sel
    wire src_sel_n;
    
    not(src_sel_n, src_sel);
    
    and(f_src_0, src_0, src_sel_n);
    and(f_src_1, src_1, src_sel);
    
    or(channel, f_src_0, f_src_1);
    
    
endmodule
