/* verilator lint_off MODDUP */
`include "mux.sv"
`include "Program_Counter.sv"
`include "Instruction_Memory.sv"
`include "Add.sv"
/* verilator lint_on MODDUP */


module FETCH_STAGE(

input clk_i,
input reset_i,

input PCSrc,
input [31:0]PCTarget_MEMORYACCESS,


output [31:0]pc_DECODE,
output [31:0]instruction_DECODE


);


//interim wires
wire [31:0]pcnext_wire;
wire [31:0]pcout_wire;
wire [31:0]add4out_wire;
wire [31:0]instruction_FETCH_wire;





mux fetch_mux(

.in1_i(add4out_wire),
.in2_i(PCTarget_MEMORYACCESS),
.sel_i(PCSrc),

.out_o(pcnext_wire)

);




Program_Counter PC(

.clk_i(clk_i),
.reset_i(reset_i),
.pcnext_i(pcnext_wire),

.pc_o(pcout_wire)

);




Instruction_Memory instruction_memory(

.reset_i(reset_i), 
.Read_Address_i(pcout_wire),

.instruction_o(instruction_FETCH_wire)


); 




Add Add4(

.in1_i(pcout_wire),
.in2_i(32'h4),

.sum_o(add4out_wire)


);





//Fetch Register Logic


logic [31:0]pc_reg;
logic [31:0]instruction_reg;




always_ff @(posedge clk_i) begin

if(reset_i) begin
	pc_reg <= 32'h00000000;
	instruction_reg <= 32'h00000000;
end


else begin
	pc_reg <= pcout_wire;
	instruction_reg <= instruction_FETCH_wire;
end


end



assign pc_DECODE = pc_reg;
assign instruction_DECODE = instruction_reg;





endmodule
































