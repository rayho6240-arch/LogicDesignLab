`timescale 1ns / 1ps

module tb_CLA_4;

    reg  [3:0] A;
    reg  [3:0] B;
    reg        Cin;

    wire [3:0] Sum;
    wire       PG;
    wire       GG;

    integer i;
    integer error_count;
    reg [4:0] expected_result; 
    wire actual_cout;

    CLA_4 dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .PG(PG),
        .GG(GG)
    );

    assign actual_cout = GG | (PG & Cin);


    initial begin

        error_count = 0;
        A = 0;
        B = 0;
        Cin = 0;

        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");

        
        for (i = 0; i < 512; i = i + 1) begin
            
            {A, B, Cin} = i[8:0];
            
            #10;

            expected_result = A + B + Cin;

            if (Sum !== expected_result[3:0] || actual_cout !== expected_result[4]) begin
                $display("\n");
                $display("ERROR at time %0t:", $time);
                $display("  Inputs    A=%d, B=%d, Cin=%b", A, B, Cin);
                $display("  Expected  Cout=%b, Sum=%d", expected_result[4], expected_result[3:0]);
                $display("  Actual    Cout=%b (PG=%b, GG=%b), Sum=%d", actual_cout, PG, GG, Sum);
                $display("\n");
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