.global o2_acc
.global o2_r
.global o2_p1
.global o2_p2
.global o2_f0
.global o2_f1
.global o2_sp
.global o2_psw
.global o2_pc //hword
.global o2_c
.global o2_clk //word
.global o2_acc11 //hword
.global o2_extirqen
.global memory //64
.global extmemory //256
.global o2_dat
.global o2_a11 //hword

.global LowNyb

.global op_table

.global ROM
.global illegal
.global hrt_SwapNibbles
.global execute

.include "src/mcs48mac.s"

_00: //NOP
	clock 1
	pop {r0-r8}
	bx lr
	
_03: //ADD A,#data

_04: //JMP
	opJMP 0
	clock 1
	pop {r0-r8}
	bx lr
	
_05: //EN I
	ldr r0,=o2_extirqen
	mov r1,#1
	strb r1,[r0]
	clock 1
	pop {r0-r8}
	bx lr

_07: //DEC A
	opDEC8 o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_08: //INS A,BUS
_09: //IN A,P1
_0A: //IN A,P2
_0C: //MOVD A,P4
_0D: //MOVD A,P5
_0E: //MOVD A,P6
_0F: //MOVD A,P7

_10: //INC @R0
_11: //INC @R1
	ldr r0,=o2_r
	ldr r1,=LowNyb
	ldrb r1,[r1]
	add r0,r1
	opINCM8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_12: //JBb address
_13: //ADDC A,#data
_14: //CALL

_15: //DIS I
	ldr r0,=o2_extirqen
	mov r1,#0
	strb r1,[r0]
	clock 1
	pop {r0-r8}
	bx lr	
	
_16: //JTF
_17: //INC A
	ldr r0,=o2_acc
	opINC8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_18: //INC r0
_19: //INC r1
_1A: //INC r2
_1B: //INC r3
_1C: //INC r4
_1D: //INC r5
_1E: //INC r6
_1F: //INC r7
	ldr r0,=o2_r
	ldr r1,=LowNyb
	ldrb r1,[r1]
	sub r1,#0x8
	add r0,r1
	opINC8 r0
	clock 1
	pop {r0-r8}
	bx lr

_20: //XCH A, @R0
_21: //XCH A, @R1
	ldr r0,=o2_r
	ldr r1,=LowNyb
	ldrb r1,[r1]
	add r0,r1
	//opXCH Memory
	clock 1
	pop {r0-r8}
	bx lr
	
_23: //MOV A,#data
_24: //JMP
	opJMP 0x100
	clock 1
	pop {r0-r8}
	bx lr
	
_25: //EN TCNTI
_26: //JNT0
_27: //CLR A
	ldr r0,=o2_acc
	opCLR8 r0
	clock 1
	pop {r0-r8}
	bx lr
.pool

_28: //XCH A,R0
_29: //XCH A,R1
_2A: //XCH A,R2
_2B: //XCH A,R3
_2C: //XCH A,R4
_2D: //XCH A,R5
_2E: //XCH A,R6
_2F: //XCH A,R7
	ldr r0,=o2_r
	ldr r1,=LowNyb
	ldrb r1,[r1]
	sub r1,#0x8
	add r0,r1
	opXCH r0
	clock 1
	pop {r0-r8}
	bx lr

_30: //XCHD A,@R0
_31: //XCHD A,@R1
_32: //JBb address
_34: //CALL
_35: //DIS TCNTI
_36: //JT0
_37: //CPL A
_39: //OUTL P1,A
_3A: //OUTL P2,A
_3C: //MOVD P4,A
_3D: //MOVD P5,A
_3E: //MOVD P6,A
_3F: //MOVD P7,A
_40: //ORL A,@R0
_41: //ORL A,@R1
_42: //MOV A,T
_43: //ORL A,#data
_44: //JMP
	opJMP 0x200
	clock 1
	pop {r0-r8}
	bx lr
	
_45: //STRT CNT
_46: //JNT1
_47: //SWAP A
	ldr r0,=o2_acc
	opSWAP8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_48: //ORL A,R0
_49: //ORL A,R1
_4A: //ORL A,R2
_4B: //ORL A,R3
_4C: //ORL A,R4
_4D: //ORL A,R5
_4E: //ORL A,R6
_4F: //ORL A,R7
_50: //ANL A,@R0
_51: //ANL A,@R1
_52: //JBb addr
_53: //ANL A,#data
_54: //CALL
_55: //STRT T
_56: //JT1
_57: //DA A
_58: //ANL A,R0
_59: //ANL A,R1
_5A: //ANL A,R2
_5B: //ANL A,R3
_5C: //ANL A,R4
_5D: //ANL A,R5
_5E: //ANL A,R6
_5F: //ANL A,R7
_60: //ADD A,@R0
_61: //ADD A,@R1
_62: //MOV T,A
_64: //JMP
	opJMP 0x300
	clock 1
	pop {r0-r8}
	bx lr

_65: //STOP TCNT
_67: //RRC A
_68: //ADD A,R0
_69: //ADD A,R1
_6A: //ADD A,R2
_6B: //ADD A,R3
_6C: //ADD A,R4
_6D: //ADD A,R5
_6E: //ADD A,R6
_6F: //ADD A,R7
_70: //ADDC A,@R0
_71: //ADDC A,@R1
_72: //JBb address
_74: //CALL
_76: //JF1 addr
_77: //RR A
_78: //ADDC A,R0
_79: //ADDC A,R1
_7A: //ADDC A,R2
_7B: //ADDC A,R3
_7C: //ADDC A,R4
_7D: //ADDC A,R5
_7E: //ADDC A,R6
_7F: //ADDC A,R7

_80: //MOVX A,@R0
_81: //MOVX A,@R1
_83: //RET

_84: //JMP
	opJMP 0x400
	clock 2
	pop {r0-r8}
	bx lr
	
_85: //CLR F0
	ldr r0,=o2_f0
	opCLR8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_86: //JNI addr
_89: //ORL Pp,#data
_8A: //ORL Pp,#data
_8C: //ORLD P4,A
_8D: //ORLD P5,A
_8E: //ORLD P6,A
_8F: //ORLD P7,A
_90: //MOVX @R0,A
_91: //MOVX @R1,A
_92: //JBb
_93: //RETR
_94: //CALL
_95: //CPL F0
_96: //JNZ addr

_97: //CLR C
	ldr r0,=o2_c
	opCLR8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_99: //ANL P1,#data
_9A: //ANL P2,#data
_9C: //ANLD P4,A
_9D: //ANLD P5,A
_9E: //ANLD P6,A
_9F: //ANLD P7,A

_A0: //MOV @R0,A
_A1: //MOV @R1,A
_A3: //MOVP A,@A

_A4: //JMP
	opJMP 0x500
	clock 2
	pop {r0-r8}
	bx lr
	
_A5: //CLR F1
	ldr r0,=o2_f1
	opCLR8 r0
	clock 1
	pop {r0-r8}
	bx lr
	
_A7: //CPL C

_A8: //MOV R0,A
	opMOV8 o2_r,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_A9: //MOV R1,A
	opMOV8 o2_r+1,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AA: //MOV R2,A
	opMOV8 o2_r+2,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AB: //MOV R3,A
	opMOV8 o2_r+3,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AC: //MOV R4,A
	opMOV8 o2_r+4,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AD: //MOV R5,A
	opMOV8 o2_r+5,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AE: //MOV R6,A
	opMOV8 o2_r+6,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_AF: //MOV R7,A
	opMOV8 o2_r+7,o2_acc
	clock 1
	pop {r0-r8}
	bx lr
	
_B0: //MOV @R0,#data
_B1: //MOV @R1,#data
_B2: //JBb address
_B3: //JMPP @A
_B4: //CALL
_B5: //CPL F1
_B6: //JF0 address
_B8: //MOV R0,#data
_B9: //MOV R1,#data
_BA: //MOV R2,#data
_BB: //MOV R3,#data
_BC: //MOV R4,#data
_BD: //MOV R5,#data
_BE: //MOV R6,#data
_BF: //MOV R7,#data

_C4: //JMP
	opJMP 0x600
	clock 2
	pop {r0-r8}
	bx lr
	
_C5: //SEL RB0
_C6: //JZ addres
_C7: //MOV A,PSW

_C8: //DEC r0
	opDEC8 o2_r
	clock 1
	pop {r0-r8}
	bx lr
	
_C9: //DEC r1
	opDEC8 o2_r+1
	clock 1
	pop {r0-r8}
	bx lr
	
_CA: //DEC r2
	opDEC8 o2_r+2
	clock 1
	pop {r0-r8}
	bx lr
	
_CB: //DEC r3
	opDEC8 o2_r+3
	clock 1
	pop {r0-r8}
	bx lr
	
_CC: //DEC r4
	opDEC8 o2_r+4
	clock 1
	pop {r0-r8}
	bx lr
	
_CD: //DEC r5
	opDEC8 o2_r+5
	clock 1
	pop {r0-r8}
	bx lr
	
_CE: //DEC r6
	opDEC8 o2_r+6
	clock 1
	pop {r0-r8}
	bx lr
	
_CF: //DEC r7
	opDEC8 o2_r+7
	clock 1
	pop {r0-r8}
	bx lr
	
_D0: //XRL A,@R0
_D1: //XRL A,@R1
_D2: //JBb address
_D3: //XRL A,#data
_D4: //CALL
_D5: //SEL RB1
_D7: //MOV PSW,A
_D8: //XRL A,R0
_D9: //XRL A,R1
_DA: //XRL A,R2
_DB: //XRL A,R3
_DC: //XRL A,R4
_DD: //XRL A,R5
_DE: //XRL A,R6
_DF: //XRL A,R7
_E3: //MOVP3 A,@A

_E4: //JMP
	opJMP 0x700
	clock 2
	pop {r0-r8}
	bx lr
	
_E5: //SEL MB0
_E6: //JNC address
_E7: //RL A
_E8: //DJNZ R0,address
_E9: //DJNZ R1,address
_EA: //DJNZ R2,address
_EB: //DJNZ R3,address
_EC: //DJNZ R4,address
_ED: //DJNZ R5,address
_EE: //DJNZ R6,address
_EF: //DJNZ R7,address
_F0: //MOV A,@R0
_F1: //MOV A,@R1
_F2: //JBb address
_F4: //CALL
_F5: //SEL MB1
_F6: //JC Address
_F7: //RLC A

_F8: //MOV A,R0
	opMOV8 o2_acc,o2_r
	clock 1
	pop {r0-r8}
	bx lr
	
_F9: //MOV A,R1
	opMOV8 o2_acc,o2_r+1
	clock 1
	pop {r0-r8}
	bx lr
	
_FA: //MOV A,R2
	opMOV8 o2_acc,o2_r+2
	clock 1
	pop {r0-r8}
	bx lr
	
_FB: //MOV A,R3
	opMOV8 o2_acc,o2_r+3
	clock 1
	pop {r0-r8}
	bx lr
	
_FC: //MOV A,R4
	opMOV8 o2_acc,o2_r+4
	clock 1
	pop {r0-r8}
	bx lr
	
_FD: //MOV A,R5
	opMOV8 o2_acc,o2_r+5
	clock 1
	pop {r0-r8}
	bx lr
	
_FE: //MOV A,R6
	opMOV8 o2_acc,o2_r+6
	clock 1
	pop {r0-r8}
	bx lr
	
_FF: //MOV A,R7
	opMOV8 o2_acc,o2_r+7
	clock 1
	pop {r0-r8}
	bx lr
	
_01:
_02:
_06:
_0B:
_22:
_33:
_38:
_3B:
_63:
_66:
_73:
_75:
_82:
_87:
_88:
_8B:
_98:
_9B:
_A2:
_A6:
_B7:
_C0:
_C1:
_C2:
_C3:
_D6:
_E0:
_E1:
_E2:
_F3: //Illegal
	clock 1
	pop {r0-r8}
	bx lr

op_table:
	.word _00,_01,_02,_03,_04,_05,_06,_07,_08,_09,_0A,_0B,_0C,_0D,_0E,_0F
	.word _10,_11,_12,_13,_14,_15,_16,_17,_18,_19,_1A,_1B,_1C,_1D,_1E,_1F
	.word _20,_21,_22,_23,_24,_25,_26,_27,_28,_29,_2A,_2B,_2C,_2D,_2E,_2F
	.word _30,_31,_32,_33,_34,_35,_36,_37,_38,_39,_3A,_3B,_3C,_3D,_3E,_3F
	.word _40,_41,_42,_43,_44,_45,_46,_47,_48,_49,_4A,_4B,_4C,_4D,_4E,_4F
	.word _50,_51,_52,_53,_54,_55,_56,_57,_58,_59,_5A,_5B,_5C,_5D,_5E,_5F
	.word _60,_61,_62,_63,_64,_65,_66,_67,_68,_69,_6A,_6B,_6C,_6D,_6E,_6F
	.word _70,_71,_72,_73,_74,_75,_76,_77,_78,_79,_7A,_7B,_7C,_7D,_7E,_7F
	.word _80,_81,_82,_83,_84,_85,_86,_87,_88,_89,_8A,_8B,_8C,_8D,_8E,_8F
	.word _90,_91,_92,_93,_94,_95,_96,_97,_98,_99,_9A,_9B,_9C,_9D,_9E,_9F
	.word _A0,_A1,_A2,_A3,_A4,_A5,_A6,_A7,_A8,_A9,_AA,_AB,_AC,_AD,_AE,_AF
	.word _B0,_B1,_B2,_B3,_B4,_B5,_B6,_B7,_B8,_B9,_BA,_BB,_BC,_BD,_BE,_BF
	.word _C0,_C1,_C2,_C3,_C4,_C5,_C6,_C7,_C8,_C9,_CA,_CB,_CC,_CD,_CE,_CF
	.word _D0,_D1,_D2,_D3,_D4,_D5,_D6,_D7,_D8,_D9,_DA,_DB,_DC,_DD,_DE,_DF
	.word _E0,_E1,_E2,_E3,_E4,_E5,_E6,_E7,_E8,_E9,_EA,_EB,_EC,_ED,_EE,_EF
	.word _F0,_F1,_F2,_F3,_F4,_F5,_F6,_F7,_F8,_F9,_FA,_FB,_FC,_FD,_FE,_FF
	
execute: //r0: opcode
	push {r0-r8}
	ldrb r0,[r0]
	ldr r1,=op_table
	mov r3,#4
	mul r4,r0,r3
	ldr r2,[r1,r4]
	bx r2
	bx lr
	