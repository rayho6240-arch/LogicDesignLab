`timescale 1ns / 1ps

module tb_CLL_4;

    reg  [3:0] P;
    reg  [3:0] G;
    reg        Cin;
    
    wire [3:1] C;
    wire       PG;
    wire       GG;

    integer i;
    integer error_count;

    reg [3:1] exp_C;
    reg       exp_PG;
    reg       exp_GG;

    reg [4:0] golden_mem [0:511];


    CLL_4 dut (
        .P(P),
        .G(G),
        .Cin(Cin),
        .C(C),
        .PG(PG),
        .GG(GG)
    );


    initial begin
        error_count = 0;
        P = 0; G = 0; Cin = 0;

        $readmemb("golden_CLL_4.data", golden_mem);

        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");

        for (i = 0; i < 512; i = i + 1) begin

            {P, G, Cin} = i[8:0];
            {exp_C[3], exp_C[2], exp_C[1], exp_PG, exp_GG} = golden_mem[i];

            #10;

            if (C !== exp_C || PG !== exp_PG || GG !== exp_GG) begin
                $display("\n");
                $display("ERROR at time %0t:", $time);
                $display("Inputs P = 4'b%b, G = 4'b%b, Cin = 1'b%b", P, G, Cin);
                
                if (C !== exp_C) begin
                    $display("    Internal carry C error!");
                    $display("    Your C = 3'b%b, Expected C = 3'b%b", C, exp_C);
                end
                
                if (PG !== exp_PG) begin
                    $display("    Group propagate PG error!");
                    $display("    Your PG = 1'b%b, Expected PG = 1'b%b", PG, exp_PG);
                end
                
                if (GG !== exp_GG) begin
                    $display("    Group generate GG error!");
                    $display("    Your GG = 1'b%b, Expected GG = 1'b%b", GG, exp_GG);
                end
                $display("--------------------------------------------------");
                error_count = error_count + 1;
            end
        end


        if (error_count == 0) begin
            $display("\n");
            $display("\n");
            $display("        ****************************    _._     _,-'\"\"`-._        ");
            $display("        **  Congratulations !!    **   (,-.`._,'(       |\\`-/|     ");
            $display("        **  Simulation1 PASS!!    **       `-.-' \\ )-`( , o o)     ");
            $display("        ****************************             `-    \\`_`\"'-    ");
            $display("\n");
        end else begin
            $display("\n");
            $display("\n");
            $display("        ****************************         |\\      _,,,---,,_     ");
            $display("        **  OOPS!!                **   ZZZzz /,`.-'`'    -.  ;-;;,_  ");
            $display("        **  Simulation1 Failed!!  **        |,4-  ) )-,_. ,\\ (  `'-'");
            $display("        ****************************       '---''(_/--'  `-'\\_)     ");
            $display("         Totally has %d errors                     ", error_count); 
            $display("\n");
        end

        $finish;
    end

endmodule