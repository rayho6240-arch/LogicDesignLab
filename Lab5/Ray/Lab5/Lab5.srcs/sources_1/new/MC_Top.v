`timescale 1ns / 1ps

module MC_TOP(

    input clk, rst,
    input [1:0] btn,
    output [3:0] led
    
    );
    
    wire btn_deb1, btn_deb2;
    wire pluse1,pluse2;
    
    BTN_DEB d1(
        .clk(clk), 
        .rst(rst),
        .btn(btn[0]),
        .btn_deb(btn_deb1)
    );
    
    BTN_DEB d2(
        .clk(clk), 
        .rst(rst),
        .btn(btn[1]),
        .btn_deb(btn_deb2)
    );
    
    
    Pulse_GEN p1(
        .clk(clk), 
        .rst(rst),
        .in(btn_deb1),
        .out(pluse1)
    );
    
    Pulse_GEN p2(
        .clk(clk), 
        .rst(rst),
        .in(btn_deb2),
        .out(pluse2)
    );
    
    MC mc(
        .clk(clk), 
        .rst(rst),
        .up_pulse(pluse1), 
        .down_pulse(pluse2),
        .led(led)
    );

    
    
    
endmodule



