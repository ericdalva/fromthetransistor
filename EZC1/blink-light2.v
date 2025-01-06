// make a wire blink 

module blink_light (
    input wire clk,
    output wire light
);

reg [3:0] counter;
reg [0:0] out;

initial begin
    counter = 0;
    out = 0;
end

 always @(posedge clk) begin
    if (counter == 10) begin
        counter <= 0;
        out <= ~out;
    end else begin
        counter <= counter + 1;
    end
 end
 
 assign light = out;
    
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
        #1000 $finish;  // 3, 4
endmodule