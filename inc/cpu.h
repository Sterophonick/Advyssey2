typedef struct
{
	u8 a;
	u8 r0;
	u8 r1;
	u8 r2;
	u8 r3;
	u8 r4;
	u8 r5;
	u8 r6;
	u8 r7;
	u8 p1;
	u8 p2;
	u16 pc;
	u8 c;
	u8 f0;
	u8 f1;
	u8 sp;
	u8 psw;
	u8 xirq_en;
	u8 tirq_en;
	u8 xirq_pend;
	u8 tirq_pend;
	u8 irq_ex;
	u8 t_flag;
	u8 bs;
	u8 ac;
	u8 cy;
	u32 clk;
	u16 A11;
	u16 A11ff;
}cpu;

extern cpu i8048;

extern u32 cycles;
extern u32 lastpc;
extern u8 CPU();
extern void menu();
extern u8 read_PB(u8 p);
extern void write_PB(u8 p, u8 val);
extern u8 read_P2(void);
extern u8 Read(u16 addr);