module siginal2display(
    input [63:0] map,
    input clk_125000HZ,
    input rst,
    output [15:0]upper_led_port,
    output [15:0]lower_led_port
);

    //把data讀進來，分割
    reg [15:0] display_map [0:7];
    //integer i;
    integer row, col;

    always @(*) begin
        //旋轉90 度
        for (row = 0; row < 15; row = row + 1) begin
            for (col = 0; col < 8; col = col + 1) begin
                display_map[row][col] = map[col*8 + (7-row)]; //注意矩陣的syntax //把col 變成列(參考註解掉的原邏輯)//從最後一col 往回讀，逆時針轉了90度。// 逆時針就是 map[(7-col)*8 + row] 
            end
        end
        /*直接讀取
        for (i = 0; i < 8; i = i + 1) begin
            display_map[i] = map[i*8 +: 8]; //same as frame[j*8 + 7 ; j*8] //注意分號冒號
        end
        */
    end
    
    //地址刷屏
    reg [2:0] row_idx;
    always@(posedge clk_125000HZ or posedge rst)begin
        if (rst)begin
            row_idx <= 0;
        end
        else begin
            row_idx <= row_idx + 1;
        end
    end
    
    //配合刷屏的資訊讀取
    reg [7:0] col_display, row_display;
    always@(posedge clk_125000HZ or posedge rst)begin
        if (rst)begin
            col_display <= 8'h00;
            row_display <= 8'hFF;
        end
        else begin
            //同刷頻地址，依據同一個clk125000 更新
            col_display <= display_map[row_idx];  // data 中，第 row 個向量
            if (row_display ==8'hFF)begin
                row_display <= {row_display[6:0], 1'b0};//零者，是被選到的那一個
            end
            else begin
                row_display <= {row_display[6:0], row_display[7]};
            end
        end
    end



    assign upper_led_port[0]  = row_display[5-1] ;
    assign upper_led_port[1]  = row_display[7-1] ;
    assign upper_led_port[2]  = col_display[2-1] ;
    assign upper_led_port[3]  = col_display[3-1] ;
    assign upper_led_port[4]  = row_display[8-1] ;
    assign upper_led_port[5]  = col_display[5-1] ;
    assign upper_led_port[6]  = row_display[6-1] ;
    assign upper_led_port[7]  = row_display[3-1] ;
    assign upper_led_port[8]  = row_display[1-1] ;
    assign upper_led_port[9]  = col_display[4-1] ;
    assign upper_led_port[10] = col_display[6-1] ;
    assign upper_led_port[11] = row_display[4-1] ;
    assign upper_led_port[12] = col_display[1-1] ;
    assign upper_led_port[13] = row_display[2-1] ;
    assign upper_led_port[14] = col_display[7-1] ;
    assign upper_led_port[15] = col_display[8-1] ;


    assign lower_led_port[0]  = row_display[5-1+8] ;
    assign lower_led_port[1]  = row_display[7-1+8] ;
    assign lower_led_port[2]  = col_display[2-1+8] ;
    assign lower_led_port[3]  = col_display[3-1+8] ;
    assign lower_led_port[4]  = row_display[8-1+8] ;
    assign lower_led_port[5]  = col_display[5-1+8] ;
    assign lower_led_port[6]  = row_display[6-1+8] ;
    assign lower_led_port[7]  = row_display[3-1+8] ;
    assign lower_led_port[8]  = row_display[1-1+8] ;
    assign lower_led_port[9]  = col_display[4-1+8] ;
    assign lower_led_port[10] = col_display[6-1+8] ;
    assign lower_led_port[11] = row_display[4-1+8] ;
    assign lower_led_port[12] = col_display[1-1+8] ;
    assign lower_led_port[13] = row_display[2-1+8] ;
    assign lower_led_port[14] = col_display[7-1+8] ;
    assign lower_led_port[15] = col_display[8-1+8] ;

endmodule