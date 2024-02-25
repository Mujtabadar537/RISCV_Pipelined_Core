# Microarchitecture of Core
![pipelined_datapath](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/e39d493c-b01a-4320-8567-a0c5e3f54d1d)  

## Forwarding Unit 
![Forwarding_Unit](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/3995edf1-fbe3-4c6d-a3b1-1b2d1bb77f19)

## Simulation Waveform
![pipelined_waveform](https://github.com/Mujtabadar537/RISCV_Pipelined_Core/assets/111755551/a278f987-60ad-4333-9ac2-7b3c15579af7) 

## Simulation of Design
```python
* Verilator is required for simulaton .
* If you don't have linux machine  for using verilator any virtual machine or WSL can be used .
* After cloning the repository cd to RTL directory .
* Type "make verilate" on terminal to create object directory of verilator .
* Now type "make wave" to view the waveform (gtkwave is required) .
* "make clean" can be used to delete the object directory and vcd files .
```
