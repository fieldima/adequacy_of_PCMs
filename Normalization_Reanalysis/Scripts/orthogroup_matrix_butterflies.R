#Making Orthogroup matrix

library(tidyverse)

#Load Orthogroups
orthogroups_all <- read_tsv("Normalization_Reanalysis/Ortho_Assessment/Orthofinder/Orthogroups.tsv")
single_copy <- read_lines("Normalization_Reanalysis/Ortho_Assessment/Orthofinder/Orthogroups_SingleCopyOrthologues.txt") %>% as.data.frame() %>% rename(Orthogroup = ".")

#Filter orthogroups
orthogroups <- orthogroups_all %>% right_join(single_copy) %>%
  rename(HCH = HCH_heads_denovo.fasta.RSEM.transcripts, HDO = HDO_heads_denovo.fasta.RSEM.transcripts,
         HSA = HSA_heads_denovo.fasta.RSEM.transcripts, HER = Heliconius_erato_Trinity_assembly_Dryad.fasta.RSEM.transcripts, HME = Heliconius_melpomene_Trinity_assembly_Dryad.fasta.RSEM.transcripts)

path <- "Normalization_Reanalysis/Results/"
folders_lvl1 <- list.dirs("Normalization_Reanalysis/Results/", full.names = FALSE,recursive = FALSE)

data_all <- tibble(Sample = NA)
for(f in folders_lvl1){
  cwd <- paste0(path,f) #cwd for current working directory
  results <- list.dirs(cwd, full.names = FALSE, recursive = FALSE)
  for(r in results){
    print(r)
    tmp <- read.delim(paste0(cwd,"/",r, "/", "RSEM.isoforms.results")) %>% mutate(Sample = r, Species = f) %>% select(Species, Sample,"transcript_id", "TPM", "FPKM") %>% as_tibble()
    data_all <- data_all %>% full_join(tmp) %>% filter(!is.na(Sample))
  }
}

#Join orthogroups with data counts
ortho_longer <- orthogroups %>% pivot_longer(cols = !c(Orthogroup), names_to = "Species", values_to = "transcript_id")
ortho_join <- ortho_longer %>% left_join(data_all, by = c("Species", "transcript_id"))

#Finally, make matrices for use in Arbutus analysis
tpm_matrix <- ortho_join %>% select(Orthogroup, Sample, TPM) %>% pivot_wider(names_from = Sample, values_from = TPM) 
fpkm_matrix <- ortho_join %>% select(Orthogroup, Sample, FPKM) %>% pivot_wider(names_from = Sample, values_from = FPKM)

write_tsv(tpm_matrix, file = "Normalization_Reanalysis/Results/Matrices/TPM_data.tsv")
write_tsv(fpkm_matrix, file = "Normalization_Reanalysis/Results/Matrices/FPKM_data.tsv")
