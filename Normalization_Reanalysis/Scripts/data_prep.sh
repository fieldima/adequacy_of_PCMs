#/bin/bash

SCRIPT="/home/fieldima/miniconda3/pkgs/trinity-2.1.1-6/opt/trinity-2.1.1/util/align_and_estimate_abundance.pl"
DIR="/home/fieldima/temp"


echo "Prepping and aligning reference transcriptomes"

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HCH_heads_denovo.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HDO_heads_denovo.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/HSA_heads_denovo.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_erato_Trinity_assembly_Dryad.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference

$SCRIPT --transcripts $DIR/Reference_Transcriptomes/Heliconius_melpomene_Trinity_assembly_Dryad.fasta --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference

echo "Preparation complete"
