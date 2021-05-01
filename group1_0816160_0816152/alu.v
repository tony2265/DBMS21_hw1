/***************************************************
Student Name: 翁堉豪、林栢瑋
Student ID: group1_0816160_0816152 
***************************************************/
   `timescale 1ns/1ps

   module alu(
       input                   rst_n,         // negative reset            (input)
       input signed [32-1:0]   src1,          // 32 bits source 1          (input)
       input signed [32-1:0]   src2,          // 32 bits source 2          (input)
       input        [ 4-1:0]   ALU_control,   // 4 bits ALU control input  (input)
       input        [ 6-1:0]   shamt,
       output reg   [32-1:0]   result,        // 32 bits result            (output)
       output reg              Zero          // 1 bit when the output is 0, zero must be set (output)
   );

   /* Write your code HERE */

    reg signed [31:0] a, b;


    always @(*) begin
        case (rst_n)
            1'b1 : begin
                a <= src1;
                b <= src2;
            end
            1'b0 : begin
                a <= 0;
                b <= 0;
            end
            default : ;
        endcase

        // z
        Zero <= |result ? 0 : 1;

        // result
        case (ALU_control)
            4'b0000 : //and
                result <= a & b;
            4'b0001 : //or
                result <= a | b;
            4'b0010 : //add
                result <= a + b;
            4'b0110 : //sub
                result <= a - b;
            4'b0111 : //slt
                result <= (a < b) ? 32'b1 : 32'b0;
            4'b1100 : //nor
                result <= ~(a | b);
            4'b1101 : //nand
                result <= ~(a & b);
            4'b1000 : //xor
                result <= a ^ b;
            4'b0100 : //sll
                result <= a << b;
            4'b0101 : //sra
                result <= a >>> b;
            4'b1001 : //blt
                result <= ~(a < b);
            4'b0011 : //bge
                result <= ~(a >= b);
            4'b1011 : //slli
                result <= a << shamt;
            default: ;
        endcase
    end


   endmodule
