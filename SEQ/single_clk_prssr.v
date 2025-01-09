module read_only_ram (address, instr)
   input [9:0] address; // address is the position of the byte 
   output [79:0] instr; // always return 10 bytes

   reg [7:0] mem [1023:0];
   
   // Concatenate 10 bytes left to right (big-endian)
   assign instr = {
       mem[address],      // leftmost byte (first executed)
       mem[address+1],
       mem[address+2],
       mem[address+3],
       mem[address+4],
       mem[address+5],
       mem[address+6],
       mem[address+7],
       mem[address+8],
       mem[address+9]     // rightmost byte (last executed)
   };

endmodule

module processor (clk)
    input clk;

    reg [9:0] PC;
    wire [9:0] new_PC;
    wire [79:0] instr;

    read_only_ram ram(PC, instr);

    always @(posedge clk)
        PC <= new_PC;
    