module test;
    reg [7:0] data;
    reg [7:0] counter;
    integer fd;
    integer scan_count;
    
    // Generate a clock to show we're still running
    initial begin
        counter = 0;
        forever begin
            #10 counter = counter + 1;
            $display("Counter: %d", counter);
        end
    end
    
    // Try to read input
    initial begin
        // Open stdin
        fd = 32'h8000_0000;  // Standard input in iverilog
        
        forever begin
            scan_count = $fscanf(fd, "%h", data);
            if (scan_count == 1) begin
                $display("Read value: %h", data);
            end
            #5; // Small delay before next read attempt
        end
    end
endmodule