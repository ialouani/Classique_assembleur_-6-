#!/bin/bash
F1="-std=c99"
F2="-felf64"
yasm $F2 $1
yasm $F2 $3
gcc $F1 $5 $2 -o version_asm_1
gcc $F1 $6 $2 -o version_asm_2
touch file1.txt
(time ./version_asm_1) > file1.txt 2>&1
while read part
do
    echo $part>file2.txt
    grep 'real' file2.txt > file3.txt
    retvalue=$?
    if [ "$retvalue" -eq 0 ];then
	#echo $part
	export line1=$part
    fi
    rm file2.txt
    rm file3.txt
done<file1.txt
(time ./version_asm_2) > file1.txt 2>&1
while read part
do
    echo $part>file2.txt
    grep 'real' file2.txt > file3.txt
    retvalue=$?
    if [ "$retvalue" -eq 0 ];then
	#echo $part
	export line2=$part
    fi
    rm file2.txt
    rm file3.txt
done<file1.txt
echo $line1>file1.txt
echo $line2>>file1.txt



