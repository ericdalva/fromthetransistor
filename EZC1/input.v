module input_module (
    input wire start,
    input wire clk,
    output reg [31:0] number 
);

always @( posedge clk ) begin

    if (start == 1 ) begin
        $fscanf("%b", number);
    end 
    else 
        number <= number;
end 

 


endmodule

module input_tb ();
reg clk;
reg start;
integer file_handle;
wire [31:0] number;

input_module dut (.start(start), .clk(clk), .number(number));


initial begin 

    file_handle = $fopen("input_test.txt", "w");
    start = 0; 
    clk = 0;
    forever begin
        clk = 0; #5; clk = 1; #5;
    end
    #50;
    start = 1;
    #10;
    start = 0;
    #10;
    start = 1;
    #10;


    $finish;

end 

always @(clk) begin
        $fwrite(file_handle, "%b\n", number);
        $display("Time = %0t clk activated start was %b number was %b", $time, start, number);
end 




endmodule