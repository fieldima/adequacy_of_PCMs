#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"

echo "Running HDO alignments..."

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587233_1.fastq --right $DIR/Sequences/HDO/ERR2587233_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587234_1.fastq --right $DIR/Sequences/HDO/ERR2587234_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587235_1.fastq --right $DIR/Sequences/HDO/ERR2587235_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587236_1.fastq --right $DIR/Sequences/HDO/ERR2587236_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587237_1.fastq --right $DIR/Sequences/HDO/ERR2587237_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587238_1.fastq --right $DIR/Sequences/HDO/ERR2587238_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_F_6

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587239_1.fastq --right $DIR/Sequences/HDO/ERR2587239_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587240_1.fastq --right $DIR/Sequences/HDO/ERR2587240_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587241_1.fastq --right $DIR/Sequences/HDO/ERR2587241_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587242_1.fastq --right $DIR/Sequences/HDO/ERR2587242_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587243_1.fastq --right $DIR/Sequences/HDO/ERR2587243_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HDO/ERR2587244_1.fastq --right $DIR/Sequences/HDO/ERR2587244_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HDO/HDO_M_6

echo "Finished"
