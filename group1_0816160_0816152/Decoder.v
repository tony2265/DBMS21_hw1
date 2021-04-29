/***************************************************
Student Name: 翁堉豪、林栢瑋
Student ID: group1_0816160_0816152 
***************************************************/

   `timescale 1ns/1ps

   module Decoder(
       input   [7-1:0]     instr_i,
       output              RegWrite,
       output              Branch,
       output              Jump,
       output              WriteBack1,
       output              WriteBack0,
       output              MemRead,
       output              MemWrite,
       output              ALUSrcA,
       output              ALUSrcB,
       output  [2-1:0]     ALUOp
   );

   /* Write your code HERE */
   assign RegWrite      = (instr_i[5:0] == 6'b100011)   ? 0 : 1;
   assign Branch        = (instr_i[6:4] == 3'b110)      ? 1 : 0;
   assign Jump          = (instr_i[2:1] == 2'b11)       ? 1 : 0;
   assign WriteBack1    = (instr_i[2:1] == 2'b11)       ? 1 : 0;
   assign WriteBack0    = (instr_i[6:4] == 3'b000)      ? 1 : 0;
   assign MemRead       = (instr_i[6:4] == 3'b000)      ? 1 : 0;
   assign MemWrite      = (instr_i[6:4] == 3'b010)      ? 1 : 0;
   assign ALUSrcA       = (instr_i[3:0] == 4'b0111)     ? 1 : 0;
   assign ALUSrcB       = (instr_i[6:4] == 3'b110 || instr_i[6:4] == 3'b011) ? 0 : 1;
   assign ALUOp[1]      = instr_i[4];
   assign ALUOp[0]      = (instr_i == 7'b0010011 ||instr_i == 7'b1100011) ? 1 : 0;

   endmodule