#include <libheart.h>
#include "mem.h"
#include "cpu.h"
cpu i8048 HRT_EWRAM_DATA;

u32 cycles;
u32 lastpc;
u32 clk;

int RLOOP;

u8 CPU(void)
{
	uint16_t adr;
	uint8_t dat;
	int temp;

	while(1)
   {
      uint8_t op;

      i8048.clk=0;	

      lastpc=i8048.pc;
      op=O2BIOS[i8048.pc++];

      switch (op)
      {
         case 0x00: /* NOP */
            i8048.clk++;
            break;
			
         case 0x01: /* ILL */
            //crash();
            i8048.clk++;
            break;
			
		case 0x02: //outl bus,a
			i8048.clk+=2;
			break;
			
         case 0x03: /* ADD A,#data */
			i8048.a += O2BIOS[i8048.pc+2];
			break;
			
		case 0x04: //JMP
			i8048.pc = Read(i8048.pc) | i8048.A11;
			break;
			
		case 0x05: //EN I
		    i8048.xirq_en=1;
            i8048.clk++;
            break;
			
		case 0x06: //ILL
			//crash
			break;
			
		case 0x07: //DEC, A
			i8048.a--;
			break;
			
		case 0x08: /* INS A,BUS*/
            i8048.clk+=2;
            //acc=in_bus();
            break;
			
		case 0x09: /* IN A,Pp */
            i8048.a=i8048.p1;
            clk+=2;
            break;
			
         case 0x0A: /* IN A,Pp */
            i8048.a=read_P2();
            i8048.clk+=2;
            break;
			
		case 0x0B: //ILL
			//crash
			break;
			
		case 0x0C: /* MOVD A,P4 */
            i8048.clk+=2;
            i8048.a=read_PB(0);
            break;
			
		case 0x0D: /* MOVD A,P5 */
            i8048.clk+=2;
            i8048.a=read_PB(1);
            break;
		
		case 0x0E: /* MOVD A,P6 */
            i8048.clk+=2;
            i8048.a=read_PB(2);
            break;
			
		case 0x0F: /* MOVD A,P7 */
            i8048.clk+=2;
            i8048.a=read_PB(2);
            break;
			
		case 0x10: //INC @Rr
			
			
         case 0x13: /* ADDC A,#data */
            i8048.clk+=2;
            dat=Read(i8048.pc++);
            i8048.ac=0;
            if (((i8048.a & 0x0f) + (dat & 0x0f) + i8048.cy) > 0x0f) i8048.ac=0x40;
            temp=i8048.a+dat+i8048.cy;
            i8048.cy=0;
            if (temp > 0xFF) i8048.cy=1;
            i8048.a=(temp & 0xFF);
            break;
		 
		 case 0x17: //inc a
			i8048.a++;
			break;

		 case 0x18: //inc r0
			i8048.r0++;
			break;
		 
		 case 0x19: //inc r1
			i8048.r1++;
			break;
			
		 case 0x1A: //inc r2
			i8048.r2++;
			break;
			
		 case 0x1B: //inc r3
			i8048.r3++;
			break;
			
		 case 0x1C: //inc r4
			i8048.r4++;
			break;
		 
		 case 0x1D: //inc r5
			i8048.r5++;
			break;
			
		 case 0x1E: //inc r6
			i8048.r6++;
			break;
			
		 case 0x1F: //inc r7
			i8048.r0++;
			break;
			
         case 0x22: /* ILL */
            i8048.clk++;
            //illegal(op);
            break;
			
		case 0x23:  /* MOV a,#data */
            i8048.clk+=2;
            i8048.a = O2BIOS[i8048.pc++];
            break;
			
		case 0x27: //clr a
			i8048.a = 0;
			break;
			
         case 0xC6: /* JZ address */
            i8048.clk+=2;
            dat=Read(i8048.pc);
            if (i8048.a == 0)
               i8048.pc=(i8048.pc & 0xF00) | dat;
            else
               i8048.pc++;
            break;
			
		case 0x47: //swap a
			return ( (i8048.a & 0x0F)<<4 | (i8048.a & 0xF0)>>4 ); 
			break;
			
		case 0x68: //add a,r0
			i8048.a+=i8048.r0;
			
		case 0x69: //add a,r1
			i8048.a+=i8048.r1;
			
		case 0x6A: //add a,r2
			i8048.a+=i8048.r2;
			
		case 0x6B: //add a,r3
			i8048.a+=i8048.r3;
		
		case 0x6C: //add a,r4
			i8048.a+=i8048.r4;
			
		case 0x6D: //add a,r5
			i8048.a+=i8048.r0;
			
		case 0x6E: //add a,r6
			i8048.a+=i8048.r6;
			
		case 0x6F: //add a,r7
			i8048.a+=i8048.r7;
			
		case 0x77: /* RR A */
				i8048.clk++;
				dat=i8048.a & 0x01;
				i8048.a = i8048.a >> 1;
				if (dat)
					i8048.a = i8048.a | 0x80;
				else
					i8048.a = i8048.a & 0x7f;
				break;	
		
		case 0x84:  /* JMP L04XX*/
            i8048.pc = 
            i8048.clk+=2;
            break;
			
		case 0x97: //clr c
			i8048.c = 0;
			break;
			
		case 0x98: //clr f1
			i8048.f1 = 0;
			break;
			
		
		case 0x99: //clr f0
			i8048.f1 = 0;
			break;
		 
		 case 0xA0: /*mov @r0, a*/
			O2IWRAM[i8048.r0] = i8048.a;
			break;
			
		 case 0xA1: /*mov @r1, a*/
			O2IWRAM[i8048.r1] = i8048.a;
			break;
			
		 case 0xA2: /*mov @r2, a*/
			O2IWRAM[i8048.r2] = i8048.a;
			break;
			
		 case 0xA3: /*mov @r3, a*/
			O2IWRAM[i8048.r3] = i8048.a;
			break;
			
		 case 0xA4: /*mov @r4, a*/
			O2IWRAM[i8048.r4] = i8048.a;
			break;
			
		 case 0xA5: /*mov @r5, a*/
			O2IWRAM[i8048.r5] = i8048.a;
			break;
			
		 case 0xA6: /*mov @r6, a*/
			O2IWRAM[i8048.r6] = i8048.a;
			break;
			
		 case 0xA7: /*mov @r7, a*/
			O2IWRAM[i8048.r7] = i8048.a;
			break;
			
		case 0xA8: //mov r0, a
			i8048.r0 = i8048.a;
			break;
			
		case 0xA9: //mov r1, a
			i8048.r1 = i8048.a;
			break;
			
		case 0xAA: //mov r2, a
			i8048.r2 = i8048.a;
			break;
			
		case 0xAB: //mov r3, a
			i8048.r3 = i8048.a;
			break;
			
		case 0xAC: //mov r4, a
			i8048.r4 = i8048.a;
			break;
			
		case 0xAD: //mov r5, a
			i8048.r5 = i8048.a;
			break;
			
		case 0xAE: //mov r6, a
			i8048.r6 = i8048.a;
			break;
			
		case 0xAF: //mov r7, a
			i8048.r7 = i8048.a;
			break;
			
		case 0xB8: //mov r0, #data
			i8048.r0 = O2BIOS[i8048.pc+2];
			break;
		
		case 0xB9: //mov r1, #data
			i8048.r1 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBA: //mov r2, #data
			i8048.r2 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBB: //mov r3, #data
			i8048.r3 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBC: //mov r4, #data
			i8048.r4 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBD: //mov r3, #data
			i8048.r3 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBE: //mov r4, #data
			i8048.r4 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xBF: //mov r5, #data
			i8048.r5 = O2BIOS[i8048.pc+2];
			break;
			
		case 0x30: //mov r6, #data
			i8048.r6 = O2BIOS[i8048.pc+2];
			break;
			
		case 0x31: //mov r7, #data
			i8048.r7 = O2BIOS[i8048.pc+2];
			break;
			
		case 0xC8: //dec r0
			i8048.r0--;
			break;
			
		case 0xC9: //dec r1
			i8048.r1--;
			break;
			
		case 0xCA: //dec r2
			i8048.r2--;
			break;
			
		case 0xCB: //dec r3
			i8048.r3--;
			break;
			
		case 0xCC: //dec r4
			i8048.r4--;
			break;
			
		case 0xCD: //dec r5
			i8048.r5--;
			break;
			
		case 0xCE: //dec r6
			i8048.r6--;
			break;
			
		case 0xCF: //dec r7
			i8048.r7--;
			break;
			
		case 0xF0: //mov A,@R0
			i8048.a = O2IWRAM[i8048.r0];
			break;
			
		case 0xF1: //mov A,@R1
			i8048.a = O2IWRAM[i8048.r1];
			break;
			
		case 0xFF: //mov a,r7
			i8048.a = i8048.r7;
            break;
	}
	}
	return 0;
}