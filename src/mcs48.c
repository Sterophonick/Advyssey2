#include <libheart.h>
#include "cpu.h"
#include "lang.h"
#include "rom.h"

u16 ROM(u16 adr) { return (GAME[(adr)&0xFFF]); }

void Initialize()
{

}

void ext_IRQ(void){
/*
	int_clk = 5; /* length of pulse on /INT 
	if (o2_xirqen && !o2_irqex) {
		o2_irqex=1;
		o2_xirqpend=0;
		o2_clk+=2;
		make_psw();
		push(o2_pc & 0xFF);
		push(((o2_pc & 0xF00) >> 8) | (o2_psw & 0xF0));
		o2_pc = 0x03;
		o2_a11ff=o2_a11;
		o2_a11=0;
	}
	if (o2_pendirq&& (!o2_xirqen)) o2_xirqpend=1;
	*/
}

void tim_IRQ(void){
	/*if (o2_tirqen && !o2_irqex) {
		o2_irqex=2;
		o2_tirqpend=0;
		o2_clk+=2;
		make_psw();
		push(o2_pc & 0xFF);
		push(((o2_pc & 0xF00) >> 8) | (o2_psw& 0xF0));
		o2_pc = 0x07;
		o2_a11ff=o2_a11;
		o2_a11=0;
	}
	if (o2_pendirq && (!o2_tirqen)) o2_tirqpend=1;
	*/
}

void mcs48_Execute()
{
	o2_clk = 0;
	opcode = ROM(o2_pc++);
	LowNyb = opcode & 0x000F;
	execute(opcode);
	/*
		master_clk+=o2_clk;
		h_clk+=o2_clk;
		clk_counter+=o2_clk;

		/* flag for JNI 
		if (int_clk > o2_clk)
			int_clk -= o2_clk;
		else
			int_clk = 0;
			
	if (o2_xirqpend) ext_IRQ();
	if (o2_tirqpend) tim_IRQ();
	*/
}