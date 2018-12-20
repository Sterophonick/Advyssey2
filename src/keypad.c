#include <libheart.h>
#include "cpu.h"
//0-F

u8 key[16];

void Keypad()
{
	if(keyDown(KEY_A))
	{
		key[AdvYssey2->a_key] = 1;
	}else{
		key[AdvYssey2->a_key] = 0;
	}
	if(keyDown(KEY_B))
	{
		key[AdvYssey2->b_key] = 1;
	}else{
		key[AdvYssey2->b_key] = 0;
	}
	if(keyDown(KEY_UP))
	{
		key[AdvYssey2->up_key] = 1;
	}else{
		key[AdvYssey2->up_key] = 0;
	}
	if(keyDown(KEY_DOWN))
	{
		key[AdvYssey2->down_key] = 1;
	}else{
		key[AdvYssey2->down_key] = 0;
	}
	if(keyDown(KEY_LEFT))
	{
		key[AdvYssey2->left_key] = 1;
	}else{
		key[AdvYssey2->left_key] = 0;
	}
	if(keyDown(KEY_RIGHT))
	{
		key[AdvYssey2->right_key] = 1;
	}else{
		key[AdvYssey2->right_key] = 0;
	}
	if(keyDown(KEY_SELECT))
	{
		key[AdvYssey2->sel_key] = 1;
	}else{
		key[AdvYssey2->sel_key] = 0;
	}
	if(keyDown(KEY_START))
	{
		key[AdvYssey2->strt_key] = 1;
	}else{
		key[AdvYssey2->strt_key] = 0;
	}
}

void MiscKeys()
{
	
}