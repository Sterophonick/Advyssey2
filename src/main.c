#include <libheart.h>
#include "cpu.h"
#include "mem.h"

int main()
{
	hrt_Init();
	hrt_InitTiledText(2);
	hrt_DSPSetBGMode(0);
	hrt_DSPEnableBG(2);
	hrt_DSPDisableForceBlank();
	while(1)
	{
		hrt_VblankIntrWait();
		CPU(); 
		GetKeypad();
		MergeKeyData();
		if(keyDown(KEY_R))
		{
			if(keyDown(KEY_L)) menu();
		}
	}
	return 0;
}