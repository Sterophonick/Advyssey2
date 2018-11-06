extern u8 O2BIOS[1024] HRT_EWRAM_DATA;
extern u8 O2IWRAM[64];
extern u8 O2VRAM[128];
extern u8 O2ROM[];
extern u8 O2ROMBANK[1024];

typedef struct
{
	u8 y;
	u8 x;
	u8 attr;
}O2Spr;

O2Spr O2Sprites[4];


#define O2_KEY_REGISTER O2IWRAM[0x1A]