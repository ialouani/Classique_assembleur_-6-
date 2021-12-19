	section .text
	global calcul
calcul:
	mov r9,0
traitement:
	vmovups ymm1,[rdi]
	vmovups ymm2,[rsi]
	;copiage des 256/32=8 elements de chacun des 2 tabs rdi,rsi.
	vmovups ymm3,[rdi]	;sauvegarde d'une copie de rdi.
	vmovups ymm4,[rsi]	;de meme (pour l'addition derniere)
	vmulps ymm1,ymm1,ymm1
	vmulps ymm2,ymm2,ymm2
	vaddps ymm1,ymm1,ymm2
	vsqrtps ymm1,ymm1
	vdivps ymm3,ymm3,ymm1
	vaddps ymm3,ymm3,ymm4
	vmovups [rdi],ymm3	;modification des 256/32=2^3=8 elements
				;du tableau A.
	add rdi,32		;+4*8'8 fois<=>8 elements'=>32 (4 octets float)
	add rsi,32
	inc r9
	cmp r9,12500000
	jne traitement
ret
