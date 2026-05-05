`timescale 1ns / 1ps

module top_15_2(
    input [14:0] in,        
    output [3:0] BCD,   
    output [6:0] out_1,     // 十位數 
    output [6:0] out_0      // 個位數 
    );

//摸組間的連線
    wire [3:0] bcd_bus; 
    assign BCD = bcd_bus;


//調用模組
    Encoder_15 abc(
        .in(in),              
        .BCD(bcd_bus)         
    );


    Decoder_7S2 cde(
        .BCD(bcd_bus),        
        .out_1(out_1),       
        .out_0(out_0)        
    );

endmodule