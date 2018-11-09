.global illegal
.global o2_a
.global o2_r0
.global o2_r1
.global o2_r2
.global o2_r3
.global o2_r4
.global o2_r5
.global o2_r6
.global o2_r7
.global o2_p1
.global o2_p2
.global o2_pc
.global o2_c
.global o2_f0
.global o2_f1
.global o2_sp
.global o2_psw
.global o2_xirqen
.global o2_tirqen
.global o2_xirqpend
.global o2_tirqpend
.global o2_irqex
.global o2_irqflag
.global o2_bs
.global o2_ac
.global o2_cy
.global o2_clk
.global o2_a11
.global o2_a11ff
.global o2_dat
.global o2_timeron
.global o2_itimer
.global O2BIOS
.global O2IWRAM
.global O2ROMBANK
.global op_table
.global ROM
.global AdvYssey2_CPU
.align 16
.pool
.text
.arm
.cpu arm7tdmi

increment_clk1:
	ldrb r2,=#o2_clk
	ldrb r1,[r2]
	add r1,r1,#1
	strb r1,[r2]

increment_clk2:
	ldrb r2,=#o2_clk
	ldrb r1,[r2]
	add r1,r1,#2
	strb r1,[r2]
	bx lr

_00: //nop
	ldr r0,=increment_clk1
	bx r0
	bx lr

_01: //ILL
	ldrb r0,=#1
	ldr r1,=illegal
	bx r1
	
_02: //OUTL bus,#data
	b increment_clk2
	bx lr
	
_03: //ADD A,#data
	bx lr

_04: //JMP
	ldr r3,=#o2_pc
	ldr r5,=#O2ROMBANK
	ldr r1,=#o2_a11
	ldr r4,=#o2_clk
	ldrb r0,[r3]
	b ROM
	orr r2,r2,r1
	mov r0,r2
	ldr r3,=#o2_pc
	strb r2,[r3]
	bx lr
	
_05: //EN I
	ldrb r1,=#o2_xirqen
	ldrb r0,[r1]
	mov r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_06: //ILL
	ldrb r0,=#1
	b illegal
		
_07: //DEC A
	ldrb r1,=#o2_a
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_08: //INS A,BUS
	//in_bus();
	
_09: //IN A,P1
	ldrb r1,=#o2_a
	ldrb r2,=#o2_p1
	ldrb r0,[r1]
	ldrb r3,[r2]
	mov r0,r3
	strb r0,[r1]
	bx lr
	
_0A: //IN A,Pp
	bx lr

_0B: //ILL
	ldrb r0,=#1
	ldr r1,=illegal
	bx r1

_0C: //MOVD A,P4
	bx lr

_0D: /* MOVD A,P5 */
	bx lr

_0E: /* MOVD A,P6 */
	bx lr

_0F: /* MOVD A,P7 */
	bx lr
	
_10: //INC @Rr
	ldr r1,=#o2_r0
	ldr r2,=#O2IWRAM
	bx lr
	
_11: //INC @Rr
	ldr r1,=#o2_r1
	ldr r2,=#O2IWRAM
	bx lr
	
_12: //JBb address
	bx lr

_13: //ADDC A,#data
	bx lr

_14: //CALL
	bx lr
	
_15: //DIS I
	ldrb r1,=#o2_xirqen
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_16://JTF
	bx lr
	
_17: //INC A
	ldrb r1,=#o2_a
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_18: //INC r0
	ldrb r1,=#o2_r0
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_19: //INC r1
	ldrb r1,=#o2_r1
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr

_1A: //INC r2
	ldrb r1,=#o2_r2
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_1B: //INC r3
	ldrb r1,=#o2_r3
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	bx lr
	
_1C: //INC r4
	ldrb r1,=#o2_r4
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_1D: //INC r5
	ldrb r1,=#o2_r5
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_1E: //INC r6
	ldrb r1,=#o2_r6
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_1F: //INC r7
	ldrb r1,=#o2_r7
	ldrb r0,[r1]
	add r0,r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_20: //XCH A,@Rr
	bx lr
	
_21: //XCH A,@Rr
	bx lr
	
_22: //Illegal
	ldrb r0,=#1
	b illegal
	
_23: //MOV A,#DATA
	bx lr
	
_24: //JMP
	bx lr

_25: //EN TCNTI
	ldrb r1,=#o2_tirqen
	ldrb r0,[r1]
	mov r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_26: //JNT0
	bx lr
	
_27: //CLR A
	ldrb r1,=#o2_r6
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_28: // XCH A,Rr
	bx lr
	
_29: // XCH A,Rr
	bx lr
	
_2A: // XCH A,Rr
	bx lr
	
_2B: // XCH A,Rr
	bx lr
	
_2C: // XCH A,Rr
	bx lr
	
_2D: // XCH A,Rr
	bx lr
	
_2E: // XCH A,Rr
	bx lr
	
_2F: // XCH A,Rr
	bx lr
	
_30: //XCHD A,@Ri
	bx lr
	
_31: //XCHD A,@Ri
	bx lr
	
_32: //JBb address
	bx lr
	
_33: //Illegal
	ldrb r0,=#1
	b illegal
	
_34: //CALL
	bx lr
	
_35: //DIS TCNTI
	ldrb r1,=#o2_tirqen
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	ldrb r1,=#o2_tirqpend
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_36: //JT0
	bx lr

_37: //CPL A
	ldrb r1,=#o2_a
	neg r0,r1
	strb r0,[r1]
	bx lr

_38: //Illegal
	ldrb r0,=#1
	b illegal
	
_39: //OUTL P1,A
	bx lr
	
_3A: //OUTL P2,A
	ldrb r1,=#o2_a
	ldrb r2,=#o2_p2
	ldrb r0,[r1]
	ldrb r3,[r2]
	mov r3,r0
	strb r2,[r3]
	b increment_clk2
	bx lr
	
_3B: //Illegal
	ldrb r0,=#1
	b illegal
	
_3C: //MOVD P4,A
	bx lr
	
_3D: //MOVD P5,A
	bx lr
	
_3E: //MOVD P6,A
	bx lr
	
_3F: //MOVD P7,A
	bx lr
	
_42: //MOV A,T
	ldr r1,=#o2_a
	ldr r2,=#o2_itimer
	ldrb r0,[r1]
	ldrb r3,[r2]
	mov r0,r3
	strb r0,[r1]
	b increment_clk1
	bx lr
	

_47: //SWAP A
	ldr r1,=#o2_a
	ldrb r0,[r1]
	ldr r2,=#o2_dat
	ldrb r3,[r2]
	lsr r3, r2, #4
	lsl r2, r2, #4
	strb r3, [r2]
	orr r3,r2
	strb r3,[r1]
	b increment_clk1
	bx lr

_55: //STRT T
	ldrb r1,=#o2_timeron
	ldrb r0,[r1]
	mov r0,#1
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_78: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r0
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_rr
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_79: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r1
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Er
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_7A: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r2
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Er
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	bx lr
	
_7B: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r3
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Er
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_7C: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r4
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Er
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_7D: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r5
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Rr
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_7E: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r6
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Rr
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_7F: //ADDC A,Rr
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r7
	ldrb r3,=#o2_c
	ldrb r0,[r1]//r0 = O2_A
	ldrb r4,[r2]//r4 = O2_Rr
	add r0,r0,r4//Add O2_Rr to O2_A
	ldrb r4,[r3]//r4 = O2_C
	add r0,r0,r4//Add O2_C to O2_A
	strb r0,[r1]//Save
	b increment_clk1
	bx lr
	
_85: //CLR F0
	ldr r1,=#o2_f0
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_88: //ORL BUS,#data
	b increment_clk2
	mov r0,#1
	b illegal
	bx lr
	
_95: //CPL F0
 	ldrb r1,=#o2_f0
	neg r0,r1
	strb r0,[r1]
	bx lr
	
_97: //CLR C
 	ldr r1,=#o2_cy
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr
	
_98: //ANL BUS,#data
	b increment_clk2
	mov r0,#1
	b illegal
	bx lr
	
_A5: //CLR F1
 	ldr r1,=#o2_f1
	ldrb r0,[r1]
	mov r0,#0
	strb r0,[r1]
	b increment_clk1
	bx lr

_A7: //CPL C
 	ldrb r1,=#o2_cy
	neg r0,r1
	strb r0,[r1]
	b increment_clk1
	bx lr

_B5: //CPL F1
 	ldrb r1,=#o2_f1
	neg r0,r1
	strb r0,[r1]
	bx lr
	
_C5: //SEL RB0
	
_C6: //JZ address
	
_C7: //MOV A,PSW 
	
_C8: //DEC r0
	ldrb r1,=#o2_r0
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_C9: //DEC r1
	ldrb r1,=#o2_r1
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr

_CA: //DEC r2
	ldrb r1,=#o2_r2
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_CB: //DEC r3
	ldrb r1,=#o2_r3
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr

_CC: //DEC r4
	ldrb r1,=#o2_r4
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_CD: //DEC r5
	ldrb r1,=#o2_r5
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_CE: //DEC r6
	ldrb r1,=#o2_r6
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_CF: //DEC r7
	ldrb r1,=#o2_r7
	ldrb r0,[r1]
	sub r0,r0,#1
	strb r0,[r1]
	bx lr
	
_F8: // MOV A,R0
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r0
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr
	
_F9: // MOV A,R1
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r1
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr	
	
_FA: // MOV A,R7
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r2
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr
	
_FB: // MOV A,R7
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r3
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr
	
_FC: // MOV A,R4
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r4
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr
	
_FD: // MOV A,R5
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r5
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr

_FE: // MOV A,R6
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r6
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr

_FF: // MOV A,R7
	ldrb r1,=#o2_a
	ldrb r2,=#o2_r7
	ldrb r0,[r1]
	mov r0,r2
	strb r0,[r1]
	ldr r3,=increment_clk1
	bx r3
	bx lr
	


op_table:
	.word _00,_01,_02,_03,_04,_05,_06,_07,_08,_09,_0A,_0B,_0C,_0D,_0E,_0F
	.word _10,_11,_12,_13,_14,_15,_16,_17,_18,_19,_1A,_1B,_1C,_1D,_1E,_1F
	.word _20,_21,_22,_23,_24,_25,_26,_27,_28,_29,_2A,_2B,_2C,_2D,_2E,_2F
	.word _30,_31,_32,_33,_34,_35,_36,_37,_38,_39,_3A,_3B,_3C,_3D,_3E,_3F
	.word _47
	.word _78,_79,_7A,_7B,_7C,_7D,_7E,_7F
	.word _88
	.word _97,_98
	.word _A5
	.word _C7,_C8,_C9,_CA,_CB,_CC,_CD,_CE,_CF
	.word _F8,_F9,_FA,_FB,_FC,_FD,_FE,_FF
