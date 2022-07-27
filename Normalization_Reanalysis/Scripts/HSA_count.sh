#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"

echo "Running HSA alignments..."

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587251_1.fastq --right $DIR/Sequences/HSA/ERR2587251_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_F_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587252_1.fastq --right $DIR/Sequences/HSA/ERR2587252_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_F_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587253_1.fastq --right $DIR/Sequences/HSA/ERR2587253_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_F_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587254_1.fastq --right $DIR/Sequences/HSA/ERR2587254_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_F_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587255_1.fastq --right $DIR/Sequences/HSA/ERR2587255_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_F_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587256_1.fastq --right $DIR/Sequences/HSA/ERR2587256_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587257_1.fastq --right $DIR/Sequences/HSA/ERR2587257_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587258_1.fastq --right $DIR/Sequences/HSA/ERR2587258_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_3

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587259_1.fastq --right $DIR/Sequences/HSA/ERR2587259_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_4

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587260_1.fastq --right $DIR/Sequences/HSA/ERR2587260_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_5

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --seqType fq --left $DIR/Sequences/HSA/ERR2587261_1.fastq --right $DIR/Sequences/HSA/ERR2587261_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HSA/HSA_M_6

echo "Finished"
