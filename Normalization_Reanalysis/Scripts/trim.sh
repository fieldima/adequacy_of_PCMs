#!/bin/bash
# arg1: number of threads
# to run: 
# chmod +x trim.sh
# <path>/trim.sh <number of threads>
# Example: ./trim.sh 40

for f in *_1.fastq # for each sample

do
    n=${f%%_1.fastq} # strip part of file name
    trimmomatic PE -threads $1 ${n}_1.fastq  ${n}_2.fastq \
    ${n}_1_trimmed.fastq ${n}_1_unpaired.fastq ${n}_2_trimmed.fastq \
    ${n}_2_unpaired.fastq ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

done
