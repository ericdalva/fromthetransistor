module read_only_ram (address, instr);
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

module banked_memory (clk, iaddr, maddr, mok, iok, instr, wenable, renable, wvalue, rvalue);
    parameter word_size = 8;    // 1 byte
    parameter word_count = 512;
    parameter address_size = 9; // log2 word count
    parameter mem_size = 8192; //in words
    
    input clk;
    input [63:0] iaddr, maddr;
    input wenable, renable;
    input [63:0] wvalue;

    output [79:0] instr;
    output [63:0] rvalue;
    output iok, mok;

    wire iok, mok;
    assign iok = (iaddr >= 0 & iaddr <= mem_size - 10);
    assign mok = (maddr >= 0 & maddr <= mem_size - 8);

    // Computer has a memory space of bytes. We want a memory circuit that
    // can access 8 or 10 bytes at a time. We do it using banks that each 
    // return a byte at a time. Then we wrap our mem space through the banks
    // so that byte 1 is in bank 1, byte 2 in bank 2, etc. mod 16.
    // Last bits of mem addr tell us which bank, first 60 bits tell us byte in bank.
    
    // Instruction bytes
    wire [7:0] ib0, ib1, ib2, ib3, ib4, ib5, ib6, ib7, ib8, ib9;
    // Data bytes
    wire [7:0] db0, db1, db2, db3, db4, db5, db6, db7;

    wire [3:0] ibid = iaddr[3:0];    // Instruction bank id
    wire [59:0] iindex = iaddr[63:4];
    wire [59:0] iindexp1 = iindex + 1;

    wire [3:0] mbid = maddr[3:0];    // Memory bank id  
    wire [59:0] mindex = maddr[63:4];
    wire [59:0] mindexp1 = mindex + 1;

    // Bank address wires
    wire [address_size-1:0] iaddr0, maddr0;
    wire [address_size-1:0] iaddr1, maddr1;
    wire [address_size-1:0] iaddr2, maddr2;
    wire [address_size-1:0] iaddr3, maddr3;
    wire [address_size-1:0] iaddr4, maddr4;
    wire [address_size-1:0] iaddr5, maddr5;
    wire [address_size-1:0] iaddr6, maddr6;
    wire [address_size-1:0] iaddr7, maddr7;
    wire [address_size-1:0] iaddr8, maddr8;
    wire [address_size-1:0] iaddr9, maddr9;
    wire [address_size-1:0] iaddr10, maddr10;
    wire [address_size-1:0] iaddr11, maddr11;
    wire [address_size-1:0] iaddr12, maddr12;
    wire [address_size-1:0] iaddr13, maddr13;
    wire [address_size-1:0] iaddr14, maddr14;
    wire [address_size-1:0] iaddr15, maddr15;

    // Bank data wires
    wire [word_size-1:0] wval0, mval0, ival0;
    wire [word_size-1:0] wval1, mval1, ival1;
    wire [word_size-1:0] wval2, mval2, ival2;
    wire [word_size-1:0] wval3, mval3, ival3;
    wire [word_size-1:0] wval4, mval4, ival4;
    wire [word_size-1:0] wval5, mval5, ival5;
    wire [word_size-1:0] wval6, mval6, ival6;
    wire [word_size-1:0] wval7, mval7, ival7;
    wire [word_size-1:0] wval8, mval8, ival8;
    wire [word_size-1:0] wval9, mval9, ival9;
    wire [word_size-1:0] wval10, mval10, ival10;
    wire [word_size-1:0] wval11, mval11, ival11;
    wire [word_size-1:0] wval12, mval12, ival12;
    wire [word_size-1:0] wval13, mval13, ival13;
    wire [word_size-1:0] wval14, mval14, ival14;
    wire [word_size-1:0] wval15, mval15, ival15;

    // Write enable wires
    wire wenable0, wenable1, wenable2, wenable3;
    wire wenable4, wenable5, wenable6, wenable7;
    wire wenable8, wenable9, wenable10, wenable11;
    wire wenable12, wenable13, wenable14, wenable15;

    // Instantiate memory banks
    bank bank0(clk, iaddr0, maddr0, 0, wenable0, 0, wval0, ival0, mval0);
    bank bank1(clk, iaddr1, maddr1, 0, wenable1, 0, wval1, ival1, mval1);
    bank bank2(clk, iaddr2, maddr2, 0, wenable2, 0, wval2, ival2, mval2);
    bank bank3(clk, iaddr3, maddr3, 0, wenable3, 0, wval3, ival3, mval3);
    bank bank4(clk, iaddr4, maddr4, 0, wenable4, 0, wval4, ival4, mval4);
    bank bank5(clk, iaddr5, maddr5, 0, wenable5, 0, wval5, ival5, mval5);
    bank bank6(clk, iaddr6, maddr6, 0, wenable6, 0, wval6, ival6, mval6);
    bank bank7(clk, iaddr7, maddr7, 0, wenable7, 0, wval7, ival7, mval7);
    bank bank8(clk, iaddr8, maddr8, 0, wenable8, 0, wval8, ival8, mval8);
    bank bank9(clk, iaddr9, maddr9, 0, wenable9, 0, wval9, ival9, mval9);
    bank bank10(clk, iaddr10, maddr10, 0, wenable10, 0, wval10, ival10, mval10);
    bank bank11(clk, iaddr11, maddr11, 0, wenable11, 0, wval11, ival11, mval11);
    bank bank12(clk, iaddr12, maddr12, 0, wenable12, 0, wval12, ival12, mval12);
    bank bank13(clk, iaddr13, maddr13, 0, wenable13, 0, wval13, ival13, mval13);
    bank bank14(clk, iaddr14, maddr14, 0, wenable14, 0, wval14, ival14, mval14);
    bank bank15(clk, iaddr15, maddr15, 0, wenable15, 0, wval15, ival15, mval15);

    // Determine instruction addresses for banks
    assign iaddr0 = ibid >= 7 ? iindexp1 : iindex;
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

    // Determine memory addresses for banks
    assign maddr0 = mbid >= 9 ? mindexp1 : mindex;
    assign maddr1 = mbid >= 10 ? mindexp1 : mindex;
    assign maddr2 = mbid >= 11 ? mindexp1 : mindex;
    assign maddr3 = mbid >= 12 ? mindexp1 : mindex;
    assign maddr4 = mbid >= 13 ? mindexp1 : mindex;
    assign maddr5 = mbid >= 14 ? mindexp1 : mindex;
    assign maddr6 = mbid >= 15 ? mindexp1 : mindex;
    assign maddr7 = mindex;
    assign maddr8 = mindex;
    assign maddr9 = mindex;
    assign maddr10 = mindex;
    assign maddr11 = mindex;
    assign maddr12 = mindex;
    assign maddr13 = mindex;
    assign maddr14 = mindex;
    assign maddr15 = mindex;


    // this part is gross! I am sure there is a better way but I also 
    // spent more time thinking about it then it took to actually just implement it

        assign ib0 = !iok ? 0 :
                ibid == 0 ? ival0 :
                ibid == 1 ? ival1 :
                ibid == 2 ? ival2 :
                ibid == 3 ? ival3 :
                ibid == 4 ? ival4 :
                ibid == 5 ? ival5 :
                ibid == 6 ? ival6 :
                ibid == 7 ? ival7 :
                ibid == 8 ? ival8 :
                ibid == 9 ? ival9 :
                ibid == 10 ? ival10 :
                ibid == 11 ? ival11 :
                ibid == 12 ? ival12 :
                ibid == 13 ? ival13 :
                ibid == 14 ? ival14 :
                ibid == 15 ? ival15 :
                0;

        assign ib1 = !iok ? 0 :
                ibid == 0 ? ival1 :
                ibid == 1 ? ival2 :
                ibid == 2 ? ival3 :
                ibid == 3 ? ival4 :
                ibid == 4 ? ival5 :
                ibid == 5 ? ival6 :
                ibid == 6 ? ival7 :
                ibid == 7 ? ival8 :
                ibid == 8 ? ival9 :
                ibid == 9 ? ival10 :
                ibid == 10 ? ival11 :
                ibid == 11 ? ival12 :
                ibid == 12 ? ival13 :
                ibid == 13 ? ival14 :
                ibid == 14 ? ival15 :
                ibid == 15 ? ival0 :
                0;

        assign ib2 = !iok ? 0 :
                ibid == 0 ? ival2 :
                ibid == 1 ? ival3 :
                ibid == 2 ? ival4 :
                ibid == 3 ? ival5 :
                ibid == 4 ? ival6 :
                ibid == 5 ? ival7 :
                ibid == 6 ? ival8 :
                ibid == 7 ? ival9 :
                ibid == 8 ? ival10 :
                ibid == 9 ? ival11 :
                ibid == 10 ? ival12 :
                ibid == 11 ? ival13 :
                ibid == 12 ? ival14 :
                ibid == 13 ? ival15 :
                ibid == 14 ? ival0 :
                ibid == 15 ? ival1 :
                0;

        assign ib3 = !iok ? 0 :
                ibid == 0 ? ival3 :
                ibid == 1 ? ival4 :
                ibid == 2 ? ival5 :
                ibid == 3 ? ival6 :
                ibid == 4 ? ival7 :
                ibid == 5 ? ival8 :
                ibid == 6 ? ival9 :
                ibid == 7 ? ival10 :
                ibid == 8 ? ival11 :
                ibid == 9 ? ival12 :
                ibid == 10 ? ival13 :
                ibid == 11 ? ival14 :
                ibid == 12 ? ival15 :
                ibid == 13 ? ival0 :
                ibid == 14 ? ival1 :
                ibid == 15 ? ival2 :
                0;

        assign ib4 = !iok ? 0 :
                ibid == 0 ? ival4 :
                ibid == 1 ? ival5 :
                ibid == 2 ? ival6 :
                ibid == 3 ? ival7 :
                ibid == 4 ? ival8 :
                ibid == 5 ? ival9 :
                ibid == 6 ? ival10 :
                ibid == 7 ? ival11 :
                ibid == 8 ? ival12 :
                ibid == 9 ? ival13 :
                ibid == 10 ? ival14 :
                ibid == 11 ? ival15 :
                ibid == 12 ? ival0 :
                ibid == 13 ? ival1 :
                ibid == 14 ? ival2 :
                ibid == 15 ? ival3 :
                0;

        assign ib5 = !iok ? 0 :
                ibid == 0 ? ival5 :
                ibid == 1 ? ival6 :
                ibid == 2 ? ival7 :
                ibid == 3 ? ival8 :
                ibid == 4 ? ival9 :
                ibid == 5 ? ival10 :
                ibid == 6 ? ival11 :
                ibid == 7 ? ival12 :
                ibid == 8 ? ival13 :
                ibid == 9 ? ival14 :
                ibid == 10 ? ival15 :
                ibid == 11 ? ival0 :
                ibid == 12 ? ival1 :
                ibid == 13 ? ival2 :
                ibid == 14 ? ival3 :
                ibid == 15 ? ival4 :
                0;

        assign ib6 = !iok ? 0 :
                ibid == 0 ? ival6 :
                ibid == 1 ? ival7 :
                ibid == 2 ? ival8 :
                ibid == 3 ? ival9 :
                ibid == 4 ? ival10 :
                ibid == 5 ? ival11 :
                ibid == 6 ? ival12 :
                ibid == 7 ? ival13 :
                ibid == 8 ? ival14 :
                ibid == 9 ? ival15 :
                ibid == 10 ? ival0 :
                ibid == 11 ? ival1 :
                ibid == 12 ? ival2 :
                ibid == 13 ? ival3 :
                ibid == 14 ? ival4 :
                ibid == 15 ? ival5 :
                0;

        assign ib7 = !iok ? 0 :
                ibid == 0 ? ival7 :
                ibid == 1 ? ival8 :
                ibid == 2 ? ival9 :
                ibid == 3 ? ival10 :
                ibid == 4 ? ival11 :
                ibid == 5 ? ival12 :
                ibid == 6 ? ival13 :
                ibid == 7 ? ival14 :
                ibid == 8 ? ival15 :
                ibid == 9 ? ival0 :
                ibid == 10 ? ival1 :
                ibid == 11 ? ival2 :
                ibid == 12 ? ival3 :
                ibid == 13 ? ival4 :
                ibid == 14 ? ival5 :
                ibid == 15 ? ival6 :
                0;

        assign ib8 = !iok ? 0 :
                ibid == 0 ? ival8 :
                ibid == 1 ? ival9 :
                ibid == 2 ? ival10 :
                ibid == 3 ? ival11 :
                ibid == 4 ? ival12 :
                ibid == 5 ? ival13 :
                ibid == 6 ? ival14 :
                ibid == 7 ? ival15 :
                ibid == 8 ? ival0 :
                ibid == 9 ? ival1 :
                ibid == 10 ? ival2 :
                ibid == 11 ? ival3 :
                ibid == 12 ? ival4 :
                ibid == 13 ? ival5 :
                ibid == 14 ? ival6 :
                ibid == 15 ? ival7 :
                0;

        assign ib9 = !iok ? 0 :
                ibid == 0 ? ival9 :
                ibid == 1 ? ival10 :
                ibid == 2 ? ival11 :
                ibid == 3 ? ival12 :
                ibid == 4 ? ival13 :
                ibid == 5 ? ival14 :
                ibid == 6 ? ival15 :
                ibid == 7 ? ival0 :
                ibid == 8 ? ival1 :
                ibid == 9 ? ival2 :
                ibid == 10 ? ival3 :
                ibid == 11 ? ival4 :
                ibid == 12 ? ival5 :
                ibid == 13 ? ival6 :
                ibid == 14 ? ival7 :
                ibid == 15 ? ival8 :
                0;

        assign db0 = !mok ? 0 :
                mbid == 0 ? mval0 :
                mbid == 1 ? mval1 :
                mbid == 2 ? mval2 :
                mbid == 3 ? mval3 :
                mbid == 4 ? mval4 :
                mbid == 5 ? mval5 :
                mbid == 6 ? mval6 :
                mbid == 7 ? mval7 :
                mbid == 8 ? mval8 :
                mbid == 9 ? mval9 :
                mbid == 10 ? mval10 :
                mbid == 11 ? mval11 :
                mbid == 12 ? mval12 :
                mbid == 13 ? mval13 :
                mbid == 14 ? mval14 :
                mbid == 15 ? mval15 :
                0;

        assign db1 = !mok ? 0 :
                mbid == 0 ? mval1 :
                mbid == 1 ? mval2 :
                mbid == 2 ? mval3 :
                mbid == 3 ? mval4 :
                mbid == 4 ? mval5 :
                mbid == 5 ? mval6 :
                mbid == 6 ? mval7 :
                mbid == 7 ? mval8 :
                mbid == 8 ? mval9 :
                mbid == 9 ? mval10 :
                mbid == 10 ? mval11 :
                mbid == 11 ? mval12 :
                mbid == 12 ? mval13 :
                mbid == 13 ? mval14 :
                mbid == 14 ? mval15 :
                mbid == 15 ? mval0 :
                0;

        assign db2 = !mok ? 0 :
                mbid == 0 ? mval2 :
                mbid == 1 ? mval3 :
                mbid == 2 ? mval4 :
                mbid == 3 ? mval5 :
                mbid == 4 ? mval6 :
                mbid == 5 ? mval7 :
                mbid == 6 ? mval8 :
                mbid == 7 ? mval9 :
                mbid == 8 ? mval10 :
                mbid == 9 ? mval11 :
                mbid == 10 ? mval12 :
                mbid == 11 ? mval13 :
                mbid == 12 ? mval14 :
                mbid == 13 ? mval15 :
                mbid == 14 ? mval0 :
                mbid == 15 ? mval1 :
                0;

        assign db3 = !mok ? 0 :
                mbid == 0 ? mval3 :
                mbid == 1 ? mval4 :
                mbid == 2 ? mval5 :
                mbid == 3 ? mval6 :
                mbid == 4 ? mval7 :
                mbid == 5 ? mval8 :
                mbid == 6 ? mval9 :
                mbid == 7 ? mval10 :
                mbid == 8 ? mval11 :
                mbid == 9 ? mval12 :
                mbid == 10 ? mval13 :
                mbid == 11 ? mval14 :
                mbid == 12 ? mval15 :
                mbid == 13 ? mval0 :
                mbid == 14 ? mval1 :
                mbid == 15 ? mval2 :
                0;

        assign db4 = !mok ? 0 :
                mbid == 0 ? mval4 :
                mbid == 1 ? mval5 :
                mbid == 2 ? mval6 :
                mbid == 3 ? mval7 :
                mbid == 4 ? mval8 :
                mbid == 5 ? mval9 :
                mbid == 6 ? mval10 :
                mbid == 7 ? mval11 :
                mbid == 8 ? mval12 :
                mbid == 9 ? mval13 :
                mbid == 10 ? mval14 :
                mbid == 11 ? mval15 :
                mbid == 12 ? mval0 :
                mbid == 13 ? mval1 :
                mbid == 14 ? mval2 :
                mbid == 15 ? mval3 :
                0;

        assign db5 = !mok ? 0 :
                mbid == 0 ? mval5 :
                mbid == 1 ? mval6 :
                mbid == 2 ? mval7 :
                mbid == 3 ? mval8 :
                mbid == 4 ? mval9 :
                mbid == 5 ? mval10 :
                mbid == 6 ? mval11 :
                mbid == 7 ? mval12 :
                mbid == 8 ? mval13 :
                mbid == 9 ? mval14 :
                mbid == 10 ? mval15 :
                mbid == 11 ? mval0 :
                mbid == 12 ? mval1 :
                mbid == 13 ? mval2 :
                mbid == 14 ? mval3 :
                mbid == 15 ? mval4 :
                0;

        assign db6 = !mok ? 0 :
                mbid == 0 ? mval6 :
                mbid == 1 ? mval7 :
                mbid == 2 ? mval8 :
                mbid == 3 ? mval9 :
                mbid == 4 ? mval10 :
                mbid == 5 ? mval11 :
                mbid == 6 ? mval12 :
                mbid == 7 ? mval13 :
                mbid == 8 ? mval14 :
                mbid == 9 ? mval15 :
                mbid == 10 ? mval0 :
                mbid == 11 ? mval1 :
                mbid == 12 ? mval2 :
                mbid == 13 ? mval3 :
                mbid == 14 ? mval4 :
                mbid == 15 ? mval5 : 0;
        
        assign db7 = !mok ? 0 :
                mbid == 0 ? mval7 :
                mbid == 1 ? mval8 :
                mbid == 2 ? mval9 :
                mbid == 3 ? mval10 :
                mbid == 4 ? mval11 :
                mbid == 5 ? mval12 :
                mbid == 6 ? mval13 :
                mbid == 7 ? mval14 :
                mbid == 8 ? mval15 :
                mbid == 9 ? mval0 :
                mbid == 10 ? mval1 :
                mbid == 11 ? mval2 :
                mbid == 12 ? mval3 :
                mbid == 13 ? mval4 :
                mbid == 14 ? mval5 :
                mbid == 15 ? mval6 : 0;


        //finished reading
    assign instr = {ib0, ib1, ib2, ib3, ib4, ib5, ib6, ib7, ib8, ib9};
    assign rvalue = {db0, db1, db2, db3, db4, db5, db6, db7};
    //now sending correct write value to banks

    wire [7:0] wb0, wb1, wb2, wb3, wb4, wb5, wb6, wb7;
    //we be BIG ENDIAN it up
    assign wb0 = wvalue[63:56];  
    assign wb1 = wvalue[55:48];
    assign wb2 = wvalue[47:40];
    assign wb3 = wvalue[39:32];
    assign wb4 = wvalue[31:24];
    assign wb5 = wvalue[23:16];
    assign wb6 = wvalue[15:8];
    assign wb7 = wvalue[7:0]; 

    assign wval0 = mbid == 0 ? wb0 :
                    mbid == 1 ? 0 :
                    mbid == 2 ? 0 : 
                    mbid == 3 ? 0 :
                    mbid == 4 ? 0 :
                    mbid == 5 ? 0 :
                    mbid  == 6 ? 0 :
                    mbid  == 7 ? 0 :
                    mbid == 8 ? 0:
                    mbid == 9 ? wb7 :
                    mbid == 10 ? wb6 : 
                    mbid == 11 ? wb5 :
                    mbid == 12 ? wb4 :
                    mbid  == 13 ? wb3 :
                    mbid == 14 ? wb2 : wb1;
    
    assign wval1  = mbid == 0 ? wb1 :
                    mbid == 1 ? wb0 :
                    mbid == 2 ? 0 :
                    mbid == 3 ? 0 :
                    mbid == 4 ? 0 :
                    mbid == 5 ? 0 :
                    mbid == 6 ? 0 :
                    mbid == 7 ? 0 :
                    mbid == 8 ? 0 :
                    mbid == 9 ? 0 :
                    mbid == 10 ? wb7 :
                    mbid == 11 ? wb6 :
                    mbid == 12 ? wb5 :
                    mbid == 13 ? wb4 :
                    mbid == 14 ? wb3 : wb2;
    
    assign wval2 = mbid == 0 ? wb2 :
                mbid == 1 ? wb1 :
                mbid == 2 ? wb0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? wb7 :
                mbid == 12 ? wb6 :
                mbid == 13 ? wb5 :
                mbid == 14 ? wb4 : wb3;

    assign wval3 = mbid == 0 ? wb3 :
                mbid == 1 ? wb2 :
                mbid == 2 ? wb1 :
                mbid == 3 ? wb0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? wb7 :
                mbid == 13 ? wb6 :
                mbid == 14 ? wb5 : wb4;

    assign wval4 = mbid == 0 ? wb4 :
                mbid == 1 ? wb3 :
                mbid == 2 ? wb2 :
                mbid == 3 ? wb1 :
                mbid == 4 ? wb0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? wb7 :
                mbid == 14 ? wb6 : wb5;

    assign wval5 = mbid == 0 ? wb5 :
                mbid == 1 ? wb4 :
                mbid == 2 ? wb3 :
                mbid == 3 ? wb2 :
                mbid == 4 ? wb1 :
                mbid == 5 ? wb0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? wb7 : wb6;

    assign wval6 = mbid == 0 ? wb6 :
                mbid == 1 ? wb5 :
                mbid == 2 ? wb4 :
                mbid == 3 ? wb3 :
                mbid == 4 ? wb2 :
                mbid == 5 ? wb1 :
                mbid == 6 ? wb0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : wb7;

    assign wval7 = mbid == 0 ? wb7 :
                mbid == 1 ? wb6 :
                mbid == 2 ? wb5 :
                mbid == 3 ? wb4 :
                mbid == 4 ? wb3 :
                mbid == 5 ? wb2 :
                mbid == 6 ? wb1 :
                mbid == 7 ? wb0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;
        
        assign wval8 = mbid == 0 ? 0 :
                mbid == 1 ? wb7 :
                mbid == 2 ? wb6 :
                mbid == 3 ? wb5 :
                mbid == 4 ? wb4 :
                mbid == 5 ? wb3 :
                mbid == 6 ? wb2 :
                mbid == 7 ? wb1 :
                mbid == 8 ? wb0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;

        assign wval9 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? wb7 :
                mbid == 3 ? wb6 :
                mbid == 4 ? wb5 :
                mbid == 5 ? wb4 :
                mbid == 6 ? wb3 :
                mbid == 7 ? wb2 :
                mbid == 8 ? wb1 :
                mbid == 9 ? wb0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;

        assign wval10 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? wb7 :
                mbid == 4 ? wb6 :
                mbid == 5 ? wb5 :
                mbid == 6 ? wb4 :
                mbid == 7 ? wb3 :
                mbid == 8 ? wb2 :
                mbid == 9 ? wb1 :
                mbid == 10 ? wb0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;

        assign wval11 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? wb7 :
                mbid == 5 ? wb6 :
                mbid == 6 ? wb5 :
                mbid == 7 ? wb4 :
                mbid == 8 ? wb3 :
                mbid == 9 ? wb2 :
                mbid == 10 ? wb1 :
                mbid == 11 ? wb0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;

        assign wval12 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? wb7 :
                mbid == 6 ? wb6 :
                mbid == 7 ? wb5 :
                mbid == 8 ? wb4 :
                mbid == 9 ? wb3 :
                mbid == 10 ? wb2 :
                mbid == 11 ? wb1 :
                mbid == 12 ? wb0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 : 0;

        assign wval13 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? wb7 :
                mbid == 7 ? wb6 :
                mbid == 8 ? wb5 :
                mbid == 9 ? wb4 :
                mbid == 10 ? wb3 :
                mbid == 11 ? wb2 :
                mbid == 12 ? wb1 :
                mbid == 13 ? wb0 :
                mbid == 14 ? 0 : 0;

        assign wval14 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? wb7 :
                mbid == 8 ? wb6 :
                mbid == 9 ? wb5 :
                mbid == 10 ? wb4 :
                mbid == 11 ? wb3 :
                mbid == 12 ? wb2 :
                mbid == 13 ? wb1 :
                mbid == 14 ? wb0 : 0;

        assign wval15 = mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? wb7 :
                mbid == 9 ? wb6 :
                mbid == 10 ? wb5 :
                mbid == 11 ? wb4 :
                mbid == 12 ? wb3 :
                mbid == 13 ? wb2 :
                mbid == 14 ? wb1 : wb0;

        assign wenable0 = (!mok | !wenable) ? 0 :          // Window is 9,10,11,12,13,14,15,0
                mbid == 0 ? 1 :    
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 : 
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable1 = (!mok | !wenable) ? 0 :          // Window is 10,11,12,13,14,15,0,1
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable2 = (!mok | !wenable) ? 0 :          // Window is 11,12,13,14,15,0,1,2
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable3 = (!mok | !wenable) ? 0 :          // Window is 12,13,14,15,0,1,2,3
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable4 = (!mok | !wenable) ? 0 :          // Window is 13,14,15,0,1,2,3,4
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable5 = (!mok | !wenable) ? 0 :          // Window is 14,15,0,1,2,3,4,5
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

        assign wenable6 = (!mok | !wenable) ? 0 :          // Window is 15,0,1,2,3,4,5,6
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 0 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 1 : 0;

        assign wenable7 = (!mok | !wenable) ? 0 :          // Window is 0,1,2,3,4,5,6,7
                mbid == 0 ? 1 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 0 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable8 = (!mok | !wenable) ? 0 :          // Window is 1,2,3,4,5,6,7,8
                mbid == 0 ? 0 :
                mbid == 1 ? 1 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 0 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable9 = (!mok | !wenable) ? 0 :          // Window is 2,3,4,5,6,7,8,9
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 1 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 0 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable10 = (!mok | !wenable)? 0 :         // Window is 3,4,5,6,7,8,9,10
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 1 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 0 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable11 = (!mok | !wenable) ? 0 :         // Window is 4,5,6,7,8,9,10,11
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 1 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 0 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable12 = (!mok | !wenable) ? 0 :         // Window is 5,6,7,8,9,10,11,12
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 1 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 0 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable13 = (!mok | !wenable) ? 0 :         // Window is 6,7,8,9,10,11,12,13
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 1 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 0 :
                mbid == 15 ? 0 : 0;

        assign wenable14 = (!mok | !wenable) ? 0 :         // Window is 7,8,9,10,11,12,13,14
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 1 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 0 : 0;

        assign wenable15 = (!mok | !wenable) ? 0 :         // Window is 8,9,10,11,12,13,14,15
                mbid == 0 ? 0 :
                mbid == 1 ? 0 :
                mbid == 2 ? 0 :
                mbid == 3 ? 0 :
                mbid == 4 ? 0 :
                mbid == 5 ? 0 :
                mbid == 6 ? 0 :
                mbid == 7 ? 0 :
                mbid == 8 ? 1 :
                mbid == 9 ? 1 :
                mbid == 10 ? 1 :
                mbid == 11 ? 1 :
                mbid == 12 ? 1 :
                mbid == 13 ? 1 :
                mbid == 14 ? 1 :
                mbid == 15 ? 1 : 0;

endmodule




//dual ported random access memory where we will use A as the instr port.
//CS:APP says this works for simulation but real hardware does not normally
// allow combinatorial reads.
module bank (clk, addrA, addrB, wenableA, wenableB, wvalA, wvalB, valA, valB);
    parameter word_size = 8; //1 byte
    parameter word_count = 512;
    parameter address_size = 9; //log2 word count

    input clk;
    input wenableA, wenableB;
    input [address_size - 1:0] addrA, addrB;
    input [word_size -1:0] wvalA, wvalB;

    output [word_size - 1:0] valA, valB;

    reg [word_size - 1: 0] mem [word_count - 1: 0];
    assign valA = mem[addrA]; //mux over 8bit regs
    assign valB = mem[addrB];


    always @(posedge clk) begin
        if (wenableA)
            mem[addrA] <= wvalA;
        if (wenableB)
            mem[addrB] <= wvalB;
    end
endmodule



module clked_register (clk, write_enable, update_val, output_val, reset, reset_val);
    parameter reg_size = 64;

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



module splitter (instr, icode, ifunc);
    input wire [79:0] instr;
    output wire [3:0] icode, ifunc;

    assign icode = instr[79: 76]; //icode is the most sig bits of the instr
    assign ifunc = instr[75: 72];
endmodule

module align (instr, regA, regB, valC);
    input [79:0] instr;
    output [3:0] regA;
    output [3:0] regB;
    output [63:0] valC;

    assign regA = instr[71:68];
    assign regB = instr[67:64];
    assign valC = instr[63:0];
endmodule

module new_PC_module (PC, new_PC);
    input [63:0] PC;
    output [63:0] new_PC;            
    assign new_PC = PC +10;

endmodule

module reg_file (clk, srcA, srcB, valA, valB, destA, destB, dest_val_A, dest_val_B); //can out reg for debug if we want
    
    
    input [3:0] srcA, srcB, destA, destB;
    input [63:0] dest_val_A, dest_val_B;
    input clk;
    
    input reset;
    output [63:0]  valA, valB;

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
    clked_register reg0(clk, write_enable0, update_val0, out0, reset, 0);
    clked_register reg1(clk, write_enable1, update_val1, out1, reset, 0);
    clked_register reg2(clk, write_enable2, update_val2, out2, reset, 0);
    clked_register reg3(clk, write_enable3, update_val3, out3, reset, 0);
    clked_register reg4(clk, write_enable4, update_val4, out4, reset, 0);
    clked_register reg5(clk, write_enable5, update_val5, out5, reset, 0);
    clked_register reg6(clk, write_enable6, update_val6, out6, reset, 0);
    clked_register reg7(clk, write_enable7, update_val7, out7, reset, 0);
    clked_register reg8(clk, write_enable8, update_val8, out8, reset, 0);
    clked_register reg9(clk, write_enable9, update_val9, out9, reset, 0);
    clked_register reg10(clk, write_enable10, update_val10, out10, reset, 0);
    clked_register reg11(clk, write_enable11, update_val11, out11, reset, 0);
    clked_register reg12(clk, write_enable12, update_val12, out12, reset, 0);
    clked_register reg13(clk, write_enable13, update_val13, out13, reset, 0);
    clked_register reg14(clk, write_enable14, update_val14, out14, reset, 0);
    clked_register reg15(clk, write_enable15, update_val15, out15, reset, 0);


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


module alu (valA, valB, valC, aluFUNC, CCodes, outVal);
    input [63:0] valA;
    input [63:0] valB;
    input [63:0] valC;
    input [3:0] aluFUNC;
    output [3:0] CCodes;
    output [63:0] outVal;

    parameter ADD = 4'h0;
    parameter AND = 4'h1;
    parameter XOR = 4'h2;
    
    parameter SUB = 4'h3;
    parameter ADD_C = 4'h4;
    parameter PASS_C = 4'h5;

    assign outVal = aluFUNC == ADD ? valA + valB : 
                    aluFUNC == XOR ? valA ^ valB : //think this is XOR
                    aluFUNC == AND ? valA & valB : 
                    aluFUNC == SUB ? valA - valB :
                    aluFUNC == ADD_C ? valB + valC : valC;

    //set CCodes
    //only need 3 bits but not going to change num
    // codes are is_zero, is negative, overflow occured 

    assign CCodes[2] = outVal == 0;
    assign CCodes[1] = outVal[63];
    assign CCodes[0] = aluFUNC == ADD ? ((valA[63] == valB[63]) & (valA[63] != outVal[63])) :
                        aluFUNC == SUB ? ((~valA[63] == valB[63]) & (~valA[63] != outVal[63])) : 0;
    

endmodule

module ConditionCodes (clk, CCodes, reset, currentCodes);
   input [2:0] CCodes;
   input clk, reset;
   output [2:0] currentCodes;

   reg [2:0] codes;

   always @(posedge clk) begin
        if (reset == 1)
                codes <= 0;
        else
                codes <= CCodes;
   end 
   assign currentCodes = codes;
endmodule

    



module processor (clk, mode, download_val, upload_val, download_address, upload_address, status);
    parameter RUN_MODE = 0;
    parameter DOWNLOAD_MODE = 1; //downloads a word to a mem address
    parameter UPLOAD_MODE = 2; //returns a word from a mem address
    parameter RESET_MODE = 3; //sets CC, regs, PC = 0, sends RESET status.
    parameter STATUS_MODE = 4;

    // status parameters 
    parameter RESET = 0;


    //instruction codes for CS:APP x86 subset
    //all commands are 10 words
    parameter IHALT = 4'h0;
    parameter INOP = 4'h1; //nothing
    parameter IRRMOVQ = 4'h2; // reg to reg move (regA = regB)
    parameter IIRMOVQ = 4'h3; // imediate to reg move (regA = C)
    parameter IRMMOVQ = 4'h4; // reg to mem move (regA to mem( regB) + C)
    parameter IMRMOVQ = 4'h5; // mem to reg move (regA = mem(reg(B) + C))
    parameter IOPQ = 4'h6; // regA <= regA op regB
    parameter IJXX = 4'h7;// if CC = X PC <= regB +C
  

    input clk;
    input [2:0] mode;
    input [63:0] download_val;
    input [63:0] download_address;
    input [63:0] upload_address;
    output [63:0] upload_val;
    output [3:0] status;

    //mode  flags
    wire reset;
    wire download, upload, run, is_status_mode;
    assign reset = (mode == RESET_MODE);
    assign download = (mode == DOWNLOAD_MODE);
    assign upload = (mode ==  UPLOAD_MODE);
    assign run = (mode == RUN_MODE);
    assign is_status_mode = (mode == STATUS_MODE);

    assign status = mode == RESET_MODE ? RESET : 0 ;//temp


    wire clock;
    assign clock = clk;

    

    reg [63:0] PC;
    wire [63:0] new_PC;
    wire [79:0] instr;
    wire [3:0] icode;
    wire [3:0] ifunc;

    wire [3:0] regA;
    wire [3:0] regB;
    wire [63:0] valC;

    wire [63:0] valA, valB;
    wire [3:0] destA, destB;
    wire [63:0] dest_val_A, dest_val_B;

    wire [3:0] aluFUNC;
    wire [2:0] CCodes;

    wire [63:0] ALUOut;
    wire [2:0] currentCodes;

    //mem wires
    wire [63: 0] memaddr;
    wire wenable, renable;
    wire [63: 0] wvalue, rvalue;




    //instruction on wire, now we need to extract pieces of it
    splitter split (instr, icode, ifunc);
    align aligner (instr, regA, regB, valC);

    reg_file regs (clk, regA, regB, valA, valB, destA, destB, dest_val_A, dest_val_B);

    alu ALU (valA, valB, valC, aluFUNC, CCodes, ALUOut);
    ConditionCodes codes (clk, CCodes, reset, currentCodes);

    assign dest_val_A = ALUOut;
    assign dest_val_B = rvalue;

    banked_memory mem (clk, PC, memaddr, mok, iok, instr, wenable, renable, wvalue, rvalue); 
    //ALUOUT is memaddr, if read and write are 0, then does nothing.
    //destA is sometimes regA of doing op instructions.
    //dest b is sometimes reg


    
   // MUST BE SET FLAGS: ALUFUNC 

   //MODE DOWNLOAD/ UPLOAD override
   assign memaddr = (mode == DOWNLOAD_MODE) ? download_address :
                        (mode == UPLOAD_MODE) ? upload_address : ALUOut;
   assign wenable = (mode == DOWNLOAD_MODE) ? 1 :
                 (mode == RUN_MODE && icode == IRMMOVQ) ? 1 : 0;

   assign renable = (mode == UPLOAD_MODE) ? 1 : 
                        (mode == RUN_MODE && icode == IMRMOVQ) ? 1 : 0;

   assign wvalue = (mode == DOWNLOAD_MODE) ? download_val :
                (mode == RUN_MODE && icode == IRMMOVQ) ? valA: 0;

   assign upload_val = (mode == UPLOAD_MODE) ? rvalue : 0 ;//temp 0s

   

   assign destA = (icode == IRRMOVQ | icode == IIRMOVQ | icode == IOPQ) ? regA : 15;
   assign destB = (icode == IMRMOVQ) ? regA : 15;
   assign aluFUNC = (icode == IRRMOVQ  | icode == IMRMOVQ | icode == IRMMOVQ) ? 4'h4  : //ADD_C
                        icode == IIRMOVQ ? 4'h5 : //PASS_C
                        icode == IOPQ ? ifunc : 0; //not sure what this should be during jmp
   



//     assign needs_regs = (icode == IIADDQ || icode == IMRMOVQ || icode == IRMMOVQ || icode == IRRMOVQ || icode == IIRMOVQ);
//     assign needs_valC = ( icode ==  IRMMOVQ || icode == IMRMOVQ || icode == IIRMOVQ || icode == ICALL || icode == jmp);
    // if (icode == IIADDQ || icode == IMRMOVQ || icode == IRMMOVQ || icode == IRRMOVQ || icode == IIRMOVQ) begin  //might be wrong
    //     assign needs_regs = 1;
    //     else
    //         assign  needs_regs = 0;
    // end 

    







        always @(posedge clk) begin
        if (mode == RESET_MODE)
        PC <= 0;
        else if (icode == IJXX) begin
        if (ifunc == 0 && !currentCodes[2] || ifunc == 1)
                PC <= valC;
        else 
                PC <= PC + 10;
        end
        else
        PC <= PC + 10;
        end

endmodule

module control ();
  // make a clk here and set up halting when the halt instruction is hit

    parameter RUN_MODE = 0;
    parameter DOWNLOAD_MODE = 1; //downloads a word to a mem address
    parameter UPLOAD_MODE = 2; //returns a word from a mem address
    parameter RESET_MODE = 3; //sets CC, regs, PC = 0, sends RESET status.
    parameter STATUS_MODE = 4;


  reg clk;
  reg [2:0] mode;
  reg [63:0] download_val;
  reg [63:0] download_address;
  wire [63:0] upload_val;
  reg [63:0] upload_address;
  wire [3:0] status;

  processor dut (clk, mode, download_val, upload_val, download_address, upload_address, status);

 //TEST MODES
//   initial begin 
//         clk = 0;
//         $display("Simulation starting at time %0t", $time);
//         download_val <= 1;
//         download_address <= 0;
//         mode <= 1; //set mode to download'
//         #5
//         $display("mode is %d", mode);
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         download_address <= 8;
//         download_val <= 2;
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         download_address <= 16;
//         download_val <= 3;
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         $display( "loaded download val: %h to address %h", download_val, download_address);
//         upload_address <= 0;
//         mode <= 2; //set to upload
//         #5
//         $display("mode is %d", mode);
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         $display("upload value = %h from address: %h", upload_val, upload_address);
//         upload_address <= 8;
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         $display("upload value = %h from address: %h", upload_val, upload_address);
//         upload_address <= 16;
//         #5 
//         clk = ~clk;
//         #5
//         clk = ~clk;
//         $display("upload value = %h from address: %h", upload_val, upload_address);
//   $finish;
//   end

// initial begin
//         clk = 0 
//         $display("testing load imidiate");
//         #5
//         mode <= DOWNLOAD_MODE;
//         download_address <= 0;
//         download_val < = IIRMOVQ + REG0 + REG0 + //extend to 64 bits;
//         #5
//         clk = !clk
//         #5
//         clk = !=clk
//         download_address <= 8
//         download_val = 16'b0000000000000001 //extend to 64 bits
//         #5
//         clk = !clk 
//         #5
//         clk = !clk
//         $display("IIRMOVEQ REG0 REG0 +C, C=1 in first 10 bits of mem");
//         mode <= RESET_MODE; //set PC to zero
//         #5
//         clk = !clk 
//         #5
//         clk = !clk
//         $display("exiting Reset mode, PC should be 0");
//         mode <= RUN_MODE;
//         #5
//         clk = !clk 
//         #5
//         clk = !clk
//         $finish
//end 

//WORKING INSTRUCTIONS : IIRMOVE, IRRMOVE, IRMMOVE, IMRMOVE
initial begin
        $monitor(
                "dest_val_A = %h, destA = %h,\n\
                dest_val_B = %h, destB = %h, \n\
                instr = %h, aluFUNC = %h, PC = %h\n\
                alu_valA = %h, alu_valB = %h, \n\ alu_valC = %h, alu_outVal = %h, \n\
                wenable0 = %h, wenable1 = %h \n\
                reg0 = %h, reg1 = %h, reg2 = %h, reg13 = %h, reg14 = %h, reg15 = %h",
                
                dut.dest_val_A,           // In processor
                dut.destA,                // In processor
                dut.dest_val_A,
                dut.destB,

                dut.instr,                // In processor
                dut.aluFUNC,             // In processor
                dut.PC,                   // In processor

                dut.ALU.valA,
                dut.ALU.valB,
                dut.ALU.valC,
        
                dut.ALUOut,

                dut.regs.write_enable0,
                dut.regs.write_enable1,

                dut.regs.out0,
                dut.regs.out1,
                dut.regs.out2,
                dut.regs.out13,
                dut.regs.out14,
                dut.regs.out15,
                

                );
    // Initialize clock and parameters
    clk = 0;
    $display("Testing load immediate (IIRMOVQ)");
    
    // We need to download the instruction in multiple parts since download_val is 64 bits
    // First download: First 8 bytes of instruction
    // IIRMOVQ = 3, REG0 = 0
    mode = DOWNLOAD_MODE;
    download_address = 0;
    // First 8 bytes: icode(3) | ifunc(0) | regA(0) | regB(0) | 
    download_val = 64'h3010_0000_0000_0000; //IIRMOVE WORKS! MOVE VAL TO REG 1
    
    // Clock cycle to process first download
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    // Second download: Last byte containing end of immediate value
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 2;
    download_val = 64'h0000_0000_0000_0345;
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    download_address = 10;
    download_val = 64'h30e0_0000_0000_0000; //MOVE 0 to REG 14
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 12;
    download_val = 64'h0000_0000_0000_0000;


    //IRRMOVE TEST : move reg1 to reg 0
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 20;
    download_val = 64'h2001_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 22;
    download_val = 64'h0000_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;

    //IRMMOVE TEST : move reg0 to mem 100
    
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 30;
    download_val = 64'h400E_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 32;
    download_val = 64'h0000_0000_0000_0064;
    #5 clk = ~clk;
    #5 clk = ~clk;

    //IMRMOVE TEST : move 100 to reg2

    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 40;
    download_val = 64'h502E_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 42;
    download_val = 64'h0000_0000_0000_0064;
    #5 clk = ~clk;
    #5 clk = ~clk;

    // IADDQ : reg2 ADD reg0
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 50;
    download_val = 64'h6020_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 52;
    download_val = 64'h0000_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;

    //IANDQ : reg2 AND reg14
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 60;
    download_val = 64'h612E_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 62;
    download_val = 64'h0000_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;

    //IXORQ : reg2 xor reg0
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 70;
    download_val = 64'h6220_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 72;
    download_val = 64'h0000_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    // jmp to 0
    download_address = 80;
    download_val = 64'h7100_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;
    download_address = 82;
    download_val = 64'h0000_0000_0000_0000;
    #5 clk = ~clk;
    #5 clk = ~clk;


    
    // Clock cycle to process second download
    #5 clk = ~clk;
    #5 clk = ~clk;
    
    $display("Downloaded IIRMOVQ instruction to memory");
    
    // Reset processor to start execution
    mode = RESET_MODE;
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Reset complete, PC = 0");
    
    // Run the instruction
    mode = RUN_MODE;
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IIRMOVQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IIRMOVQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IRRMOVQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IRMMOVQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IMRMOVQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IADDQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IANDQ instruction");
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("Executed IXORQ instruction");
    mode = UPLOAD_MODE;
    upload_address = 100;
    #5 clk = ~clk;
    #5 clk = ~clk;
    $display("upload_val = %h", upload_val);
    
    $finish;
end




endmodule