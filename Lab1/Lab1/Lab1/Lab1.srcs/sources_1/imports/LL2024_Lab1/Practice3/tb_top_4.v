module tb_top_4();
    reg [3:0] src;
    reg [1:0] src_sel, dst_sel;
    wire [3:0] dst;
    wire channel;
    
    top_4 top_4(
    .src(src),
    .src_sel(src_sel),
    .dst_sel(dst_sel),
    .dst(dst),
    .channel(channel)
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
        fd = $fopen("golden_top_4.data","r");
    end
    integer i; //arr idx
    integer fail; // count fail times
    integer count; // total iterations
    reg gchannel, gdst[0:3]; // golden 
    initial 
    begin
    count = 0;
    fail = 0;
    for( i = 0;i < 256;i = i+1) begin
        src[0] = i[0];
        src[1] = i[1];
        src[2] = i[2];
        src[3] = i[3];
        src_sel = {i[5],i[4]};
        dst_sel = {i[7],i[6]};
        count = count +1;
        $fscanf(fd,"%d %d %d %d %d", gchannel, gdst[0], gdst[1], gdst[2], gdst[3]);
        #10;
        if((channel !== gchannel) || (dst[0] !== gdst[0]) || (dst[1] !== gdst[1]) || (dst[2] !== gdst[2]) || (dst[3] !== gdst[3])) begin
            fail = fail + 1;
            $display("Case %d:\n", count);
            $display("\tInput src[0], src[1], src[2], src[3], src_sel, dst_sel : %d, %d, %d, %d, %d, %d\n", src[0], src[1], src[2], src[3], src_sel, dst_sel);
            $display("\tExpect channel, dst[0], dst[1], dst[2], dst[3] : %d, %d, %d, %d, %d\n", gchannel, gdst[0], gdst[1], gdst[2], gdst[3]);
            $display("\tOutput channel, dst[0], dst[1], dst[2], dst[3] : %d, %d, %d, %d, %d\n", channel, dst[0], dst[1], dst[2], dst[3]);
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
