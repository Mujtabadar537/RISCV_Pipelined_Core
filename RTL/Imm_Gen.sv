module Imm_Gen(

input [31:0]instruction_i,

output [31:0]Immediate_o

);


                    //I-type immediate
assign Immediate_o = (instruction_i[6:0] == 7'b0010011 | instruction_i[6:0] == 7'b0000011) ? {{20{instruction_i[31]}},instruction_i[31:20]} :
		   //S-type and B-type immediate
		   (instruction_i[6:0] == 7'b0100011 | instruction_i[6:0] == 7'b1100011) ? {{20{instruction_i[31]}},instruction_i[31:25],instruction_i[11:7]} : 32'h00000000;
		   
wire _unused_ok = &{1'b0,
                    instruction_i[19:12],
                    1'b0};

endmodule
