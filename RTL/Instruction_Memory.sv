module Instruction_Memory(


input reset_i, 
input[31:0]Read_Address_i,

output [31:0]instruction_o

);


logic [31:0] memory [1023:0];


/* verilator lint_off WIDTH */
assign instruction_o = (reset_i == 1'b1) ? 32'h00000000 : memory[Read_Address_i[31:2]];
/* verilator lint_on WIDTH */


initial begin
//$readmemh("instructions.hex",memory);
memory[0] = 32'h00500093;
memory[1] = 32'h00400113;
memory[2] = 32'h00112223;
memory[3] = 32'h00412183;
end


wire _unused_ok = &{1'b0,
                    Read_Address_i[1:0],
                    1'b0};

endmodule
