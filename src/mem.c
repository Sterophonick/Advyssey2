#include <libheart.h>
typedef void (*funcptr)();
u8 o2_a HRT_EWRAM_DATA;
u8 o2_r0 HRT_EWRAM_DATA;
u8 o2_r1 HRT_EWRAM_DATA;
u8 o2_r2 HRT_EWRAM_DATA;
u8 o2_r3 HRT_EWRAM_DATA;
u8 o2_r4 HRT_EWRAM_DATA;
u8 o2_r5 HRT_EWRAM_DATA;
u8 o2_r6 HRT_EWRAM_DATA;
u8 o2_r7 HRT_EWRAM_DATA;
u8 o2_p1 HRT_EWRAM_DATA;
u8 o2_p2 HRT_EWRAM_DATA;
u16 o2_pc HRT_EWRAM_DATA;
u8 o2_c HRT_EWRAM_DATA;
u8 o2_f0 HRT_EWRAM_DATA;
u8 o2_f1 HRT_EWRAM_DATA;
u8 o2_sp HRT_EWRAM_DATA;
u8 o2_psw HRT_EWRAM_DATA;
u8 o2_xirqen HRT_EWRAM_DATA;
u8 o2_tirqen HRT_EWRAM_DATA;
u8 o2_xirqpend HRT_EWRAM_DATA;
u8 o2_tirqpend HRT_EWRAM_DATA;
u8 o2_irqex HRT_EWRAM_DATA;
u8 o2_tflag HRT_EWRAM_DATA;
u8 o2_bs HRT_EWRAM_DATA;
u8 o2_ac HRT_EWRAM_DATA;
u8 o2_cy HRT_EWRAM_DATA;
u32 o2_clk HRT_EWRAM_DATA;
u16 o2_a11 HRT_EWRAM_DATA;
u16 o2_a11ff HRT_EWRAM_DATA;
u8 o2_dat HRT_EWRAM_DATA;
u8 o2_timeron HRT_EWRAM_DATA;
u8 o2_itimer HRT_EWRAM_DATA;
u8 o2_adr HRT_EWRAM_DATA;
int o2_temp HRT_EWRAM_DATA;
u8 o2_pendirq HRT_EWRAM_DATA;
#include "bios.h"
u8 O2IWRAM[64] HRT_EWRAM_DATA;
u8 O2VRAM[128] HRT_EWRAM_DATA;
#include "rom.h"
const u8 O2ROM[];
extern void (*op_table[256])(void);

int int_clk; 	/* counter for length of /INT pulses */
int master_clk;	/* Master clock */
int h_clk;   /* horizontal clock */
unsigned long clk_counter;
int last_line;
int key2vcnt=0;
int mstate;


u32 instruction;
funcptr ins;

u8 ROM(u16 adr) { return (O2ROMBANK[(adr)]); }


u8 Read(u16 addr)
{
	if(addr < 0x400)
	{
		return O2BIOS[addr];
	}
	return 0;
}

void Write(u16 addr, u8 value)
{
	if(addr < 0x400)
	{
		
	}
}

#define push(d) {O2IWRAM[o2_sp++] = (d); if (o2_sp > 23) o2_sp = 8;}
#define pull() (o2_sp--, (o2_sp < 8)?(o2_sp=23):0, O2IWRAM[sp])
#define make_psw() {o2_psw = (o2_cy << 7) | o2_ac | o2_f0 | o2_bs | 0x08; o2_psw = o2_psw | ((o2_sp - 8) >> 1);}


void ext_IRQ(void){
	int_clk = 5; /* length of pulse on /INT */
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
	if (o2_pendirq && (!o2_xirqen)) o2_xirqpend=1;
}

void tim_IRQ(void){
	if (o2_tirqen && !o2_irqex) {
		o2_irqex=2;
		o2_tirqpend=0;
		o2_clk+=2;
		make_psw();
		push(o2_pc & 0xFF);
		push(((o2_pc & 0xF00) >> 8) | (o2_psw & 0xF0));
		o2_pc = 0x07;
		o2_a11ff=o2_a11;
		o2_a11=0;
	}
	if (o2_pendirq && (!o2_tirqen)) o2_tirqpend=1;
}

void AdvYssey2_CPU()
{
	o2_clk = 0;
	op_table[O2ROMBANK[o2_pc]]();
	if (o2_xirqpend) ext_IRQ();
	if (o2_tirqpend) tim_IRQ();
}

void illegal(u8 id)
{
	while(1)
	{
		hrt_VblankIntrWait();
	}
}
