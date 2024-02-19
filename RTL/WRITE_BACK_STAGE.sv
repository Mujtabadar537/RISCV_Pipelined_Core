module WRITE_BACK_STAGE(

input MemtoReg_WRITEBACK,
input [31:0]ReadData_WRITEBACK,
input [31:0]Address_WRITEBACK,

/* verilator lint_off UNDRIVEN */
output RegWrite,
/* verilator lint_on UNDRIVEN */
output [31:0]WriteData

);



mux write_back_mux(

.in1_i(Address_WRITEBACK),
.in2_i(ReadData_WRITEBACK),
.sel_i(MemtoReg_WRITEBACK),

.out_o(WriteData)

);

wire _unused_ok = &{1'b0,
                    RegWrite,
                    1'b0};



endmodule
