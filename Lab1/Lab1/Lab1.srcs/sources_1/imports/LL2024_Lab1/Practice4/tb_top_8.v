module tb_top_8();
    reg [7:0] src;
    reg [2:0] src_sel, dst_sel;
    wire [7:0] dst;
    wire channel;
    
    top_8 top_8(
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
        fd = $fopen("golden_top_8.data","r");
    end
    integer i; //arr idx
    integer fail; // count fail times
    integer count; // total iterations
    reg gchannel, gdst[0:7]; // golden 
    initial 
    begin
    count = 0;
    fail = 0;
    for( i = 0;i < 16384;i = i+1) begin
        src[0] = i[0];
        src[1] = i[1];
        src[2] = i[2];
        src[3] = i[3];
        src[4] = i[4];
        src[5] = i[5];
        src[6] = i[6];
        src[7] = i[7];
        src_sel = {i[10],i[9],i[8]};
        dst_sel = {i[13],i[12],i[11]};
        count = count +1;
        $fscanf(fd,"%d %d %d %d %d %d %d %d %d", gchannel, gdst[0], gdst[1], gdst[2], gdst[3], gdst[4], gdst[5], gdst[6], gdst[7]);
        #10;
        if((channel !== gchannel) || (dst[0] !== gdst[0]) || (dst[1] !== gdst[1]) || (dst[2] !== gdst[2]) || (dst[3] !== gdst[3]) || (dst[4] !== gdst[4]) || (dst[5] !== gdst[5]) || (dst[6] !== gdst[6]) || (dst[7] !== gdst[7])) begin
            fail = fail + 1;
            $display("Case %d:\n", count);
            $display("\tInput src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7], src_sel, dst_sel : %d, %d, %d, %d, %d, %d, %d, %d, %d, %d\n", src[0], src[1], src[2], src[3], src[4], src[5], src[6], src[7], src_sel, dst_sel);
            $display("\tExpect channel, dst[0], dst[1], dst[2], dst[3], dst[4], dst[5], dst[6], dst[7] : %d, %d, %d, %d, %d, %d, %d, %d, %d\n", gchannel, gdst[0], gdst[1], gdst[2], gdst[3], gdst[4], gdst[5], gdst[6], gdst[7]);
            $display("\tOutput channel, dst[0], dst[1], dst[2], dst[3], dst[4], dst[5], dst[6], dst[7] : %d, %d, %d, %d, %d, %d, %d, %d, %d\n", channel, dst[0], dst[1], dst[2], dst[3], dst[4], dst[5], dst[6], dst[7]);
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
