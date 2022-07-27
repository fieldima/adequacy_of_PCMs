#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"

echo "Running HER alignments..."

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587245_1.fastq --right $DIR/Sequences/HER/ERR2587245_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_F_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587246_1.fastq --right $DIR/Sequences/HER/ERR2587246_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_F_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587247_1.fastq --right $DIR/Sequences/HER/ERR2587247_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_F_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587248_1.fastq --right $DIR/Sequences/HER/ERR2587248_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_M_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587249_1.fastq --right $DIR/Sequences/HER/ERR2587249_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_M_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HER/ERR2587250_1.fastq --right $DIR/Sequences/HER/ERR2587250_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HER/HER_M_3

echo "Finished"
