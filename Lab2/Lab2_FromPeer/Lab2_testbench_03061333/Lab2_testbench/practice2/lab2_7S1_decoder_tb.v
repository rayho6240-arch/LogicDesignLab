`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/04 03:48:10
// Design Name: 
// Module Name: lab2_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lab2_7S1_decoder_tb(
    );
    
    
    reg [3:0] BCD;
    wire [6:0]out;
    
    Decoder_7S1 duv(
      .BCD(BCD),
      .out(out)
    );
    
    // Initialization
    initial 
    begin
        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");
    end

    integer i; //arr idx
    integer fail; // count fail times
    
    //get decoder golden  
      integer i; //arr idx
      integer fail; // count fail times
      
      
      
      reg [6:0] seven_seg_display_golden; // golden 
      wire [6:0]seven_seg_display_all_golden[15:0];
      assign seven_seg_display_all_golden[0] = 7'b1111110;//0
      assign seven_seg_display_all_golden[1] = 7'b0110000;//1
      assign seven_seg_display_all_golden[2] = 7'b1101101;//2
      assign seven_seg_display_all_golden[3] = 7'b1111001;//3
      assign seven_seg_display_all_golden[4] = 7'b0110011;//4
      assign seven_seg_display_all_golden[5] = 7'b1011011;//5
      assign seven_seg_display_all_golden[6] = 7'b1011111;//6
      assign seven_seg_display_all_golden[7] = 7'b1110000;//7
      assign seven_seg_display_all_golden[8] = 7'b1111111;//8
      assign seven_seg_display_all_golden[9] = 7'b1111011;//9
      assign seven_seg_display_all_golden[10] = 7'b1110111;//10>A
      assign seven_seg_display_all_golden[11] = 7'b0011111;//11>b
      assign seven_seg_display_all_golden[12] = 7'b0001101;//12>C
      assign seven_seg_display_all_golden[13] = 7'b0111101;//13>d
      assign seven_seg_display_all_golden[14] = 7'b1001111;//14>E
      assign seven_seg_display_all_golden[15] = 7'b1000111;//15>F
      wire[7:0] seg_display[6:0];
      assign seg_display[0] = (!out[0])? 8'h3D : 8'h20;//g0
      assign seg_display[1] = (!out[1])? 8'h7C : 8'h20;//f0
      assign seg_display[2] = (!out[2])? 8'h7C : 8'h20;//e0
      assign seg_display[3] = (!out[3])? 8'h3D : 8'h20;//d0
      assign seg_display[4] = (!out[4])? 8'h7C : 8'h20;//c0
      assign seg_display[5] = (!out[5])? 8'h7C : 8'h20;//b0
      assign seg_display[6] = (!out[6])? 8'h3D : 8'h20;//a0
      assign seg_display[7] = (!out[7])? 8'h3D : 8'h20;//g0
      assign seg_display[8] = (!out[8])? 8'h7C : 8'h20;//f0
      assign seg_display[9] = (!out[9])? 8'h7C : 8'h20;//e0
      assign seg_display[10] = (!out[10])? 8'h3D : 8'h20;//d0
      assign seg_display[11] = (!out[11])? 8'h7C : 8'h20;//c0
      assign seg_display[12] = (!out[12])? 8'h7C : 8'h20;//b0
      assign seg_display[13] = (!out[13])? 8'h3D : 8'h20;//a0
      wire[7:0] golden_display[6:0];
      assign golden_display[0] = (seven_seg_display_golden[0])? 8'h3D : 8'h20;//g0
      assign golden_display[1] = (seven_seg_display_golden[1])? 8'h7C : 8'h20;//f0
      assign golden_display[2] = (seven_seg_display_golden[2])? 8'h7C : 8'h20;//e0
      assign golden_display[3] = (seven_seg_display_golden[3])? 8'h3D : 8'h20;//d0
      assign golden_display[4] = (seven_seg_display_golden[4])? 8'h7C : 8'h20;//c0
      assign golden_display[5] = (seven_seg_display_golden[5])? 8'h7C : 8'h20;//b0
      assign golden_display[6] = (seven_seg_display_golden[6])? 8'h3D : 8'h20;//a0
      assign golden_display[7] = (seven_seg_display_golden[7])? 8'h3D : 8'h20;//g0
      assign golden_display[8] = (seven_seg_display_golden[8])? 8'h7C : 8'h20;//f0
      assign golden_display[9] = (seven_seg_display_golden[9])? 8'h7C : 8'h20;//e0
      assign golden_display[10] = (seven_seg_display_golden[10])? 8'h3D : 8'h20;//d0
      assign golden_display[11] = (seven_seg_display_golden[11])? 8'h7C : 8'h20;//c0
      assign golden_display[12] = (seven_seg_display_golden[12])? 8'h7C : 8'h20;//b0
      assign golden_display[13] = (seven_seg_display_golden[13])? 8'h3D : 8'h20;//a0
    
    
    initial begin
        fail = 0;
        #10
        for( i = 0;i < 'h10;i = i+1) begin
            BCD = i;
            #10;
            seven_seg_display_golden = seven_seg_display_all_golden[BCD];
            #10
            if(out !== ~(seven_seg_display_golden)) begin
                fail = fail + 1;
                $display("decoder err :  BCD : %b \n",BCD);
                //display DUT out
                $display("golden : ");
                $display(" %s%s    %s%s ", golden_display[13], golden_display[13], golden_display[6], golden_display[6]);
                $display("%s  %s  %s  %s", golden_display[8] , golden_display[12], golden_display[1], golden_display[5]);
                $display(" %s%s    %s%s ", golden_display[7] , golden_display[7] , golden_display[0], golden_display[0]);
                $display("%s  %s  %s  %s", golden_display[9] , golden_display[11], golden_display[2], golden_display[4]);
                $display(" %s%s    %s%s ", golden_display[10], golden_display[10], golden_display[3], golden_display[3]);
                $display("your answer : ");
                $display(" %s%s    %s%s ", seg_display[13], seg_display[13], seg_display[6], seg_display[6]);
                $display("%s  %s  %s  %s", seg_display[8] , seg_display[12], seg_display[1], seg_display[5]);
                $display(" %s%s    %s%s ", seg_display[7] , seg_display[7] , seg_display[0], seg_display[0]);
                $display("%s  %s  %s  %s", seg_display[9] , seg_display[11], seg_display[2], seg_display[4]);
                $display(" %s%s    %s%s ", seg_display[10], seg_display[10], seg_display[3], seg_display[3]);
            end
        end
        
        if (fail === 0)
        begin
            $display("\n");
            $display("\n");
            $display("        ****************************    _._     _,-'\"\"`-._        ");
            $display("        **  Congratulations !!    **   (,-.`._,'(       |\\`-/|     ");
            $display("        **  Simulation1 PASS!!    **       `-.-' \\ )-`( , o o)     ");
            $display("        ****************************             `-    \\`_`\"'-    ");
            $display("\n");
        end
        else
        begin
            $display("\n");
            $display("\n");
            $display("        ****************************         |\\      _,,,---,,_     ");
            $display("        **  OOPS!!                **   ZZZzz /,`.-'`'    -.  ;-;;,_  ");
            $display("        **  Simulation1 Failed!!  **        |,4-  ) )-,_. ,\\ (  `'-'");
            $display("        ****************************       '---''(_/--'  `-'\\_)     ");
            $display("         Totally has %d errors                     ", fail); 
            $display("\n");
        end
        
        $finish;
    end 
    
endmodule
