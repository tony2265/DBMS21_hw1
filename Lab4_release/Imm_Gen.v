/***************************************************
Student Name:
Student ID: Lab4_release
***************************************************/

   `timescale 1ns/1ps

   module Imm_Gen(
       input  [31:0] instr_i,
       output reg[31:0] Imm_Gen_o
   );

   //Internal Signals
   wire    [7-1:0] opcode;
   wire    [2:0]   func3;
   reg     [31:0] Instr_field;

//    wire    [3-1:0] Instr_field;
   assign opcode = instr_i[6:0];
   assign func3  = instr_i[14:12];
   assign Imm_Gen_o = Instr_field;
   /* Write your code HERE */

    always @(*) begin
        case (opcode)
            7'0010011 : begin //addi
                Instr_field <= {21{instr_i[31]},instr_i[30:25],instr_i[24:21],instr_i[20]};
            end
            7'0000011 : begin //load
                Instr_field <= {21{instr_i[31]},instr_i[30:25],instr_i[24:21],instr_i[20]};
            end
            7'1100111 : begin //jalr
                Instr_field <= {21{instr_i[31]},instr_i[30:25],instr_i[24:21],instr_i[20]};
            end
            7'0100011 : begin //store
                Instr_field <= {21{instr_i[31]},instr_i[30:25],instr_i[11:8],instr_i[7]};
            end
            7'1100011 : begin //branch
                Instr_field <= {20{instr_i[31]},instr_i[7],instr_i[30:25],instr_i[11:8],1'b0};
            end
            7'1101111 : begin //jal
                Instr_field <= {12{instr_i[31]},instr_i[19:12],instr_i[20],instr_i[30:25],instr_i[24:21],1'b0};
            end

            default: ;
        endcase
    end

   endmodule
