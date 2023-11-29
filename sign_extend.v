module sign_extend(

input [1:0]ImmSrc,
input [31:0]In,

output [31:0]ImmExt


);


assign ImmExt = (ImmSrc == 2'b01) ? ({{20{In[31]}},In[31:25],In[11:7]}) : {{20{In[31]}},In[31:20]};




wire _unused_ok = &{1'b0,
                    In[6:0],
                    In[19:12], // To be fixed
                    1'b0};


endmodule
