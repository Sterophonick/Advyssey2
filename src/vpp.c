#include <libheart.h>
#include "cpu.h"
#include "mem.h"

static u8 LumReg = 0xff, TraReg = 0xff;
static int need_update=0;

u8 read_PB(u8 p){
	p &= 0x3;
	switch (p) {
		case 0:
			return LumReg >> 4;
			break;
		case 1:
			return LumReg & 0xf;
			break;
		case 2:
			return TraReg >> 4;
			break;
		case 3:
			return TraReg & 0xf;
			break;
	}
	return 0;
}

void write_PB(u8 p, u8 val){
	p &= 0x3;
	val &= 0xf;

	switch (p) {
		case 0:
			LumReg = (val<<4) | (LumReg & 0xf);
			break;
		case 1:
			LumReg = (LumReg & 0xf0) | val;
			break;
		case 2:
			TraReg = (val<<4) | (TraReg & 0xf);
			break;
		case 3:
			TraReg = (TraReg & 0xf0) | val;
			break;
	}
	need_update = 1;
}



u8 read_P2(void)
{
/*
    int i,si,so,km;
    //nds_controls();
    if (!(i8048.p1 & 0x04))
    {
        si = (i8048.p2 & 7);
        so=0xff;
        if (si<6)
        {
            for (i=0; i<8; i++)
            {
                km = key_map[si][i];
                if ((key[km] && ((!joykeystab[km]) ||
                                 (key_shifts & KB_CAPSLOCK_FLAG)))

                   )
                {
                    so = i ^ 0x07;
                }
            }
        }
        if (so != 0xff)
        {
            i8048.p2 = i8048.p2 & 0x0F;
            i8048.p2 = i8048.p2 | (so << 5);
        }
        else
        {
            i8048.p2 = i8048.p2 | 0xF0;
        }
    }
    else
    {
        i8048.p2 = i8048.p2 | 0xF0;
    }
    return(i8048.p2);
	*/
}