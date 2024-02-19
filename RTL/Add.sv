module Add(

/* verilator lint_off MODDUP */

input [31:0]in1_i,in2_i,

output logic [31:0]sum_o

);


assign sum_o = in1_i + in2_i;

/* verilator lint_on MODDUP */

endmodule
