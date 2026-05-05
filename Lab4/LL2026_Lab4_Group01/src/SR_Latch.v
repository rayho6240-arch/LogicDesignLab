`timescale 1ns / 1ps

module SR_Latch(
    input S,R,
    output Q, Q_n
    );
    
    assign Q   = ~(R | Q_n); 
    assign Q_n = ~(S | Q);
    
    
    endmodule