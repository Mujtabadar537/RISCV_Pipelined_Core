module MEMORY_ACCESS_STAGE(


input clk_i,
input reset_i,

input MemtoReg_MEMORYACCESS,
input MemWrite_MEMORYACCESS,
input MemRead_MEMORYACCESS,
input RegWrite_MEMORYACCESS,
input Branch_MEMORYACCESS,

input [4:0]Write_Register_MEMORYACCESS,
input [31:0]Address_MEMORYACCESS,
input [31:0]WriteData_DataMemory_MEMORYACCESS,
input zero_MEMORYACCESS,



output PCSrc,
output RegWrite_WRITEBACK,
output MemtoReg_WRITEBACK,
output [31:0]ReadData_WRITEBACK,
output [31:0]Address_WRITEBACK


);






//Interim wires
/* verilator lint_off UNDRIVEN */
wire [31:0]Address_wire;
/* verilator lint_on UNDRIVEN */
wire [31:0]ReadData_wire;


 



//--------------------------------------------

AND_Gate and_gate(

.in1_i(Branch_MEMORYACCESS),
.in2_i(zero_MEMORYACCESS),

.out_o(PCSrc)


);



//--------------------------------------------


Data_Memory data_memory(


.clk_i(clk_i),
.reset_i(reset_i),
.MemWrite_i(MemWrite_MEMORYACCESS),
.MemRead_i(MemRead_MEMORYACCESS),
.Address_i(Address_wire),
.Write_data_i(WriteData_DataMemory_MEMORYACCESS),


.Read_data_o(ReadData_wire)


);




//Memory Access Register Logic

logic RegWrite_reg;
logic MemtoReg_reg;
logic [31:0]ReadData_reg;
logic [31:0]Address_reg;

always_ff @(posedge clk_i) begin


if(reset_i) begin
	RegWrite_reg <= 1'b0;
	MemtoReg_reg <= 1'b0;
	ReadData_reg <= 32'h00000000;
	Address_reg <= 32'h000000000;
end


else begin
	RegWrite_reg <= RegWrite_MEMORYACCESS;
	MemtoReg_reg <= MemtoReg_MEMORYACCESS;
	ReadData_reg <= ReadData_wire;
	Address_reg <= Address_wire;
end



end


assign RegWrite_WRITEBACK = RegWrite_reg;
assign MemtoReg_WRITEBACK = MemtoReg_reg;
assign ReadData_WRITEBACK = ReadData_reg;
assign Address_WRITEBACK = Address_reg;



wire _unused_ok = &{1'b0,
                    Write_Register_MEMORYACCESS,
                    Address_MEMORYACCESS,
                    Address_wire,
                    1'b0};



endmodule




