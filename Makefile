D1= -std=c99
D2= -felf64
#on va comparer entre:
#qst1.c et qst2.c/qst2.s
#PUIS: qst3.s/qst3_2.c et qst3.c (qst3_2.s deuxieme methode pour qst3.s)
#PUIS: qst4.c/qst4.s et qst3_2.s/qst4.c 
test1: comment1.sh qst1.c qst2.s qst2.c 
	./comment1.sh qst1.c qst2.s qst2.c qst2.o
test1_exec: test1
	cat file1.txt
test2: comment1.sh qst3.c qst3.s qst3_2.c
	./comment1.sh qst3.c qst3.s qst3_2.c qst3.o
test2_exec: test2
	cat file1.txt
test3: annexe.sh qst3_2.s qst4.c qst4.s
	./annexe.sh qst3_2.s qst4.c qst4.s qst4.s qst3_2.o qst4.o
test3_exec: test3
	cat file1.txt
clean:
	rm -f *.s~ *.c~ *.o *.sh~ Makefile~ version_c version_asm file1.txt version_asm_1 version_asm_2
