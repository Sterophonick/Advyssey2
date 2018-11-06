#include <libheart.h>
#include "mem.h"

u8 keydata[5];

void GetKeypad()
{
	if(keyDown(KEY_UP)) //Up
	{
		keydata[1] = 1;
	}else{
		keydata[1] = 0;
	}
	if(keyDown(KEY_DOWN)) // DOwn
	{
		keydata[3] = 1;
	}else{
		keydata[3] = 0;
	}
	if(keyDown(KEY_LEFT)) //Left
	{
		keydata[4] = 1;
	}else{
		keydata[4] = 0;
	}
	if(keyDown(KEY_RIGHT)) //Right
	{
		keydata[2] = 1;
	}else{
		keydata[2] = 0;
	}
	if(keyDown(KEY_A)) //Fire
	{
		keydata[5] = 1;
	}else{
		keydata[5] = 0;
	}
}

void MergeKeyData()
{
	u8 regtemp;
	regtemp |= keydata[0] << 0;
	regtemp |= keydata[1] << 1;
	regtemp |= keydata[2] << 2;
	regtemp |= keydata[3] << 3;
	regtemp |= keydata[4] << 4;
	O2_KEY_REGISTER = regtemp;
}

void MiscKeys()
{
	
}