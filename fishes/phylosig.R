# Phylosig Extremophile fish

library(tidyverse)
library(phytools)
library(purrr)

pval_files <- list.files("fishes/arbutus/pvals/")

readfile <- function(filename){
  res <- readRDS(paste0("fishes/arbutus/pvals/", filename))
  res
}

readfile2 <- function(filename){
  res <- readRDS(paste0("fishes/arbutus/multirate/pvals/", filename))
  res
}

pvals_total <- map_df(pval_files, readfile)
pvals_multi <- map_df(list.files("fishes/arbutus/multirate/pvals/"), readfile2)

tree <- read.tree("fishes/data/recodedTreeNamed.tre") %>% chronoMPL()

noInf <- function(x) if(x == -Inf) 0 else x
noInf2 <- Vectorize(noInf)

data_ave <- read.csv("fishes/data/master_fpkm.csv", row.names = 1) %>% mutate(across(everything(), log)) %>% mutate(across(everything(), noInf2)) %>% rownames_to_column("genes") %>% group_by(genes)%>%
  transmute(GholNS = mean(c(GholNS_1, GholNS_2, GholNS_3, GholNS_4, GholNS_5, GholNS_6)),
            GsexNS = mean(c(GsexNS_1, GsexNS_2, GsexNS_3, GsexNS_4, GsexNS_5, GsexNS_6)),
            PbimNS = mean(c(PbimNS_1, PbimNS_2, PbimNS_3, PbimNS_4, PbimNS_5, PbimNS_6)),
            XhelNS = mean(c(XhelNS_1, XhelNS_2, XhelNS_3, XhelNS_4, XhelNS_5, XhelNS_6)),
            LperNS = mean(c(LperNS_1, LperNS_2, LperNS_3, LperNS_4, LperNS_5, LperNS_6)),
            PlatNS = mean(c(PlatNS_1, PlatNS_2, PlatNS_3, PlatNS_4, PlatNS_5, PlatNS_6)),
            PlimNS = mean(c(PlimNS_1, PlimNS_2, PlimNS_3, PlimNS_4, PlimNS_5, PlimNS_6)),
            PmexPuyNS = mean(c(PmexPuyNS_1, PmexPuyNS_2, PmexPuyNS_3, PmexPuyNS_4, PmexPuyNS_5, PmexPuyNS_6)),
            PmexPichNS = mean(c(PmexPichNS_1, PmexPichNS_2, PmexPichNS_3, PmexPichNS_4, PmexPichNS_5, PmexPichNS_6)),
            PmexTacNS = mean(c(PmexTacNS_1, PmexTacNS_2, PmexTacNS_3, PmexTacNS_4, PmexTacNS_5, PmexTacNS_6)),
            PmexPuyS = mean(c(PmexPuyS_1, PmexPuyS_2, PmexPuyS_3, PmexPuyS_4, PmexPuyS_5)),
            PmexTacS = mean(c(PmexTacS_2, PmexTacS_3, PmexTacS_4, PmexTacS_5, PmexTacS_6)),
            PmexPichS = mean(c(PmexPichS_1, PmexPichS_2, PmexPichS_3, PmexPichS_4, PmexPichS_5, PmexPichS_6)),
            PlatS = mean(c(PlatS_1, PlatS_2, PlatS_3, PlatS_4, PlatS_5, PlatS_6)),
            LsulS = mean(c(LsulS_1, LsulS_2, LsulS_3, LsulS_4, LsulS_5, LsulS_6)),
            GsexS = mean(c(GsexS_1, GsexS_2, GsexS_3, GsexS_4, GsexS_5, GsexS_6)),
            GeurS = mean(c(GeurS_1, GeurS_2, GeurS_3, GeurS_4, GeurS_5, GeurS_6)),
            GholS = mean(c(GholS_1, GholS_2, GholS_3, GholS_4, GholS_5, GholS_6)),
            PbimS = mean(c(PbimS_1, PbimS_2, PbimS_3, PbimS_4, PbimS_5, PbimS_6)),
            XhelS = mean(c(XhelS_1, XhelS_2, XhelS_3, XhelS_4, XhelS_5, XhelS_6))) %>% column_to_rownames("genes")

num <- 1:dim(pvals_total)[1]
only_NA <- pvals_total %>% mutate(num = num) %>% filter(is.na(s.hgt)) %>% pull(num)
not_NA <- pvals_total %>% mutate(num = num) %>% filter(!is.na(s.hgt)) %>% pull(num)

only_NA_df <- data_ave[only_NA,] %>% t() %>% as.data.frame()
not_NA_df <- data_ave[not_NA,] %>% t() %>% as.data.frame()


#Null hypothesis of randomization test is that there is no phylogenetic signal,
#so low p-value indicates that there IS phylogenetic signal

physig <- function(x){
  res <- tryCatch(phylosig(tree, x, method = "K", test = TRUE), error = function(x)NA)
  res
}

only_NA_sig <- only_NA_df %>% purrr::map(physig) 
clean_onlyNA <- only_NA_sig[!is.na(only_NA_sig)]
not_NA_sig <- not_NA_df %>% purrr::map(physig)
clean_notNA <- not_NA_sig[!is.na(not_NA_sig)]

get_K_and_P <- function (sig) {
  K <- sig$K
  P <- sig$P
  list("K" = K, "P-value" = P)
}

only_NA_vals <- map_df(clean_onlyNA, get_K_and_P) %>% mutate(subset = "only_NA")
not_NA_vals <- map_df(clean_notNA, get_K_and_P) %>% mutate(subset = "not_NA")

K_P_vals <- bind_rows(only_NA_vals, not_NA_vals) %>% pivot_longer(cols = c(K, `P-value`), names_to = "Statistic")
saveRDS(K_P_vals, "fishes/arbutus/k_p_vals.rds")
K_P_vals %>% ggplot(aes(x = subset, y = value, fill = subset)) + geom_violin() + 
  geom_boxplot() + facet_wrap(~Statistic) + theme_bw() + ggtitle("Phylogenetic signal of all genes")+
  xlab("Subset of data")

ggsave("fishes/arbutus/phylosig_all.png", device = "png", width = 800, height = 1000, units = "px") 