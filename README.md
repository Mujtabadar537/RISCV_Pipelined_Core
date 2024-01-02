# RISC-V Pipelined Core
This core implements classic 5 stage pipeline . It supports RV32IM instruction set architecture along with a hazard detection unit that take care of hazards by using forwarding . This processor has been implemented using a bottom up approach , every individual unit is desingned separately and then integrated into a single file . A make file has been added with the code to easily simulate it using verilator .

Note : verilator is required for simualtion

# Simulation
![Screenshot 2023-12-01 190558](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/174a7fef-4de0-4020-a48b-efd688d0e1db)

For viewing the wavform  
![mhmh](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/8f12bb22-3e03-42ff-86d2-bbd82706c264)


# Datapath of Processor
![RISCV PIPELINE CORE](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/df64bf6b-77c8-43a0-ab46-1da8b100028d)


# Output Waveform
![RISCV_WAVEFORM](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/3c6f6f7a-954b-4336-b07b-c9d1d9fa11e5)




# RTL Schematic of Core
![RISCV_CORE_RTL_SCHEMATIC](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/cbe5e2dc-f640-4022-b81a-5620c44ebf91)





