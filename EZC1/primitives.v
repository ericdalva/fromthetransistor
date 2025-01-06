module dFlipFlop (wire clk, wire signal);
    // a d flip flop works by "storing" a signal and updating it on the 
    // falling edge of the clock
    //""


endmodule

module SRLatch (input wire S, input wire R, output wire out);
// SR latch truth table | S= 1 R = 1 -> out = out 
// S = 0 R = 1 -> out = 1
// S = 1 R = 0 -> out = 0
// S = 0 R = 0 -> out = NA
    wire RO;

    assign RO = ~(R & out);
    assign out = ~(S & RO);
endmodule