#-----------Makefile for iverilog-----------#

#top:= UET_RISCV.v
#testbench:= testbench_RISCV.v 
#waveform_file:= dump.vcd

#sim:
#	iverilog -o waveform $(testbench) $(top)
#	vvp waveform
#	gtkwave $(waveform_file)
#clean:
#	rm waveform $(waveform_file)





#-----------Makefile for Verilator-----------#

source := RISCV_Top.v
testbench := tb_RISCV.cpp
top := RISCV_Top
opts := --trace


all:
	echo "Verilator simulation"
verilate:
	verilator --cc $(source)
	verilator -Wall $(opts) -cc $(source) --exe $(testbench)
	make -C obj_dir -f V$(top).mk V$(top)

wave:
	./obj_dir/V$(top)
	gtkwave waveform.vcd
clean:
	rm -fr obj_dir waveform.vcd
	
