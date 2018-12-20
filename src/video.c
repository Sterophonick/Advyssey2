#include <libheart.h>
#include "cpu.h"
#include "lang.h"

u8 videobuffer[160*200] EWRAM_DATA;

void render()
{
	videobuffer[0] = 0x1F;
}