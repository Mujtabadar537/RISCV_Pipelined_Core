module Data_Memory(


//inputs
input clk_i,
input MemWrite_i,
input MemRead_i,
/* verilator lint_off UNUSED */
input [31:0]Address_i,
/* verilator lint_on UNUSED */
input [31:0]Write_data_i,


//outputs
output [31:0]Read_data_o

);


logic [31:0] memory [1023:0];


//write operation
always_ff @(posedge clk_i) begin

if(MemWrite_i == 1'b1) begin
memory[Address_i] <= Write_data_i;
end

end


//read operation
assign Read_data_o = (MemRead_i == 1'b1) ? memory[Address_i] : 32'h00000000 ;



endmodule
