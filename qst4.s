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
	vrsqrtps ymm5,ymm5
	vfmadd213ps ymm5,ymm1,ymm2
	vmovups [rdi],ymm5
	add rdi,32
	add rsi,32
	dec r9
	jnz traitement
ret
