// we will blink the light every 5 clk edges
module blink_light (
    input logic clk,
    output wire light
);
    assign light = clk;
endmodule

module blink_light_tb ();
    logic clk;
    wire light;
    blink_light dut(clk, light);

    initial
        clk = 0;

    always 
        begin
            clk = 1; #5; clk = 0; #5;
        end 
    
    always @(clk)
        $display("Time = %0t the clk signal is %b and the light is %b", $time, clk, light);  // 1, 2

    initial
        #100 $finish;  // 3, 4
endmodule

    