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


module lab2_hex_15bits_encoder_tb(
    );
    
    
    
    reg [14:0] in;
    wire [3:0] BCD;
    
    Encoder_15 encoder(
      .in(in),
      .BCD(BCD)
    );
    
    // Initialization
    initial 
    begin
        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");
    end

    //READ file
    integer fd;
    initial
    begin
        fd = $fopen("BCD_golden.data","r");
    end
    
    integer i; //arr idx
    integer fail; // count fail times
    reg[3:0] BCD_golden; // golden 
    
    //get decoder golden  
      integer i; //arr idx
      integer fail; // count fail times
      
      
    initial begin
        fail = 0;
        for( i = 0;i < 'h8000;i = i+1) begin
            in = i;
            $fscanf(fd,"%h",BCD_golden);
            #10;
            if(BCD !== BCD_golden) begin
                fail = fail + 1;
                $display("encoder err : ");
                $display("input : %b, golden : %b, your ans : %b", in, BCD_golden, BCD);
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
        
        $fclose(fd);
        $finish;
    end 
    
endmodule
