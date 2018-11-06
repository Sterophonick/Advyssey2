#include <libheart.h>

#include "bios.h"
u8 O2IWRAM[64] HRT_EWRAM_DATA;
u8 O2VRAM[128] HRT_EWRAM_DATA;
u8 O2ROMBANK[1024] HRT_EWRAM_DATA;
const u8 O2ROM[];

u8 Read(u16 addr)
{
	if(addr < 0x400)
	{
		
	}
	return 0;
}