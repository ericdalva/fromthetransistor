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
    parameter word_size = 8; //1 byte
    parameter word_count = 512;
    parameter address_size = 9; //log2 word count
    parameter mem_size = 8192;
    
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
    // so first 60 bits tell us what byte in the bank to look fo
    
    //instruction bytes
    wire [7:0] ib0, ib1, ib2, ib3, ib4, ib5, ib6, ib7, ib8, ib9;
    // data bytes
    wire [7:0] db0, db1, db2, db3, db4, db5, db6, db7; 

    wire [3:0] ibid = iaddr[3:0]; //instruction bank id
    wire [59:0] iindex = iaddr[63:4];
    wire [59:0] iindexp1 = iindex +1;

    wire [3:0] mbid = maddr[3:0]; //memory bank id
    wire [59:0] mindex = maddr[63:4];
    wire [59:0] mindexp1 = mindex +1;


    



    //wires and bank hookups
    wire [address_size -1:0] iaddr0, maddr0;
    wire [address_size -1:0] iaddr1, maddr1;
    wire [address_size -1:0] iaddr2, maddr2;
    wire [address_size -1:0] iaddr3, maddr3;
    wire [address_size -1:0] iaddr4, maddr4;
    wire [address_size -1:0] iaddr5, maddr5;
    wire [address_size -1:0] iaddr6, maddr6;
    wire [address_size -1:0] iaddr7, maddr7;
    wire [address_size -1:0] iaddr8, maddr8;
    wire [address_size -1:0] iaddr9, maddr9;
    wire [address_size -1:0] iaddr10, maddr10;
    wire [address_size -1:0] iaddr11, maddr11;
    wire [address_size -1:0] iaddr12, maddr12;
    wire [address_size -1:0] iaddr13, maddr13;
    wire [address_size -1:0] iaddr14, maddr14;
    wire [address_size -1:0] iaddr15, maddr15;

    wire [word_size -1:0] wval0, mval0, ival0;
    wire [word_size -1:0] wval1, mval1, ival1;
    wire [word_size -1:0] wval2, mval2, ival2;
    wire [word_size -1:0] wval3, mval3, ival3;
    wire [word_size -1:0] wval4, mval4, ival4;
    wire [word_size -1:0] wval5, mval5, ival5;
    wire [word_size -1:0] wval6, mval6, ival6;
    wire [word_size -1:0] wval7, mval7, ival7;
    wire [word_size -1:0] wval8, mval8, ival8;
    wire [word_size -1:0] wval9, mval9, ival9;
    wire [word_size -1:0] wval10, mval10, ival10;
    wire [word_size -1:0] wval11, mval11, ival11;
    wire [word_size -1:0] wval12, mval12, ival12;
    wire [word_size -1:0] wval13, mval13, ival13;
    wire [word_size -1:0] wval14, mval14, ival14;
    wire [word_size -1:0] wval15, mval15, ival15;

    wire wenable0;
    wire wenable1;
    wire wenable2;
    wire wenable3;
    wire wenable4;
    wire wenable5;
    wire wenable6;
    wire wenable7;
    wire wenable8;
    wire wenable9;
    wire wenable10;
    wire wenable11;
    wire wenable12;
    wire wenable13;
    wire wenable14;
    wire wenable15;

    bank bank0(clk, iaddr0, maddr0, wenable0, wval0, ival0, mval0);
    bank bank1(clk, iaddr1, maddr1, wenable1, wval1, ival1, mval1);
    bank bank2(clk, iaddr2, maddr2, wenable2, wval2, ival2, mval2);
    bank bank3(clk, iaddr3, maddr3, wenable3, wval3, ival3, mval3);
    bank bank4(clk, iaddr4, maddr4, wenable4, wval4, ival4, mval4);
    bank bank5(clk, iaddr5, maddr5, wenable5, wval5, ival5, mval5);
    bank bank6(clk, iaddr6, maddr6, wenable6, wval6, ival6, mval6);
    bank bank7(clk, iaddr7, maddr7, wenable7, wval7, ival7, mval7);
    bank bank8(clk, iaddr8, maddr8, wenable8, wval8, ival8, mval8);
    bank bank9(clk, iaddr9, maddr9, wenable9, wval9, ival9, mval9);
    bank bank10(clk, iaddr10, maddr10, wenable10, wval10, ival10, mval10);
    bank bank11(clk, iaddr11, maddr11, wenable11, wval11, ival11, mval11);
    bank bank12(clk, iaddr12, maddr12, wenable12, wval12, ival12, mval12);
    bank bank13(clk, iaddr13, maddr13, wenable13, wval13, ival13, mval13);
    bank bank14(clk, iaddr14, maddr14, wenable14, wval14, ival14, mval14);
    bank bank15(clk, iaddr15, maddr15, wenable15, wval15, ival15, mval15);


    //Determine instruction addr for the banks

    assign iaddr0 = ibid >= 7 ? iindexp1 : iindex; //wraps to plus one 
    assign iaddr1 = ibid >= 8 ? iindexp1 : iindex;
    assign iaddr2 = ibid >= 9 ? iindexp1 : iindex;
    assign iaddr3 = ibid >= 10 ? iindexp1 : iindex;
    assign iaddr4 = ibid >= 11 ? iindexp1 : iindex;
    assign iaddr5 = ibid >= 12 ? iindexp1 : iindex;
    assign iaddr6 = ibid >= 13 ? iindexp1 : iindex;
    assign iaddr7 = ibid >= 14 ? iindexp1 : iindex;
    assign iaddr8 = ibid >= 15 ? iindexp1 : iindex;
    assign iaddr9 = iindex;
    assign iaddr10 = iindex;
    assign iaddr11 = iindex;
    assign iaddr12 = iindex;
    assign iaddr13 = iindex;
    assign iaddr14 = iindex;
    assign iaddr15 = iindex;

    //Determine mem addr for the banks
    assign maddr0 = ibid >= 9 ? mindexp1 : mindex;
    assign maddr1 = ibid >= 10 ? mindexp1 : mindex;
    assign maddr2 = ibid >= 11 ? mindexp1 : mindex;
    assign maddr3 = ibid >= 12 ? mindexp1 : mindex;
    assign maddr4 = ibid >= 13 ? mindexp1 : mindex;
    assign maddr5 = ibid >= 14 ? mindexp1 : mindex;
    assign maddr6 = ibid >= 15 ? mindexp1 : mindex;
    assign maddr7 = mindex;
    assign maddr8 = mindex;
    assign maddr9 = mindex;
    assign maddr10 = mindex;
    assign maddr11 = mindex;
    assign maddr12 = mindex;

    // getting bytes of instruction 
    






//dual ported random access memory where we will use A as the instr port.
//CS:APP says this works for simulation but real hardware does not normally
// allow combinatorial reads.
module bank (clk, addrA, addrB, wenableA, wenableB, wvalA, wvalB, valA, valB)
    parameter word_size = 8; //1 byte
    parameter word_count = 512;
    parameter address_size = 9; //log2 word count

    input clk;
    input wenableA wenableB;
    input [address_size - 1:0] addrA, addrB;
    input [word_size -1:0] wvalA, wvalB;

    output [word_size - 1:0] mval, ival;

    reg [word_size - 1:0] mem [word_count -1:0];

    assign valA = mem[addrA]; //mux over 8bit regs
    assign valB = mem[addrB];


    always @(posedge clk) begin
        if (wenableA)
            mem[addrA] <= wvalA;
        if (wenableB)
            mem[addrB] <= wvalB;
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
