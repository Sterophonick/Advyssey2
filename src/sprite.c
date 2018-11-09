#include <libheart.h>
#include "mem.h"
#include "cpu.h"

typedef struct
{
	u8 shiftright : 1;
	u8 shiftevenright : 1;
	u8 dblsize : 1;
	u8 palette : 3;
}attribute;

typedef struct
{
	u8 Y;
	u8 X;
	attribute attributes;
	u8 unused;
}O2Sprite;

O2Sprite O2Sprites[4];