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

module banked_memory (clk, iaddr, maddr, mok, iok, instr, wenable, renable, wvalue, rvalue)
    input clk;
    input [63:0] iaddr, maddr;
    input wenable, renable;
    input [63:0] wvalue;

    output [79:0] instr;
    output [63:0] rvalue;
    output iok, mok;

    //out computer has a memory space of bytes. we want a memory circuit that
    //can access 8 or 10 bytes at a time. way we do it is that we have banks
    // that each return a byte at a time. then we wrap our mem space through the 
    // banks so that byte 1 is in bank 1 byte 2 bank2 and we do it mod 16 so
    // the last bits of the mem addr tell us which bank it is in, do it sequential
    // so first 60 bits tell us what byte in the bank to look for
    


//dual ported random access memory where we never write to the 2nd port
//could add another enable and wval.
//CS:APP says this works for simulation but real hardware does not normally
// allow combinatorial reads.
module bank (clk, iaddr, maddr, wenable, wval, mval, ival)
    parameter word_size = 8; //1 byte
    parameter word_count = 512;
    parameter address_size = 9; //log2 word count

    input clk;
    input [address_size - 1:0] iaddr;
    input [address_size - 1:0] maddr;
    input wenable;
    output [word_size - 1:0] mval, ival;

    reg [word_size - 1:0] mem [word_count -1:0];

    assign mval = mem[maddr]; //mux over 8bit regs
    assign ival = mem[iaddr];

    always @(posedge clk) begin
        if (wenable)
            mem[maddr] <= wval;
    end
endmodule


module clked_register (clk, write_enable, update_val, output_val, reset, reset_val)
    parameter reg_size = 64

    input clk;
    input write_enable;
    input [reg_size - 1 : 0] update_val;
    input reset;
    input [reg_size - 1 : 0] reset_val;
    output [reg_size - 1 : 0] output_val;


    reg [reg_size - 1:0] mem;

    always @(posedge clk) begin 
        if (reset == 1) 
            mem <= reset_val;
        else if (write_enable)
                mem <= update_val;
    end 
    assign output_val = mem;
endmodule



module splitter (instr, icode, ifunc)
    input wire [79:0] instr;
    output wire [3:0] icode, ifunc;

    assign icode = instr[79: 76]; //icode is the most sig bits of the instr
    assign ifunc = instr[75: 72];
endmodule

module align (instr, needs_regs, needs_valC, regA, regB, valC)
    input [79:0] instr;
    input needs_regs;
    output [3:0] regA;
    output [3:0] regB;
    output [63:0] valC;

    assign regA = instr[71:68];
    assign regB = instr[67:64];
    assign valC = needs_regs ? instr[71:8], instr[63:0];
endmodule

module new_PC_module (PC, needs_regs, needs_valC, new_PC)
    input [63:0] PC;
    input needs_regs, needs_valC;
    output [63:0] new_PC;            

    assign new_PC = needs_regs ? (needs_valC ? PC + 10 : PC + 2) : PC + 1;

endmodule

module reg_file (srcA, srcB, valA, valB, destA, destB, dest_val_A, dest_val_B) //can out reg for debug if we want
    input [3:0] srcA, srcB, destA, destB;
    input [63:0] dest_val_A, dest_val_B;
    output valA, valB;

    // the way the reg works is four mux's two connect regs to out, two connect in to regs
    // pretty sure that writing them as hex is not a problem but not 100%
    parameter REG0 = 4'h0;
    parameter REG1 = 4'h1;
    parameter REG2 = 4'h2;
    parameter REG3 = 4'h3;
    parameter REG4 = 4'h4;
    parameter REG5 = 4'h5;
    parameter REG6 = 4'h6;
    parameter REG7 = 4'h7;
    parameter REG8 = 4'h8;
    parameter REG9 = 4'h9;
    parameter REG10 = 4'hA;
    parameter REG11 = 4'hB;
    parameter REG12 = 4'hC;
    parameter REG13 = 4'hD;
    parameter REG14 = 4'hE;
    parameter REG15 = 4'hF;

    wire write_enable0;
    wire write_enable1;
    wire write_enable2;
    wire write_enable3;
    wire write_enable4;
    wire write_enable5;
    wire write_enable6;
    wire write_enable7;
    wire write_enable8;
    wire write_enable9;
    wire write_enable10;
    wire write_enable11;
    wire write_enable12;
    wire write_enable13;
    wire write_enable14;
    wire write_enable15;

    wire [63:0] update_val0;
    wire [63:0] update_val1;
    wire [63:0] update_val2;
    wire [63:0] update_val3;
    wire [63:0] update_val4;
    wire [63:0] update_val5;
    wire [63:0] update_val6;
    wire [63:0] update_val7;
    wire [63:0] update_val8;
    wire [63:0] update_val9;
    wire [63:0] update_val10;
    wire [63:0] update_val11;
    wire [63:0] update_val12;
    wire [63:0] update_val13;
    wire [63:0] update_val14;
    wire [63:0] update_val15;

    wire [63:0] out0;
    wire [63:0] out1;
    wire [63:0] out2;
    wire [63:0] out3;
    wire [63:0] out4;
    wire [63:0] out5;
    wire [63:0] out6;
    wire [63:0] out7;
    wire [63:0] out8;
    wire [63:0] out9;
    wire [63:0] out10;
    wire [63:0] out11;
    wire [63:0] out12;
    wire [63:0] out13;
    wire [63:0] out14;
    wire [63:0] out15;

    // regs
    clked_register reg0(clk, write_enable0, update_val0, out0, 0, 0);
    clked_register reg1(clk, write_enable1, update_val1, out1, 0, 0);
    clked_register reg2(clk, write_enable2, update_val2, out2, 0, 0);
    clked_register reg3(clk, write_enable3, update_val3, out3, 0, 0);
    clked_register reg4(clk, write_enable4, update_val4, out4, 0, 0);
    clked_register reg5(clk, write_enable5, update_val5, out5, 0, 0);
    clked_register reg6(clk, write_enable6, update_val6, out6, 0, 0);
    clked_register reg7(clk, write_enable7, update_val7, out7, 0, 0);
    clked_register reg8(clk, write_enable8, update_val8, out8, 0, 0);
    clked_register reg9(clk, write_enable9, update_val9, out9, 0, 0);
    clked_register reg10(clk, write_enable10, update_val10, out10, 0, 0);
    clked_register reg11(clk, write_enable11, update_val11, out11, 0, 0);
    clked_register reg12(clk, write_enable12, update_val12, out12, 0, 0);
    clked_register reg13(clk, write_enable13, update_val13, out13, 0, 0);
    clked_register reg14(clk, write_enable14, update_val14, out14, 0, 0);
    clked_register reg15(clk, write_enable15, update_val15, out15, 0, 0);


    assign valA = srcA == REG0 ? out0 :
        srcA == REG1 ? out1 :
        srcA == REG2 ? out2 :
        srcA == REG3 ? out3 :
        srcA == REG4 ? out4 :
        srcA == REG5 ? out5 :
        srcA == REG6 ? out6 :
        srcA == REG7 ? out7 :
        srcA == REG8 ? out8 :
        srcA == REG9 ? out9 :
        srcA == REG10 ? out10 :
        srcA == REG11 ? out11 :
        srcA == REG12 ? out12 :
        srcA == REG13 ? out13 :
        srcA == REG14 ? out14 :
        out15;

    assign valB = srcB == REG0 ? out0 :
        srcB == REG1 ? out1 :
        srcB == REG2 ? out2 :
        srcB == REG3 ? out3 :
        srcB == REG4 ? out4 :
        srcB == REG5 ? out5 :
        srcB == REG6 ? out6 :
        srcB == REG7 ? out7 :
        srcB == REG8 ? out8 :
        srcB == REG9 ? out9 :
        srcB == REG10 ? out10 :
        srcB == REG11 ? out11 :
        srcB == REG12 ? out12 :
        srcB == REG13 ? out13 :
        srcB == REG14 ? out14 :
        out15;

    assign update_val0 = destA == REG0 ? dest_val_A : dest_val_B;
    assign update_val1 = destA == REG1 ? dest_val_A : dest_val_B;
    assign update_val2 = destA == REG2 ? dest_val_A : dest_val_B;
    assign update_val3 = destA == REG3 ? dest_val_A : dest_val_B;
    assign update_val4 = destA == REG4 ? dest_val_A : dest_val_B;
    assign update_val5 = destA == REG5 ? dest_val_A : dest_val_B;
    assign update_val6 = destA == REG6 ? dest_val_A : dest_val_B;
    assign update_val7 = destA == REG7 ? dest_val_A : dest_val_B;
    assign update_val8 = destA == REG8 ? dest_val_A : dest_val_B;
    assign update_val9 = destA == REG9 ? dest_val_A : dest_val_B;
    assign update_val10 = destA == REG10 ? dest_val_A : dest_val_B;
    assign update_val11 = destA == REG11 ? dest_val_A : dest_val_B;
    assign update_val12 = destA == REG12 ? dest_val_A : dest_val_B;
    assign update_val13 = destA == REG13 ? dest_val_A : dest_val_B;
    assign update_val14 = destA == REG14 ? dest_val_A : dest_val_B;
    assign update_val15 = destA == REG15 ? dest_val_A : dest_val_B;

    assign write_enable0 = destA == REG0 || destB == REG0;
    assign write_enable1 = destA == REG1 || destB == REG1;
    assign write_enable2 = destA == REG2 || destB == REG2;
    assign write_enable3 = destA == REG3 || destB == REG3;
    assign write_enable4 = destA == REG4 || destB == REG4;
    assign write_enable5 = destA == REG5 || destB == REG5;
    assign write_enable6 = destA == REG6 || destB == REG6;
    assign write_enable7 = destA == REG7 || destB == REG7;
    assign write_enable8 = destA == REG8 || destB == REG8;
    assign write_enable9 = destA == REG9 || destB == REG9;
    assign write_enable10 = destA == REG10 || destB == REG10;
    assign write_enable11 = destA == REG11 || destB == REG11;
    assign write_enable12 = destA == REG12 || destB == REG12;
    assign write_enable13 = destA == REG13 || destB == REG13;
    assign write_enable14 = destA == REG14 || destB == REG14;
    assign write_enable15 = destA == REG15 || destB == REG15;
endmodule


module alu (valA, valB, valC, aluFUNC, CCodes, outVal)
    input [63:0] valA;
    input [63:0] valB;
    input [63:0] valC;
    input [3:0] aluFUNC;
    output [3:0] CCodes;
    output [63:0] outVal;

    parameter ADD = 4'h0;
    parameter XOR = 4'h1;
    parameter AND = 4'h2;
    parameter SUB = 4'h3;

    assign outVal = aluFUNC == ADD ? valA + valB : 
                    aluFUNC == XOR ? valA ^ valB : //think this is XOR
                    aluFUNC == AND ? valA & valB : valA - valB;

    //set CCodes
    //only need 3 bits but not going to change num
    // codes are is_zero, is negative, overflow occured 

    assign CCodes[2] = outVal == 0;
    assign CCodes[1] = outVal[63];
    assign CCodes[0] = aluFUNC == ADD ? ((valA[63] == valB[63]) & (valA[63] != outVal[63])) :
                        aluFUNC == SUB ? ((~valA[63] == valb[63]) & (~valA[63] != outVal[63])) : 0;
    

endmodule

    



module processor (clk)

    //instruction codes for CS:APP x86 subset
    parameter IHALT = 4’h0;
    parameter INOP = 4’h1;
    parameter IRRMOVQ = 4’h2; // reg to reg move
    parameter IIRMOVQ = 4’h3; // imediate to reg move
    parameter IRMMOVQ = 4’h4; // reg to mem move
    parameter IMRMOVQ = 4’h5; // mem to reg move
    parameter IOPQ = 4’h6;
    parameter IJXX = 4’h7;
    parameter ICALL = 4’h8; // push ret to stack, jmp to dest
    parameter IRET = 4’h9 // ret
    parameter IPUSHQ = 4’hA;
    parameter IPOPQ = 4’hB;
    parameter IIADDQ = 4’hC; // add reg A to reg B, place in B
    parameter ILEAVE = 4’hD;
    parameter IPOP2 = 4’hE;

    input clk;

    reg [63:0] PC;
    wire [63:0] new_PC;
    wire [79:0] instr;
    wire [3:0] icode;
    wire [3:0] ifunc;
    wire needs_regs;
    wire needs_valC;

    wire [3:0] regA;
    wire [3:0] regB;
    wire [63:0] valC;

    wire [63:0] valA, valB;
    wire [3:0] destA, destB;
    wire [63:0] dest_val_A, dest_val_B;

    wire [3:0] aluFUNC;
    wire [3:0] CCodes;

    wire [63:0] ALUOut;


    read_only_ram ram(PC, instr);
    //instruction on wire, now we need to extract pieces of it
    splitter split (instr, icode, ifunc);
    align aligner (instr, needs_regs, needs_valC, regA, regB, valC);

    reg_file regs (regA, regB, valA, valB, destA, destB, dest_val_A, dest_val_B);

    alu ALU (valA, valB, valC, aluFUNC, CCodes, ALUOut);


    





    assign needs_regs = (icode == IIADDQ || icode == IMRMOVQ || icode == IRMMOVQ || icode == IRRMOVQ || icode == IIRMOVQ);
    assign needs_valC = ( icode ==  IRMMOVQ || icode == IMRMOVQ || icode == IIRMOVQ || icode == ICALL || icode == jmp);
    // if (icode == IIADDQ || icode == IMRMOVQ || icode == IRMMOVQ || icode == IRRMOVQ || icode == IIRMOVQ) begin  //might be wrong
    //     assign needs_regs = 1;
    //     else
    //         assign  needs_regs = 0;
    // end 

    







    always @(posedge clk)
        PC <= new_PC;
