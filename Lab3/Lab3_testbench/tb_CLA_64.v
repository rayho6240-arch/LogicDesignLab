`timescale 1ns / 1ps

module tb_CLA_64;

    // 宣告連接 DUT (Device Under Test) 的訊號
    reg  [63:0] A;
    reg  [63:0] B;
    reg         Cin;
    
    wire [63:0] Sum;
    wire        Cout;

    // 宣告一個 65-bit 的變數來儲存「標準答案」，方便做檢查
    reg  [64:0] expected_result;
    integer     error_count;
    integer     i;

    // 實例化你要測試的 Adder
    CLA_64 dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );

    // 測試流程控制
    initial begin
        // 初始訊號設定
        A = 64'd0;
        B = 64'd0;
        Cin = 1'b0;
        error_count = 0;

        $display("----------------------");
        $display("-- Simulation Start --");
        $display("----------------------");

        // --------------------------------------------------------
        // 1. 極端情況測試 (Corner Cases)
        // --------------------------------------------------------
        
        // 測試 1：全 0
        A = 64'd0; B = 64'd0; Cin = 1'b0;
        #10 check_result("Test 1: All Zeros");

        // 測試 2：產生連續進位 (Propagate cascade)
        // 64 個 1 加上 1，會一路進位到最高位元產生 Cout
        A = 64'hFFFF_FFFF_FFFF_FFFF; B = 64'd0; Cin = 1'b1;
        #10 check_result("Test 2: Full Propagate with Cin");

        // 測試 3：兩個最大值相加
        A = 64'hFFFF_FFFF_FFFF_FFFF; B = 64'hFFFF_FFFF_FFFF_FFFF; Cin = 1'b1;
        #10 check_result("Test 3: Max Values");

        // 測試 4：交錯位元 (0101... + 1010...)
        A = 64'h5555_5555_5555_5555; B = 64'hAAAA_AAAA_AAAA_AAAA; Cin = 1'b0;
        #10 check_result("Test 4: Alternating Pattern 1");
        
        // 測試 5：交錯位元加上 Cin
        A = 64'h5555_5555_5555_5555; B = 64'hAAAA_AAAA_AAAA_AAAA; Cin = 1'b1;
        #10 check_result("Test 5: Alternating Pattern 1 with Cin");

        // --------------------------------------------------------
        // 2. 隨機測試 (Random Tests)
        // --------------------------------------------------------
        $display("Running 100 Random Tests...");
        for (i = 0; i < 100; i = i + 1) begin
            // Verilog 的 $random 會產生 32-bit 亂數，我們將兩個接起來變成 64-bit
            A = {$random, $random}; 
            B = {$random, $random};
            Cin = $random % 2; // 隨機產生 0 或 1
            #10 check_result("Random Test");
        end

        // --------------------------------------------------------
        // 3. 測試總結
        // --------------------------------------------------------

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

        $finish; // 結束模擬
    end

    // --------------------------------------------------------
    // 自動檢查用的 Task (副程式)
    // --------------------------------------------------------
    task check_result;
        input [40*8:1] test_name; // 用來接收測試名稱字串
        begin
            // 計算真實的標準答案 (A + B + Cin)，放進 65-bit 的暫存器中以包含 Cout
            expected_result = A + B + Cin;
            
            // 將硬體算出來的 {Cout, Sum} 跟標準答案做比對
            if ({Cout, Sum} !== expected_result) begin
                $display("ERROR at time %0t (%s):", $time, test_name);
                $display("  A        = %d", A);
                $display("  B        = %d", B);
                $display("  Cin      = %b", Cin);
                $display("  Actual   = Cout: %b, Sum: %d", Cout, Sum);
                $display("  Expected = Cout: %b, Sum: %d", expected_result[64], expected_result[63:0]);
                error_count = error_count + 1;
            end
        end
    endtask

endmodule