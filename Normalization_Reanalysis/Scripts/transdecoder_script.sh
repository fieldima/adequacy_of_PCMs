#!/bin/bash

echo Starting TransDecoder
cd /home/fieldima/temp/TransDecoder

TransDecoder.LongOrfs -t HCH_heads_denovo.fasta
wait
TransDecoder.Predict -t HCH_heads_denovo.fasta

TransDecoder.LongOrfs -t HDO_heads_denovo.fasta
wait
TransDecoder.Predict -t HDO_heads_denovo.fasta

TransDecoder.LongOrfs -t Heliconius_erato_Trinity_assembly_Dryad.fasta
wait
TransDecoder.Predict -t Heliconius_erato_Trinity_assembly_Dryad.fasta

TransDecoder.LongOrfs -t HSA_heads_denovo.fasta
wait
TransDecoder.Predict -t HSA_heads_denovo.fasta

TransDecoder.LongOrfs -t Heliconius_melpomene_Trinity_assembly_Dryad.fasta
wait
TransDecoder.Predict -t Heliconius_melpomene_Trinity_assembly_Dryad.fasta

wait

echo All done!
