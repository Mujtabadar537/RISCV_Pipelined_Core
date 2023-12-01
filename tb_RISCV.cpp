#include <stdio.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include <VRISCV_Top.h>


int main(int argc , char** argv)
{
	Verilated::commandArgs(argc,argv);
	VRISCV_Top* top = new VRISCV_Top;
	
	top -> reset = 0;
	top -> clk = 0;
	top -> eval();
	
	Verilated::traceEverOn(true);
	VerilatedVcdC* wave = new VerilatedVcdC;
	top -> trace(wave,100);
	wave -> open("waveform.vcd");
	
	
	
	for(int i=0; i<500; i++)
	{
	
		top -> eval();
		wave -> dump(i);
		top -> clk = !top -> clk;
				
	}
	
	
	
	wave->close();
    	delete top;
    	delete wave;	
	
	
	
	
	return 0;
}

