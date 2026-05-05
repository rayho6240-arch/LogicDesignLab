`timescale 1ns / 1ps

module Gated_D_Latch(
    input D,
    input En,
    output Q,Q_n
    );
    
    wire [1:0]con;
    assign con[0]=D&En;
    assign con[1]=~D&En;
    
    
    SR_Latch a(
       .S(con[0]),
       .R(con[1]),
       .Q(Q),
       .Q_n(Q_n)
    );
    
    
endmodule 