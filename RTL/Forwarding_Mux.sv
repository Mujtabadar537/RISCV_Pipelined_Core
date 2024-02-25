module Forwarding_Mux(

input [31:0]in1,
input [31:0]in2,
input [31:0]in3,

input [1:0]sel,

output [31:0]out


);


assign out = (sel == 2'b10) ? in2:
	     (sel == 2'b01) ? in3:
	     in1;


endmodule
