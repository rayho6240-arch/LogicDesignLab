module tb_RCA_8();
    reg [7:0] A;
    reg [7:0] B;
    wire [7:0] RCA_Sum;
    wire RCA_Cout;
    
    RCA_8 rca_8(
      .A(A),
      .B(B),
      .Cin(1'b0),
      .Sum(RCA_Sum),
      .Cout(RCA_Cout)
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
    integer count; // total iterations
    reg [7:0]gSum;
    reg gCout; // golden 
    reg [8:0] result;
    initial 
    begin
    count = 0;
    fail = 0;
    for( i = 0;i <= 'hFFFF;i = i+1) begin
        A = i[7:0];
        B = i[15:8];
        count = count +1;
        result=A+B;
        gSum = result[7:0];
        gCout = result[8];
        #10;
        // test RCA
        if(RCA_Sum !== gSum || RCA_Cout !== gCout) begin
            fail = fail + 1;
            $display("Case %d:\n\tInput A, B : %d, %d\n\tExpect Sum, Cout : %d, %d\n\tOutput Sum, Cout : %d, %d\n", count, A, B, gSum, gCout, RCA_Sum, RCA_Cout);
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
