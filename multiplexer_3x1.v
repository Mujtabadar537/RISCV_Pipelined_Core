module multiplexer_3x1(

input [31:0]in1,in2,in3,
input [1:0]sel,

output [31:0]out

);


assign out = (sel == 2'b00) ? in1 : (sel == 2'b01) ? in2 : in3;


endmodule
