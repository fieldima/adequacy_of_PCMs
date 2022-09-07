library(tidyverse)
library(phylotools)

#This script's purpose is to slim down the total number of reads in the All-vs-All BLAST to hasten the process.
#The goal is to only use reads with values of greater than 0 and that are all shared between runs of each species.

to_load <- list.files(path = "Normalization_Reanalysis/Slimmed_Results/raw/")

#First filter by number of zeroes, only transcripts with some expression level get used

slim <- function(name){
  path <- paste0("Normalization_Reanalysis/Slimmed_Results/raw/", name)
  results <- read.delim(path)
  slim_results <- results %>% filter(FPKM > 0, TPM > 0)
  diff <- nrow(results) - nrow(slim_results)
  message <- paste0("Slimmed results by ", diff)
  print(message)
  final_name <- paste0("Normalization_Reanalysis/Slimmed_Results/slimmed/", name, ".slimmed")
  write_tsv(x = slim_results, file = final_name)
}

map(.x = to_load, .f = slim)

#Second, filter so that only transcripts seen in all get used
reading <- function(name){
  path <- paste0("Normalization_Reanalysis/Slimmed_Results/slimmed/", name)
  tsv <- read_tsv(path)
  tsv[1]
}


species <- c("HME", "HDO", "HSA", "HCH", "HER")
final_transcripts <- vector(mode = "character")

for(s in species){
  pat <- paste0("^", s)
  tmp <- list.files("Normalization_Reanalysis/Slimmed_Results/slimmed/", pattern = pat)
  tscripts <- map(.x = tmp, reading) %>%
    reduce(inner_join) %>%
    pull("transcript_id")
  print(s)
  final_transcripts <- c(final_transcripts, tscripts)
}

#Filtering Allseqs with list of transcripts matching the requirements and making new faa file
allseqs <- read.fasta("Normalization_Reanalysis/Ortho_Assessment/intermediates/AllSeqs.faa")

allseqs_filtered <- allseqs %>%
  mutate(seq.name2 = seq.name) %>%
  separate(seq.name2, into = c("species", "num", "id"), "\\|") %>%
  filter(id %in% final_transcripts) %>%
  select(seq.name, seq.text)

#dat2fasta(allseqs_filtered, "Normalization_Reanalysis/Ortho_Assessment/intermediates/AllSeqsFiltered.faa")

#Now I need to lower the database size even more. Lets take one random sequence out of every four per species. This doesn't maximize sequence numbers for a 7 day sequence, but does give me some room for error.
set.seed(42069)
allseqs_cut <- allseqs_filtered %>%
  mutate(seq.name2 = seq.name) %>%
  separate(seq.name2, into = c("species", "num", "id"), "\\|") %>%
  group_by(species) %>%
  slice_sample(prop = 0.25, replace = TRUE) %>%
  ungroup() %>%
  select(seq.name, seq.text)

dat2fasta(allseqs_cut, "Normalization_Reanalysis/Ortho_Assessment/intermediates/AllSeqsFinal.faa")
