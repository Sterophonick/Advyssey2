#include <libheart.h>
#include "cpu.h"
#include "lang.h"

u8 o2_acc;
u8 o2_r[8];
u8 o2_p1;
u8 o2_p2;
u8 o2_c;
u16 o2_pc;
u8 o2_psw;
u8 o2_sp;
u8 o2_extirqen;
u32 o2_clk;
u8 o2_dat;
u8 o2_extirqpend;
u8 o2_timirqpend;
u16 o2_a11;
u16 o2_a11ff;
u8 o2_f0;
u8 o2_f1;

int int_clk; 	/* counter for length of /INT pulses */
int master_clk;	/* Master clock */
int h_clk;   /* horizontal clock */
unsigned long clk_counter;

u8 LowNyb;
u8 opcode;
u8 memory[64];
u8 extmemory[256];