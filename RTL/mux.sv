module mux(

/* verilator lint_off MODDUP */

input [31:0]in1_i,in2_i,
input sel_i,

output  [31:0]out_o

);


assign out_o = (sel_i == 1'b0) ? in1_i : in2_i;

/* verilator lint_on MODDUP */

endmodule
