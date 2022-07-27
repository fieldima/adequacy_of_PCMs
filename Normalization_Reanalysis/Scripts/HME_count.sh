#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"

echo "Running HME alignments..."

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_melpomene_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HME/ERR2228593_1.fastq --right $DIR/Sequences/HME/ERR2228593_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HME/HME_F_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_melpomene_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HME/ERR2228594_1.fastq --right $DIR/Sequences/HME/ERR2228594_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HME/HME_F_2

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_melpomene_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HME/ERR2228595_1.fastq --right $DIR/Sequences/HME/ERR2228595_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HME/HME_M_1

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_melpomene_Trinity_assembly_Dryad.fasta --seqType fq --left $DIR/Sequences/HME/ERR2228596_1.fastq --right $DIR/Sequences/HME/ERR2228596_2.fastq --est_method RSEM --aln_method bowtie --trinity_mode --output_dir $DIR/Results/HME/HME_M_2


echo "Finished"
