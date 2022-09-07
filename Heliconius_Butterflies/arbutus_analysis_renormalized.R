#Arbutus Analysis

library(geiger)
library(arbutus)
library(tidyverse)
library(flipR)
library(parallel)

#Load the data
tr <- read.nexus("Heliconius_Butterflies/Data/Heliconiini.multiple_uniform_constraints.MCC.tree")
plot(tr)

tree <- keep.tip(tr, c("Heliconius_charithonia_8830_P", "Heliconius_sara_8862_P",
                       "Heliconius_erato_erato_NCS2556_FG", "Heliconius_doris_02_1939_Pe",
                       "Heliconius_melpomene_melpomene_9317_FG"))
#Rename tips
tree$tip.label <- c("Heliconius_charithonia", "Heliconius_doris", "Heliconius_erato",
                    "Heliconius_melpomene", "Heliconius_sara")

plot(tree)

fpkm_matrix <- read_tsv("Normalization_Reanalysis/Results/Matrices/FPKM_data.tsv") 
tpm_matrix <- read_tsv("Normalization_Reanalysis/Results/Matrices/TPM_data.tsv") 

#Split into sexes
female_dat_fpkm <- fpkm_matrix %>% as.data.frame() %>% select(Orthogroup, contains("_F"))
male_dat_fpkm <- fpkm_matrix%>% as.data.frame() %>% select(Orthogroup, contains("_M"))

female_dat_tpm <- tpm_matrix %>% as.data.frame() %>% select(Orthogroup, contains("_F"))
male_dat_tpm <- tpm_matrix%>% as.data.frame() %>% select(Orthogroup, contains("_M"))

#Take averages for each species by sex
female_avg_dat_fpkm <- female_dat_fpkm %>% group_by(Orthogroup) %>%
  transmute("Heliconius_charithonia" = mean(HCH_F_1, HCH_F_2, HCH_F_3, HCH_F_4, HCH_F_5),
            "Heliconius_doris" = mean(HDO_F_1, HDO_F_2, HDO_F_3, HDO_F_4, HDO_F_5, HDO_F_6),
            "Heliconius_erato" = mean(HER_F_1, HER_F_2, HER_F_3),
            "Heliconius_melpomene" = mean(HME_F_1, HME_F_2),
            "Heliconius_sara" = mean(HSA_F_1, HSA_F_2, HSA_F_3, HSA_F_4, HSA_F_5))

male_avg_dat_fpkm <- male_dat_fpkm %>% group_by(Orthogroup) %>%
  transmute("Heliconius_charithonia" = mean(HCH_M_1, HCH_M_2, HCH_M_3, HCH_M_4, HCH_M_5, HCH_M_6),
            "Heliconius_doris" = mean(HDO_M_1, HDO_M_2, HDO_M_3, HDO_M_4, HDO_M_5, HDO_M_6),
            "Heliconius_erato" = mean(HER_M_1, HER_M_2, HER_M_3),
            "Heliconius_melpomene" = mean(HME_M_1, HME_M_2),
            "Heliconius_sara" = mean(HSA_M_1, HSA_M_2, HSA_M_3, HSA_M_4, HSA_M_5))

female_avg_dat_tpm <- female_dat_tpm %>% group_by(Orthogroup) %>%
  transmute("Heliconius_charithonia" = mean(HCH_F_1, HCH_F_2, HCH_F_3, HCH_F_4, HCH_F_5),
            "Heliconius_doris" = mean(HDO_F_1, HDO_F_2, HDO_F_3, HDO_F_4, HDO_F_5, HDO_F_6),
            "Heliconius_erato" = mean(HER_F_1, HER_F_2, HER_F_3),
            "Heliconius_melpomene" = mean(HME_F_1, HME_F_2),
            "Heliconius_sara" = mean(HSA_F_1, HSA_F_2, HSA_F_3, HSA_F_4, HSA_F_5))

male_avg_dat_tpm <- male_dat_tpm %>% group_by(Orthogroup) %>%
  transmute("Heliconius_charithonia" = mean(HCH_M_1, HCH_M_2, HCH_M_3, HCH_M_4, HCH_M_5, HCH_M_6),
            "Heliconius_doris" = mean(HDO_M_1, HDO_M_2, HDO_M_3, HDO_M_4, HDO_M_5, HDO_M_6),
            "Heliconius_erato" = mean(HER_M_1, HER_M_2, HER_M_3),
            "Heliconius_melpomene" = mean(HME_M_1, HME_M_2),
            "Heliconius_sara" = mean(HSA_M_1, HSA_M_2, HSA_M_3, HSA_M_4, HSA_M_5))

#Standard Error function
standard_error <- function(x) sd(x) / sqrt(length(x))

#Get SE for males and females
female_SE_tpm <- female_dat_tpm %>% group_by(Orthogroup) %>%
  summarise(Orthogroup, SE = standard_error(across(HCH_F_1:HSA_F_5)))

male_SE_tpm <- male_dat_tpm %>% group_by(Orthogroup) %>%
  summarise(Orthogroup, SE = standard_error(across(HCH_M_1:HSA_M_5)))

female_SE_fpkm <- female_dat_fpkm %>% group_by(Orthogroup) %>%
  summarise(Orthogroup, SE = standard_error(across(HCH_F_1:HSA_F_5)))

male_SE_fpkm <- male_dat_fpkm %>% group_by(Orthogroup) %>%
  summarise(Orthogroup, SE = standard_error(across(HCH_M_1:HSA_M_5)))

#Remove unnecessary data
rm(tr, male_dat_fpkm, female_dat_tpm, male_dat_tpm, female_dat_fpkm, fpkm_matrix, tpm_matrix)

#Now need to flip tables and properly format
format_expr_data <- function (avgdat) {
  temp <- avgdat %>% pull(Orthogroup)
  avgdat <- avgdat %>% ungroup() %>% select(!Orthogroup)
  dat <- flip(avgdat)
  colnames(dat) <- temp
  dat
}

#Running fitcontinuous

runFC <- function ( dat, SE ){
  fitResults <- vector(mode = "list", length = ncol(dat))
  tdf <- treedata(tree, dat, sort = TRUE)
  phy <- tdf$phy
  data <- tdf$data
  for(j in 1:ncol(dat)){
    fitBM <- fitContinuous(phy, data[,j], SE[[2]][[j]], model = "BM")
    fitOU <- fitContinuous(phy, data[,j], SE[[2]][[j]], model = "OU")
    fitEB <- fitContinuous(phy, data[,j], SE[[2]][[j]], model = "EB")
    aic <- c(fitBM$opt[["aic"]], fitOU$opt[["aic"]], fitEB$opt[["aic"]])
    fit <- ifelse(min(aic) == aic[1], list(c(fitBM, model = "BM")), 
                  ifelse(min(aic) == aic[2], list(c(fitOU, model = "OU")), 
                         list(c(fitEB, model = "EB"))))
    fitResults[j] <- fit
  }
  fitResults
}

model_count <- function (fit) {
  ou = 0
  bm = 0
  eb = 0
  for(f in fit){
    vec <- f
    ifelse(vec$model == "OU", ou <- ou + 1, ifelse(vec$model == "BM", bm <- bm + 1, eb <- eb + 1))
  }
  df <- data.frame(OU = ou, BM = bm, EB = eb)
  b <- df %>% pivot_longer(c(OU, BM, EB), names_to = "model")
  b
}

#running arbutus
run_arb <- function (fits){
  arby <- vector("list", length = length(fits))
  count = 1
  for(f in fits){
    class(f) <- "gfit"
    arby[[count]] <- arbutus(f)
    count = count + 1
  }
  arby_df <- map_df(arby, pvalue_arbutus)
  arby_df
}

total_process <- function (dat_list){
  avgdat <- dat_list[[1]]
  part <- dat_list[[2]]
  SE <- dat_list[[3]]
  normalization <- dat_list[[4]]
  exp <- format_expr_data(avgdat)
  fit <- runFC(exp, SE)
  fit_name <- paste0("Heliconius_Butterflies/renormalized/fit_", part,"_",normalization)
  saveRDS(fit, file = fit_name)
  df <- model_count(fit)
  aic_name <- paste0("Heliconius_Butterflies/renormalized/AIC_", part,"_",normalization, ".png")
  df %>% ggplot(aes(model, value)) + geom_col() + theme_classic()
  ggsave(aic_name)
  result <- run_arb(fit) %>% select(!m.sig)
  rds_name <- paste0("Heliconius_Butterflies/renormalized/pvals_", part,"_",normalization)
  saveRDS(result, file = rds_name)
  result %>% pivot_longer(cols = everything(), names_to = "tstat") %>%
    ggplot(aes(value)) + geom_histogram(aes(y = ..density..)) + facet_wrap(~tstat, nrow = 1) + theme_bw()
  pval_name <- paste0("Heliconius_Butterflies/renormalized/arbutus_", part,"_", normalization, ".png")
  ggsave(pval_name)
}

female_fpkm_list <- list(female_avg_dat_fpkm, "female", female_SE_fpkm, "fpkm")
male_fpkm_list <- list(male_avg_dat_fpkm, "male", male_SE_fpkm, "fpkm")
female_tpm_list <- list(female_avg_dat_tpm, "female", female_SE_tpm, "tpm")
male_tpm_list <- list(male_avg_dat_tpm, "male", male_SE_tpm, "tpm")

all_list <- list(female_fpkm_list, male_fpkm_list, female_tpm_list, male_tpm_list)

mclapply(all_list, total_process, mc.cores = 8)