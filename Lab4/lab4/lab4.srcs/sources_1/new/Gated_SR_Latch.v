`timescale 1ns / 1ps

module Gated_SR_Latch(
    input S, R,
    input En,
    output Q, Q_n
    );

   wire con[1:0];
   assign con[0]= R & En ;
   assign con[1]= S & En ;
    
   
    SR_Latch a(
        .S(con[0]),
        .R(con[1]),
        .Q(Q),
        .Q_n(Q_n)
    );
    

endmodule
