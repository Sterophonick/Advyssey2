.macro clock x
	ldr r1,=o2_clk
	mov r0,#\x
	str r0,[r1]
.endm

.macro opJMP x
//ROM(pc)
	ldrh r5,=#\x
	ldrh r1,[r0]
	ldr r0,=o2_pc
	ldrh r0,[r0]
	push {lr}
	bl ROM
	pop {lr}
//pc=ROM(pc) | r0 | o2_a11
	ldr r3,=o2_a11
	ldrh r2,[r3]
	orr r4,r1,r5
	orr r4,r4,r3
	ldr r0,=o2_pc
	strh r4,[r0]
.endm

.macro opDEC8 reg
	ldr r0,=\reg
	ldrb r1,[r0]
	sub r1,#1
	strb r1,[r0]
.endm

.macro opINCM8 reg
	ldr r0,=memory
	mov r1,\reg
	ldrb r1,[r1]
	and r1,#0x3F
.endm

.macro opINC8 reg
	mov r0,\reg
	ldrb r1,[r0]
	add r1,#1
	and r1,#0xFF
	strb r1,[r0]
.endm

.macro opXCH x
	ldr r1,=o2_dat
	ldr r2,=o2_acc
	ldrb r3,[r2]
	strb r3,[r1]
	
	//a = o2_rX;
	ldr r1,=o2_acc
	ldrb r2,[\x]
	strb r2,[r1]
	
	//o2_rX = o2_dat
	ldr r1,=o2_dat
	ldrb r2,[r1]
	strb r2,[\x]
.endm

.macro opCLR8 reg
	mov r1,#0
	strb r1,[\reg]
.endm

.macro opSWAP8 reg
	push {r0}
	ldrb  r0,[\reg]
	push {ip, lr}
	bl hrt_SwapNibbles
	pop {lr}
	mov r1,r0
	pop {r0}
	strb r1,[r0]
.endm

.macro opMOV8 reg1,reg2
	ldr r0,=\reg1
	ldr r1,=\reg2
	ldrb r1,[r1]
	strb r1,[r0]
.endm
