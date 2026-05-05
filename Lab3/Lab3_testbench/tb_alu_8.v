module tb_alu_8();
    reg [7:0] A;
    reg [7:0] B;
    reg OP;
    wire [7:0] Sum;
    wire OV;
    
    ALU_8 alu_8(
      .A(A),
      .B(B),
      .OP(OP),
      .Sum(Sum),
      .OV(OV)
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
        fd = $fopen("golden_alu_8.data","r");
    end

    integer i, j; //arr idx
    integer fail; // count fail times
    integer count; // total iterations
    reg [7:0]gSum;
    reg gOV; // golden 
    reg [8:0] result;
    initial 
    begin
    count = 0;
    fail = 0;
    for (j = 0; j <= 1; j=j+1) begin
        OP = j[0];
        for( i = 0;i <= 'hFFFF;i = i+1) begin
            A = i[7:0];
            B = i[15:8];
            count = count + 1;
            gSum = (OP)? (A-B):(A+B);
            $fscanf(fd,"%d",gOV);
            #10;
    
            if(Sum !== gSum || OV !== gOV) begin
                fail = fail + 1;
                if(OP) 
                    $display("Case %d:\n\tInput A - B : %d, %d\n\tExpect Sum, OV: %d, %d\n\tOutput Sum, OV : %d, %d\n", count, $signed(A), $signed(B), $signed(gSum), gOV, $signed(Sum), OV);
                else
                    $display("Case %d:\n\tInput A + B : %d, %d\n\tExpect Sum, OV: %d, %d\n\tOutput Sum, OV : %d, %d\n", count, $signed(A), $signed(B), $signed(gSum), gOV, $signed(Sum), OV);
            end
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
