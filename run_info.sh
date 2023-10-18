#!/bin/sh
#fasterq files are binary files and the directory had all paired fasterq files:
#SRR1165012_2.fasterq
#SRR1165013_1.fasterq
#SRR1165013_2.fasterq
#SRR1165014_1.fasterq
#Take just the first read and query SRA

#readarray -t my_array < < (ls -la | awk '{ print $9}' | grep "_1.fasterq")
list1=($(ls  *1.fasterq ))
mapfile list2 < <(ls fastq/*1.fasterq | awk  -F "_" '{ print $1}')
#declare -p list1
#printf "%s" "${list2[@]}"
#Look for metadata 
for i in "${list2[@]}"
do
	printf "%s\n" $i
	mapfile info_esearch < <(esearch  -db sra -query $i  | efetch -format runinfo)
	echo  ${info_esearch[@]}
done

