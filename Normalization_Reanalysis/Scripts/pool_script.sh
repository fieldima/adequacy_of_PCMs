#!/bin/bash

cd /home/fieldima/local_hard_drive/RNA-Seq/crayfish/
echo Starting to pool!
cat SRR7124948_1_trimmed.fastq > CCRYP_left.fastq
cat SRR7124947_1_trimmed.fastq SRR7124949_1_trimmed.fastq SRR7124950_1_trimmed.fastq > CDUBI_left.fastq
cat SRR7124953_1_trimmed.fastq SRR7124954_1_trimmed.fastq SRR7124956_1_trimmed.fastq > CGRAY_left.fastq
cat SRR7124927_1_trimmed.fastq SRR7124928_1_trimmed.fastq SRR7124934_1_trimmed.fastq > CHAMU_left.fastq
cat SRR7124941_1_trimmed.fastq SRR7124942_1_trimmed.fastq SRR7124944_1_trimmed.fastq > CNERT_left.fastq
cat SRR7124951_1_trimmed.fastq SRR7124952_1_trimmed.fastq > CRUST_left.fastq
cat SRR7124935_1_trimmed.fastq SRR7124936_1_trimmed.fastq SRR7124955_1_trimmed.fastq > CSETO_left.fastq
cat SRR7124931_1_trimmed.fastq SRR7124932_1_trimmed.fastq SRR7124933_1_trimmed.fastq > CTENE_left.fastq
cat SRR7124939_1_trimmed.fastq SRR7124945_1_trimmed.fastq SRR7124946_1_trimmed.fastq > OAUST_left.fastq
cat SRR7124929_1_trimmed.fastq SRR7124930_1_trimmed.fastq > OINCO_left.fastq
cat SRR7124937_1_trimmed.fastq SRR7124938_1_trimmed.fastq SRR7124943_1_trimmed.fastq > PFALL_left.fastq
cat SRR7124925_1_trimmed.fastq SRR7124926_1_trimmed.fastq > PHORS_left.fastq
cat SRR7124940_1_trimmed.fastq SRR7124923_1_trimmed.fastq > PLUCI_left.fastq
cat SRR7124922_1_trimmed.fastq > PPALL_left.fastq
cat SRR7124948_2_trimmed.fastq > CCRYP_right.fastq
cat SRR7124947_2_trimmed.fastq SRR7124949_2_trimmed.fastq SRR7124950_2_trimmed.fastq > CDUBI_right.fastq
cat SRR7124953_2_trimmed.fastq SRR7124954_2_trimmed.fastq SRR7124956_2_trimmed.fastq > CGRAY_right.fastq
cat SRR7124927_2_trimmed.fastq SRR7124928_2_trimmed.fastq SRR7124934_2_trimmed.fastq > CHAMU_right.fastq
cat SRR7124941_2_trimmed.fastq SRR7124942_2_trimmed.fastq SRR7124944_2_trimmed.fastq > CNERT_right.fastq
cat SRR7124951_2_trimmed.fastq SRR7124952_2_trimmed.fastq > CRUST_right.fastq
cat SRR7124935_2_trimmed.fastq SRR7124936_2_trimmed.fastq SRR7124955_2_trimmed.fastq > CSETO_right.fastq
cat SRR7124931_2_trimmed.fastq SRR7124932_2_trimmed.fastq SRR7124933_2_trimmed.fastq > CTENE_right.fastq
cat SRR7124939_2_trimmed.fastq SRR7124945_2_trimmed.fastq SRR7124946_2_trimmed.fastq > OAUST_right.fastq
cat SRR7124929_2_trimmed.fastq SRR7124930_2_trimmed.fastq > OINCO_right.fastq
cat SRR7124937_2_trimmed.fastq SRR7124938_2_trimmed.fastq SRR7124943_2_trimmed.fastq > PFALL_right.fastq
cat SRR7124925_2_trimmed.fastq SRR7124926_2_trimmed.fastq > PHORS_right.fastq
cat SRR7124940_2_trimmed.fastq SRR7124923_2_trimmed.fastq > PLUCI_right.fastq
cat SRR7124922_2_trimmed.fastq > PPALL_right.fastq

echo All Done!


