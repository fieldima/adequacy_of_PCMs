#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"

echo "Running HCH alignments..."

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587221_1.fastq --right $DIR/Sequences/HCH/ERR2587221_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587222_1.fastq --right $DIR/Sequences/HCH/ERR2587222_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587223_1.fastq --right $DIR/Sequences/HCH/ERR2587223_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587224_1.fastq --right $DIR/Sequences/HCH/ERR2587224_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587225_1.fastq --right $DIR/Sequences/HCH/ERR2587225_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587226_1.fastq --right $DIR/Sequences/HCH/ERR2587226_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587227_1.fastq --right $DIR/Sequences/HCH/ERR2587227_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_M_6

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587228_1.fastq --right $DIR/Sequences/HCH/ERR2587228_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587229_1.fastq --right $DIR/Sequences/HCH/ERR2587229_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587230_1.fastq --right $DIR/Sequences/HCH/ERR2587230_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587231_1.fastq --right $DIR/Sequences/HCH/ERR2587231_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HCH/ERR2587232_1.fastq --right $DIR/Sequences/HCH/ERR2587232_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HCH/HCH_F_6

echo "Finished"
