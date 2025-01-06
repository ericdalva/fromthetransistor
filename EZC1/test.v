// First implementation
module SRLatch1 (
    input wire S, 
    input wire R, 
    output wire out
);
    wire RO;
    assign RO = ~(R & out);
    assign out = ~(S & RO);
endmodule

// Second implementation
module SRLatch2 (
    input wire S,
    input wire R,
    output wire Q
);
    wire Q_bar;    
    assign Q = ~(S & Q_bar);     
    assign Q_bar = ~(R & Q);     
endmodule

// Testbench
module sr_latch_tb;
    // Test signals
    reg S, R;
    wire out1, out2;
    
    // Instantiate both latches
    SRLatch1 latch1(.S(S), .R(R), .out(out1));
    SRLatch2 latch2(.S(S), .R(R), .Q(out2));
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t S=%b R=%b out1=%b out2=%b", $time, S, R, out1, out2);
    end
    
    // Test sequence
    initial begin
        // Initialize
        S = 0; R = 0;
        #10;
        
        // Test Set
        S = 0; R = 1;  // Set
        #10;
        
        // Test Hold
        S = 1; R = 1;  // Hold
        #10;
        
        // Test Reset
        S = 1; R = 0;  // Reset
        #10;
        
        // Test Hold again
        S = 1; R = 1;  // Hold
        #10;
        
        // Test Invalid state
        S = 0; R = 0;  // Invalid/metastable
        #10;
        
        $finish;
    end
endmodule