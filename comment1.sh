#!/bin/bash
yasm -felf64 $2
gcc -std=c99 $4 $3 -static -o version_asm 
gcc -std=c99 $1 -o version_c -lm
touch file1.txt
(time ./version_c) > file1.txt 2>&1
while read part
do
    echo $part > file2.txt
    grep 'real' file2.txt > file3.txt
    retvalue=$?
    if [ "$retvalue" -eq 0  ];then
        #echo $part
	export line=$part
    fi
    rm file2.txt
    rm file3.txt
done<file1.txt
echo $line>file1.txt
(time ./version_asm) > file4.txt 2>&1
while read part
do
    echo $part > file5.txt
    grep 'real' file5.txt > file6.txt
    retvalue=$?
    if [ "$retvalue" -eq 0 ];then
	#echo $part"
	export line2=$part
    fi
    rm file5.txt
    rm file6.txt
done<file4.txt
rm file4.txt
echo $line2 >> file1.txt
