	section .text
	global calcul
calcul:
	mov r9,12500000
traitement:
	vmovups ymm1,[rdi]
	vmovups ymm2,[rsi]
	vmulps ymm3,ymm1,ymm1
	vmulps ymm4,ymm2,ymm2
	vaddps ymm5,ymm3,ymm4
	vsqrtps ymm5,ymm5
	vdivps ymm6,ymm1,ymm5
	vaddps ymm7,ymm6,ymm2
	vmovups [rdi],ymm7
	add rdi,32
	add rsi,32
	dec r9
	jnz traitement
ret
