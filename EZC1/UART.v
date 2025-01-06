// I want to make a UART!  A UART takes in a clock signal and a data source and
// sends that data over its output pin at a specific frequency. 
// lets assume clk is 1 GHz = 1 billion ossilations/s, normal baude is 115200/s
// so ~1000x less. we will just do 10x less to start

// UART protocol we will use is 0 + 8xDataBits + 00

module UART (
    input wire [7:0] data, 
    input wire clk,
    input wire send,
    output reg [0:0] sender
);

reg [3:0] states;

initial begin
    states = 0;
end

always @(posedge clk) begin
    //require send signal to send.
    if (send) begin 
        states <= states + 1;
        case (states)
            0: sender <= 1; //base
            1: sender <= 0; //pull high 
            2: sender <= data[0];
            3: sender <= data[1];
            4: sender <= data[2];
            5: sender <= data[3];
            6: sender <= data[4];
            7: sender <= data[5];
            8: sender <= data[6];
            9: sender <=  data[7];
            10: sender <= 0;
            11: sender <= 0;
            12: states <= 0;
        endcase 

    end else begin
        states <= 0;
    end
end
endmodule

module Testbench ();
    reg clk;
    reg [7:0] data;
    reg send;
    wire out;

    UART uart(.data(data), .clk(clk), .send(send), .sender(out));

initial begin
    clk = 0;
    data = 8'b1111_1111;
    send = 0;
end 

always 
    begin
        clk = 1; #5; clk = 0; #5;
    end 

initial
#10 send = 1;

always @(posedge clk)
$display("Time = %t the clk signal is %b data is %b send is %b and out is %b ", $time, clk, data, send, out);  // 1, 2


initial
#200 $finish;

endmodule