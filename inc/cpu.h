#include <stdbool.h>

extern u8 videobuffer[160*200];

extern u8 o2_acc;
extern u8 o2_r[8];
extern u8 o2_p1;
extern u8 o2_p2;
extern u8 o2_c;
extern u16 o2_pc;
extern u8 o2_psw;
extern u8 o2_sp;
extern u8 o2_extirqen;
extern u32 o2_clk;
extern u8 o2_dat;
extern u8 o2_extirqpend;
extern u8 o2_timirqpend;
extern u16 o2_a11;
extern u16 o2_a11ff;
extern u8 o2_f0;
extern u8 o2_f1;

extern int int_clk; 	/* counter for length of /INT pulses */
extern int master_clk;	/* Master clock */
extern int h_clk;   /* horizontal clock */
extern unsigned long clk_counter;

extern u8 LowNyb;
extern u8 opcode;
extern u8 memory[64];
extern u8 extmemory[256];

extern void Initialize();
extern void emulateCycle();
extern void Keypad();
extern void render();
extern const unsigned char rom[];

#define MAX_GAME_SIZE (0x1000 - 0x200)

typedef struct
{
	u8 random_seed;
	u8 a_key;
	u8 b_key;
	u8 up_key;
	u8 down_key;
	u8 left_key;
	u8 right_key;
	u8 sel_key;
	u8 strt_key;
	u8 brightness;
	u8 palette;
	u8 sound;
	u8 dblsize;
	u8 swapab;
	u8 vsync;
	u8 autosleep;
	u8 firstboot;
	u8 state_iwram[64];
	u8 state_ewram[256];
}emu;
extern emu* AdvYssey2;

extern char setLowerNibble(char orig, char nibble);
extern char setUpperNibble(char orig, char nibble);

void render();

extern void menu();
extern void RequestExit();

extern void debugger();

extern u32 autosleeptimer;

extern u8 updatevsync;

void execute(u8 op);