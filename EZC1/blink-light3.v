
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
    integer file_handle;
    
    blink_light dut(clk, light);

    initial begin
        clk = 0;
        // Open a file for writing the LED state
        file_handle = $fopen("led_state.txt", "w");
        if (file_handle == 0) begin
            $display("Error opening file!");
            $finish;
        end
    end

    always begin
        clk = 1; #5; clk = 0; #5;
    end 
    
    // Monitor light changes and write to file
    always @(light) begin
        $fwrite(file_handle, "%b\n", light);
        $fflush(file_handle);  // Force write to file immediately
        $display("Time = %0t light changed to %b", $time, light);
    end

    // initial begin
    //     #100;
    //     $fclose(file_handle);
    //     $finish;
    // end
endmodule