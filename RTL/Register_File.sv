
module Register_File(

input clk_i,
input reset_i,
input [4:0]Read_Register1_i,
input [4:0]Read_Register2_i,
input [4:0]Write_Register_i,
input [31:0]Write_data_i,
input RegWrite_i,


output  [31:0]Read_data1_o,
output  [31:0]Read_data2_o

);


logic [31:0] register [31:0];


//write operation
always_ff @(posedge clk_i) begin

if(RegWrite_i) begin
register[Write_Register_i] <= Write_data_i;
end

end




//Read operation
assign Read_data1_o = (reset_i) ? 32'h00000000 : register[Read_Register1_i];
assign Read_data2_o = (reset_i) ? 32'h00000000 : register[Read_Register2_i];



/* verilator lint_on MULTIDRIVEN */



endmodule
