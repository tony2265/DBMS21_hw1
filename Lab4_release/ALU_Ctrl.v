/***************************************************
Student Name:
Student ID: Lab4_release
***************************************************/

   `timescale 1ns/1ps
   /*instr[30,14:12]*/
   module ALU_Ctrl(
       input       [4-1:0] instr,
       input       [2-1:0] ALUOp,
       output reg  [4-1:0] ALU_Ctrl_o
   );

   /* Write your code HERE */

    always @(*) begin
        case (ALUOp)
            2'b00: begin //ld, sd
                ALU_Ctrl_o <= 4'b0010;
            end
            2'b01 : begin //beq
                ALU_Ctrl_o <= 4'b0110;
            end
            2'b10: //R type
            begin
                case (instr)
                    4'b0000://add
                        ALU_Ctrl_o <= 4'b0010;
                    4'b1000: //sub
                        ALU_Ctrl_o <= 4'b0110;
                    4'b0111: //and
                        ALU_Ctrl_o <= 4'b0000;
                    4'b0110: //or
                        ALU_Ctrl_o <= 4'b0001;
                    4'b0100: //xor
                        ALU_Ctrl_o <= 4'b1000;
                    4'b0001: //sll
                        ALU_Ctrl_o <= 4'b0100;
                    4'b1101: //sra
                        ALU_Ctrl_o <= 4'b0101;
                    4'b0010: //slt
                        ALU_Ctrl_o <= 4'b0111;
                    default: ;
                endcase
            end

            default: ;
        endcase
    end


   endmodule

