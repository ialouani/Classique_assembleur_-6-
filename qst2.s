	section .text
	global calcul
calcul:
		;rdi est A et rsi est B
	mov r8,C		;r8 recoit l'adresse du tableau C(voir bas)
	vmovups ymm0,[r8]	;ymm0 recoit ici tout le tableau d'un coup
	;on parle de valeurs ici.
	mov r9,0
traitement:	
        vmovups ymm1,[rdi]		;ymm1 recoit de la meme maniere
		;les 8 premiers elements du tableau A pour avoir 8*32=256 bits
			;du coup ymm1 contient les 8 premiers elements de A
	vmovups ymm2,[rsi]			;pour B.
	vmovups ymm3,[rsi]
	vmulps ymm2,ymm2,ymm2			;ymm2->:B[i]*B[i]
				;ymm2=B[i]**2 pour 0<=i<8
	vmulps ymm2,ymm2,ymm3	;ymm2=B[i]**2(ymm2_ancienne) * B[i](ymm3
				;(sauvegarde de B au debut))
				;ymm2=B[i]^3 pour 0<=i<8.
	vmulps ymm1,ymm1,ymm1	;ymm1=A[i]**2
	vmulps ymm1,ymm1,ymm0	;ymm1=A[i]**2 * 2.5
	vaddps ymm1,ymm1,ymm2	;ymm1=A[i]^2*2.5+B[i]**3(ymm2)
	;calcul correct pour les 8 premiers elements consecutives de A et B.	      ;100e6 est un multiple de 8 donc ca va au niveau de ...
;reste a modifier les valeurs des 8 elements de A en remplacant
;par la nouvelle valeur (issue de ymm1)
        vmovups [rdi],ymm1	;mettra 256/32=8 elements a jour.			;il faudrait refaire le meme processus pour les 8 prochains elements
	;ca va se traduire par +32 au niveau de rsi,rdi.
        add rdi,32
	add rsi,32
	inc r9
	cmp r9,12500000
	je traitement
ret
	section .data
C: dd 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5, 2.5
	;C est un tableau de flottants (32 bits) contenant 8 elements ici
	;donc sa taille sera de 8*32=2^3*2^5=2^8=256 bits.
