; So, you decided to read this.
; Here’s why you shouldn’t have

	.section .data

	.global _03807668
_03807668:
	.word	0xFFFFFFFF

	.global _0380766C
_0380766C:
	.word	0x00000001

	.section .bss

	.global _038099A0
_038099A0: ;0x038099A0
	.space 0x038099A4 - 0x038099A0

	.global _038099A4
_038099A4: ;0x038099A4
	.space 0x038099A8 - 0x038099A4

	.global _038099A8
_038099A8: ;0x038099A8
	.space 0x038099AC - 0x038099A8

	.section .text

	arm_func_start FUN_03800E54
FUN_03800E54: ; 0x03800E54
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	mov	r0, #0
	bl	CTRDG_VibPulseEdgeUpdate
	bl	SND_BeginSleep
	bl	WVR_Shutdown
	bl	OS_Terminate
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr

	arm_func_start CARD_CheckPullOut_Polling
CARD_CheckPullOut_Polling: ; 0x03800E7C
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	ldr	r0, _03800F50	; =_038099A0
	ldr	r0, [r0]
	cmp	r0, #0
	bne	_03800F44
	ldr	r0, _03800F54	; =0x027FFC40
	ldrh	r0, [r0]
	cmp	r0, #2
	beq	_03800F44
	ldr	r1, _03800F58	; =_03807668
	ldr	r3, [r1]
	mvn	r0, #0
	cmp	r3, r0
	ldreq	r0, _03800F5C	; =0x027FFC3C
	ldreq	r0, [r0]
	addeq	r0, r0, #10
	streq	r0, [r1]
	beq	_03800F44
	ldr	r2, _03800F5C	; =0x027FFC3C
	ldr	r0, [r2]
	cmp	r0, r3
	bcc	_03800F44
	ldr	r0, [r2]
	add	r0, r0, #10
	str	r0, [r1]
	bl	CARD_IsPulledOut
	cmp	r0, #0
	beq	_03800F1C
	mov	r1, #1
	ldr	r0, _03800F50	; =_038099A0
	str	r1, [r0]
	bl	CARD_GetRomHeader
	ldr	r0, [r0, #12]
	cmp	r0, #0
	bne	_03800F1C
	ldr	r0, _03800F60	; =_0380766C
	ldr	r0, [r0]
	cmp	r0, #0
	bne	_03800F44
_03800F1C:
	mov	r1, #0
	ldr	r0, _03800F60	; =_0380766C
	str	r1, [r0]
	ldr	r0, _03800F50	; =_038099A0
	ldr	r0, [r0]
	cmp	r0, #0
	beq	_03800F44
	mov	r0, #17
	mov	r1, #100	; 0x64
	bl	FUN_03800E0C
_03800F44:
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr
_03800F50:	.word	_038099A0
_03800F54:	.word	0x027FFC40
_03800F58:	.word	_03807668
_03800F5C:	.word	0x027FFC3C
_03800F60:	.word	_0380766C

	arm_func_start CARD_IsCardIreqLo
CARD_IsCardIreqLo: ; 0x03800F64
	mov	r2, #1
	mov	r0, r2
	ldr	r1, _03800F88	; =0x04000214
	ldr	r1, [r1]
	ands	r1, r1, #1048576	; 0x100000
	movne	r0, #0
	ldrne	r1, _03800F8C	; =_038099A8
	strne	r2, [r1]
	bx	lr
_03800F88:	.word	0x04000214
_03800F8C:	.word	_038099A8

	arm_func_start CARD_CompareCardID
CARD_CompareCardID: ; 0x03800F90
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	ldr	r0, _03800FE8	; =0x027FFC10
	ldrh	r0, [r0]
	cmp	r0, #0
	ldreq	r0, _03800FEC	; =0x027FF800
	ldrne	r0, _03800FF0	; =0x027FFC00
	ldr	r0, [r0]
	str	r0, [sp]
	bl	CARDi_ReadRomID
	ldr	r1, [sp]
	cmp	r0, r1
	moveq	r0, #1
	movne	r0, #0
	cmp	r0, #0
	moveq	r2, #1
	movne	r2, #0
	ldr	r1, _03800FF4	; =_038099A8
	str	r2, [r1]
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr
_03800FE8:	.word	0x027FFC10
_03800FEC:	.word	0x027FF800
_03800FF0:	.word	0x027FFC00
_03800FF4:	.word	_038099A8

	arm_func_start CARD_IsPulledOut
CARD_IsPulledOut: ; 0x03800FF8
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	ldr	r0, _03801040	; =_038099A8
	ldr	r0, [r0]
	cmp	r0, #0
	bne	_0380102C
	ldr	r0, _03801044	; =0x027FFC1F
	ldrb	r0, [r0]
	ands	r0, r0, #1
	beq	_03801028
	bl	CARD_CompareCardID
	b	_0380102C
_03801028:
	bl	CARD_IsCardIreqLo
_0380102C:
	ldr	r0, _03801040	; =_038099A8
	ldr	r0, [r0]
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr
_03801040:	.word	_038099A8
_03801044:	.word	0x027FFC1F

	arm_func_start FUN_03801048
FUN_03801048: ; 0x03801048
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	and	r0, r1, #63	; 0x3f
	cmp	r0, #1
	bne	_03801064
	bl	FUN_03800E54
	b	_03801068
_03801064:
	bl	OS_Terminate
_03801068:
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr

	arm_func_start CARD_InitPulledOutCallback
CARD_InitPulledOutCallback: ; 0x03801074
	stmdb	sp!, {r4, r5, lr}
	sub	sp, sp, #4
	ldr	r0, _038010CC	; =_038099A4
	ldr	r1, [r0]
	cmp	r1, #0
	bne	_038010C0
	mov	r1, #1
	str	r1, [r0]
	bl	PXI_Init
	mov	r5, #14
	mov	r4, #0
_038010A0:
	mov	r0, r5
	mov	r1, r4
	bl	PXI_IsCallbackReady
	cmp	r0, #0
	beq	_038010A0
	mov	r0, #14
	ldr	r1, _038010D0	; =FUN_03801048
	bl	PXI_SetFifoRecvCallback
_038010C0:
	add	sp, sp, #4
	ldmia	sp!, {r4, r5, lr}
	bx	lr
_038010CC:	.word	_038099A4
_038010D0:	.word	FUN_03801048

;;

	.section .bss

	.global _03807958
_03807958: ;0x03807958
	.space 0x0380795C - 0x03807958

	.global _0380795C
_0380795C: ;0x0380795C
	.space 0x038079DC - 0x0380795C

	.section .text

	arm_func_start PXIi_HandlerRecvFifoNotEmpty
PXIi_HandlerRecvFifoNotEmpty: ; 0x037FB5BC
	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	sub	sp, sp, #8
	ldr	sl, _037FB6D0	; =0x04000184
	ldr	r5, _037FB6D4	; =_0380795C
	mov	r7, #68157440	; 0x4100000
	mov	r6, #0
	mvn	r8, #3
	mvn	r9, #2
	ldr	r4, _037FB6D8	; =0x04000188
_037FB5E0:
	ldrh	r0, [sl]
	ands	r0, r0, #16384	; 0x4000
	ldrneh	r0, [sl]
	orrne	r0, r0, #49152	; 0xc000
	strneh	r0, [sl]
	movne	r1, r9
	bne	_037FB628
	bl	OS_DisableInterrupts
	ldrh	r1, [sl]
	ands	r1, r1, #256	; 0x100
	beq	_037FB618
	bl	OS_RestoreInterrupts
	mov	r1, r8
	b	_037FB628
_037FB618:
	ldr	r1, [r7]
	str	r1, [sp]
	bl	OS_RestoreInterrupts
	mov	r1, r6
_037FB628:
	cmp	r1, r8
	beq	_037FB6C4
	mvn	r0, #2
	cmp	r1, r0
	beq	_037FB5E0
	ldr	r2, [sp]
	mov	r0, r2, lsl #27
	movs	r0, r0, lsr #27
	beq	_037FB5E0
	ldr	r3, [r5, r0, lsl #2]
	cmp	r3, #0
	beq	_037FB670
	mov	r1, r2, lsr #6
	mov	r2, r2, lsl #26
	mov	r2, r2, lsr #31
	mov	lr, pc
	bx	r3
	b	_037FB5E0
_037FB670:
	mov	r0, r2, lsl #26
	movs	r0, r0, lsr #31
	bne	_037FB5E0
	orr	r0, r2, #32
	str	r0, [sp]
	ldrh	r0, [sl]
	ands	r0, r0, #16384	; 0x4000
	ldrneh	r0, [sl]
	orrne	r0, r0, #49152	; 0xc000
	strneh	r0, [sl]
	bne	_037FB5E0
	bl	OS_DisableInterrupts
	ldrh	r1, [sl]
	ands	r1, r1, #2
	beq	_037FB6B4
	bl	OS_RestoreInterrupts
	b	_037FB5E0
_037FB6B4:
	ldr	r1, [sp]
	str	r1, [r4]
	bl	OS_RestoreInterrupts
	b	_037FB5E0
_037FB6C4:
	add	sp, sp, #8
	ldmia	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	bx	lr
_037FB6D0:	.word	0x04000184
_037FB6D4:	.word	_0380795C
_037FB6D8:	.word	0x04000188

	arm_func_start PXI_SendWordByFifo
PXI_SendWordByFifo: ; 0x037FB6DC
	stmfd	sp!, {lr}
	sub	sp, sp, #4
	ldr	r3, [sp]
	bic	r3, r3, #31
	and	r0, r0, #31
	orr	r0, r3, r0
	str	r0, [sp]
	bic	r3, r0, #32
	and	r0, r2, #1
	orr	r0, r3, r0, lsl #5
	str	r0, [sp]
	and	r2, r0, #63	; 0x3f
	bic	r0, r1, #-67108864	; 0xfc000000
	orr	r0, r2, r0, lsl #6
	str	r0, [sp]
	ldr	r1, _037FB778	; =0x04000184
	ldrh	r0, [r1]
	ands	r0, r0, #16384	; 0x4000
	ldrneh	r0, [r1]
	orrne	r0, r0, #49152	; 0xc000
	strneh	r0, [r1]
	mvnne	r0, #0
	bne	_037FB76C
	bl	OS_DisableInterrupts
	ldr	r1, _037FB778	; =0x04000184
	ldrh	r1, [r1]
	ands	r1, r1, #2
	beq	_037FB758
	bl	OS_RestoreInterrupts
	mvn	r0, #1
	b	_037FB76C
_037FB758:
	ldr	r2, [sp]
	ldr	r1, _037FB77C	; =0x04000188
	str	r2, [r1]
	bl	OS_RestoreInterrupts
	mov	r0, #0
_037FB76C:
	add	sp, sp, #4
	ldmia	sp!, {lr}
	bx	lr
_037FB778:	.word	0x04000184
_037FB77C:	.word	0x04000188

	arm_func_start PXI_IsCallbackReady
PXI_IsCallbackReady: ; 0x037FB780
	mov	r3, #1
	mov	r2, r3, lsl r0
	ldr	r0, _037FB7A4	; =0x027FFC00
	add	r0, r0, r1, lsl #2
	ldr	r0, [r0, #904]	; 0x388
	ands	r0, r2, r0
	moveq	r3, #0
	mov	r0, r3
	bx	lr
_037FB7A4:	.word	0x027FFC00

	arm_func_start PXI_SetFifoRecvCallback
PXI_SetFifoRecvCallback: ; 0x037FB7A8
	stmdb	sp!, {r4, r5, lr}
	sub	sp, sp, #4
	mov	r4, r0
	mov	r5, r1
	bl	OS_DisableInterrupts
	ldr	r1, _037FB80C	; =_0380795C
	str	r5, [r1, r4, lsl #2]
	cmp	r5, #0
	beq	_037FB7E4
	ldr	r3, _037FB810	; =0x027FFC00
	ldr	r2, [r3, #908]	; 0x38c
	mov	r1, #1
	orr	r1, r2, r1, lsl r4
	str	r1, [r3, #908]	; 0x38c
	b	_037FB7FC
_037FB7E4:
	ldr	r3, _037FB810	; =0x027FFC00
	ldr	r2, [r3, #908]	; 0x38c
	mov	r1, #1
	mvn	r1, r1, lsl r4
	and	r1, r2, r1
	str	r1, [r3, #908]	; 0x38c
_037FB7FC:
	bl	OS_RestoreInterrupts
	add	sp, sp, #4
	ldmia	sp!, {r4, r5, lr}
	bx	lr
_037FB80C:	.word	_0380795C
_037FB810:	.word	0x027FFC00

	arm_func_start PXI_InitFifo
PXI_InitFifo: ; 0x037FB814
	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
	bl	OS_DisableInterrupts
	mov	r5, r0
	ldr	r0, _037FB8D4	; =_03807958
	ldrh	r1, [r0]
	cmp	r1, #0
	bne	_037FB8C4
	mov	r1, #1
	strh	r1, [r0]
	mov	r2, #0
	ldr	r0, _037FB8D8	; =0x027FFC00
	str	r2, [r0, #908]	; 0x38c
	mov	r1, r2
	ldr	r0, _037FB8DC	; =_0380795C
_037FB84C:
	str	r1, [r0, r2, lsl #2]
	add	r2, r2, #1
	cmp	r2, #32
	blt	_037FB84C
	ldr	r1, _037FB8E0	; =0x0000C408
	ldr	r0, _037FB8E4	; =0x04000184
	strh	r1, [r0]
	mov	r0, #262144	; 0x40000
	bl	OS_ResetRequestIrqMask
	mov	r0, #262144	; 0x40000
	ldr	r1, _037FB8E8	; =PXIi_HandlerRecvFifoNotEmpty
	bl	OS_SetIrqFunction
	mov	r0, #262144	; 0x40000
	bl	OS_EnableIrqMask
	mov	r4, #8
	mov	r6, r4
	ldr	r8, _037FB8EC	; =0x04000180
	mov	r7, #1000	; 0x3e8
	b	_037FB8BC
_037FB898:
	mov	r0, r4, lsl #8
	strh	r0, [r8]
	mov	r0, r7
	bl	OS_SpinWait
	ldrh	r0, [r8]
	and	r0, r0, #15
	cmp	r0, r4
	movne	r4, r6
	sub	r4, r4, #1
_037FB8BC:
	cmp	r4, #0
	bge	_037FB898
_037FB8C4:
	mov	r0, r5
	bl	OS_RestoreInterrupts
	ldmia	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
_037FB8D4:	.word	_03807958
_037FB8D8:	.word	0x027FFC00
_037FB8DC:	.word	_0380795C
_037FB8E0:	.word	0x0000C408
_037FB8E4:	.word	0x04000184
_037FB8E8:	.word	PXIi_HandlerRecvFifoNotEmpty
_037FB8EC:	.word	0x04000180
