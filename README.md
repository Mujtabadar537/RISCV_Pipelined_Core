# RISC-V Pipelined Core
This core implements a 5 stage pipeline . It supports RV32I instruction set architecture along with a hazard detection unit that take care of hazards by using forwarding . This processor has been implemented using a bottom up approach , every individual unit is desingned separately and then integrated into a single file . A make file has been added with the code to easily simulate it . Just type "make sim" on linux terminal to create the dump.vcd file for viewing the waveform type "make wave " .  

Note : Install gtkwave and iverilog for simulating it using makefile

# Datapath of Processor
![RISCV PIPELINE CORE](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/df64bf6b-77c8-43a0-ab46-1da8b100028d)


# Output Waveform
![RISCV_CORE_OUTPUT_WAVEFORM](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/cf7c5471-6f73-4172-90d2-59829c0caf91)


# RTL Schematic of Core
![RISCV_CORE_RTL_SCHEMATIC](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/cbe5e2dc-f640-4022-b81a-5620c44ebf91)





