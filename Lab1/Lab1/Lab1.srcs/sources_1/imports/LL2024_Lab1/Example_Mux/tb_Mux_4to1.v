module tb_Mux_4to1();
    reg src_0, src_1, src_2, src_3;
    reg [1:0] src_sel;
    wire BL_channel, CB_channel;
    
    BL_Mux_4to1 M0(
    .src_0(src_0),
    .src_1(src_1),
    .src_2(src_2),
    .src_3(src_3),
    .src_sel(src_sel),
    .channel(BL_channel)
    );
    
    CB_Mux_4to1 M1(
    .src_0(src_0),
    .src_1(src_1),
    .src_2(src_2),
    .src_3(src_3),
    .src_sel(src_sel),
    .channel(CB_channel)
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
        fd = $fopen("golden_Mux_4to1.data","r");
    end

    integer i; //arr idx
    integer fail; // count fail times
    integer count; // total iterations
    reg gchannel; // golden 
    
    initial begin
        count = 0;
        fail = 0;
        for( i = 0;i < 64;i = i+1) begin
            src_0 = i[0];
            src_1 = i[1];
            src_2 = i[2];
            src_3 = i[3];
            src_sel = {i[5],i[4]};
            count = count +1;
            $fscanf(fd,"%d",gchannel);
            #10;
            if(BL_channel !== gchannel) begin
                fail = fail + 1;
                $display("Case %d:\n\tInput src_0, src_1, src_2, src_3, src_sel : %d, %d, %d, %d, %d\n\tExpect BL_channel : %d\n\tOutput BL_channel : %d\n", count, src_0, src_1, src_2, src_3, src_sel, gchannel, BL_channel);
            end
            if(CB_channel !== gchannel) begin
                fail = fail + 1;
                $display("Case %d:\n\tInput src_0, src_1, src_2, src_3, src_sel : %d, %d, %d, %d, %d\n\tExpect GL_channel : %d\n\tOutput GL_channel : %d\n", count, src_0, src_1, src_2, src_3, src_sel, gchannel, CB_channel);
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
