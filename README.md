# RISCV_Pipelined_Core
This is a complete RISCV core implementing a 5 stage pipeline . It supports RV32I instruction set architecture along with a hazard detection unit that take care of hazards by using forwarding . A make file has been added with the code to easily simulate it . Just type "make sim" on linux terminal to create the dump.vcd file for viewing the waveform type "make wave " .  

Note : Install gtkwave and iverilog for simulating it using makefile

# Datapath of Processor
![RISCV PIPELINE CORE](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/df64bf6b-77c8-43a0-ab46-1da8b100028d)


# Output Waveform
![Screenshot 2023-10-09 190257](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/c3586fd7-741c-4e9b-a945-ed1fa1c73e7f)

# RTL schematic of core using vivado
![RISCV_CORE_RTL_SCHEMATIC](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/cbe5e2dc-f640-4022-b81a-5620c44ebf91)





