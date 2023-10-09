`include "multiplexer_3x1.v"

module WB_stage(

input [31:0]ALUResultW,
input [31:0]ReadDataW,
input [31:0]PCPlus4W,
input [1:0]ResultSrcW,

output [31:0]ResultW


);



multiplexer_3x1 WB_MUX(

.in1(ALUResultW),.in2(ReadDataW),.in3(PCPlus4W),
.sel(ResultSrcW),

.out(ResultW)


);










endmodule
