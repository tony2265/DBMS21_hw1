/***************************************************
Student Name: 翁堉豪
Student ID: 0816160
***************************************************/

`timescale 1ns/1ps

module Adder(
    input  [32-1:0] src1_i,
	input  [32-1:0] src2_i,
	output [32-1:0] sum_o
	);
    
/* Write your code HERE */
reg [32-1:0] ans;

assign sum_o = ans;

always @(*) begin
	ans <= src1_i + src2_i;
end
 

endmodule