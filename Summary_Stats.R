#Summary Statistics
library(tidyverse)

# Set the color palette
custom_pal <- c("#ffab40", "#0097a7","#8e7cc3" , "#78909c","#6aa84f")

# List all experiments

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

readfile <- function(filename){
  res <- readRDS(paste0(path, "Fits/", filename))
  res

}

readfile2 <- function(filename){
  res <- readRDS(paste0(path, "pvals/", filename))
  res
}

## Mammal organs
aics_mam <- readRDS("Mammal_organs/gene_family_phylogenies/arbutus/fits/fit_br") %>% flatten() %>% model_count() %>% mutate(source = "Mammals")
pvals_mam <- readRDS("Mammal_organs/gene_family_phylogenies/arbutus/pvals/pvals_br.rds") %>% mutate(source = "Mammals")

## Cichlids
path <- "cichlids/arbutus/"
cichs_fits <- list.files(paste0(path, "Fits/"))
cichs_pvals <- list.files(paste0(path,"pvals/"))

aics_cichlids <- purrr::map(cichs_fits, readfile) %>% flatten() %>% model_count() %>% mutate(source = "Cichlids")
pvals_cichlids <- purrr::map_df(cichs_pvals, readfile2) %>% mutate(source = "Cichlids")

## Fishes
path <- "fishes/arbutus/"
fish_fits <- list.files(paste0(path, "Fits/"))
fish_pvals <- list.files(paste0(path,"pvals/"))

aics_fish <- purrr::map(fish_fits, readfile) %>% flatten() %>% model_count() %>% mutate(source = "Extremophiles")
pvals_fish <- purrr::map_df(fish_pvals, readfile2) %>% mutate(source = "Extremophiles")

## Butterflies
pvals_butterflies <- readRDS("Heliconius_Butterflies/arbutus/pvals_male") %>% mutate(source = "Heliconius")
aics_butterflies <- readRDS("Heliconius_Butterflies/arbutus/fit_male") %>% model_count() %>% mutate(source = "Heliconius")

## Snakes
aics_snakes <- readRDS("snakes/arbutus/fit") %>% model_count() %>% mutate(source = "Venom")
pvals_snakes <- readRDS("snakes/arbutus/pvals") %>% mutate(source = "Venom")

## Amalgam
aics_amalgam <- readRDS("/home/fieldima/R/amalgam_data/arbutus/fits/fit_brain") %>% model_count() %>% mutate(source = "Amalgamated")
pvals_amalgam <- readRDS("/home/fieldima/R/amalgam_data/arbutus/pvals/pvals_brain") %>% select(!m.sig) %>% mutate(source = "Amalgamated")
pvals_amalgam %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram() + facet_wrap(~tstat, nrow = 1) + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12)) + xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_brewer(palette = "Set1")

aics_amalgam %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_classic() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12)) 
## Interspecific
aics_inter <- readRDS("/home/fieldima/R/interspecific_rnaseq/arbutus/best/best_fit") %>% model_count() %>% mutate(source = "Cave Fish")
pvals_inter <- readRDS("/home/fieldima/R/interspecific_rnaseq/arbutus/best/best_pvals") %>% mutate(source = "Cave Fish")

## KMRR
pvals_kmrr <- readRDS("/home/fieldima/R/comparative_expression_2017/arbutus/p_vals_df")[1:8333,] %>% mutate(source = "KMRR")
kmrr1 <- readRDS("/home/fieldima/R/comparative_expression_2017/arbutus/brain_fit_first")
kmrr2 <- readRDS("/home/fieldima/R/comparative_expression_2017/arbutus/brain_fit_second")
kmrr3 <- readRDS("/home/fieldima/R/comparative_expression_2017/arbutus/brain_fit_third")
aics_kmrr <- c(kmrr1, kmrr2, kmrr3) %>% flatten() %>% model_count() %>% mutate(source = "KMRR")
rm(kmrr1, kmrr2, kmrr3)

## Coevolution
aics_coevolution <- readRDS("/home/fieldima/R/GeneExpression_coevolution/fits") %>% model_count() %>% mutate(source = "Fungi")
pvals_coevolution <- readRDS("/home/fieldima/R/GeneExpression_coevolution/pvalues_df") %>% mutate(source = "Fungi")
### Figure2.3A
readRDS("/home/fieldima/R/GeneExpression_coevolution/only_BM_genes_pvals") %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/sum(n)) %>% mutate(inade = as.character(inade)) %>% drop_na() %>% ggplot(aes(x = inade, y = n)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Number of Genes") + theme_classic() + theme(legend.position = "none", axis.title = element_text(size = 14), axis.text = element_text(size = 12)) 
### Figure2.3B
readRDS("/home/fieldima/R/GeneExpression_coevolution/only_bm_genes_allfit") %>%
  model_count() %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_classic() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12)) + ylab("Number of Genes") + xlab("Model")
### Figure2.3C
readRDS("/home/fieldima/R/GeneExpression_coevolution/only_BM_allfit_pvalues_df") %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/sum(n)) %>% mutate(inade = as.character(inade)) %>% drop_na() %>% ggplot(aes(x = inade, y = n)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Number of Genes") + theme_classic() + theme(legend.position = "none", axis.title = element_text(size = 14), axis.text = element_text(size = 12)) 
### Figure2.3D
readRDS("/home/fieldima/R/GeneExpression_coevolution/pvalues_df_chosen.rds") %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/sum(n)) %>% mutate(inade = as.character(inade)) %>% drop_na() %>% ggplot(aes(x = inade, y = n)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Number of Genes") + theme_classic() + theme(legend.position = "none", axis.title = element_text(size = 14), axis.text = element_text(size = 12))

### Figure 2.4A
gf_pvals <- readRDS("/home/fieldima/R/gene-phylogeny-pipeline/arbutus/pvalues_df") %>% mutate(tree = "Local Trees")
spec_pvals <- readRDS("/home/fieldima/R/GeneExpression_coevolution/pvalues_df") %>% mutate(tree = "Species Tree")
both_pvals <- full_join(spec_pvals, gf_pvals) %>% select(!c(m.sig))
both_pvals %>% pivot_longer(cols = !c(tree), names_to = "tstat") %>%
  ggplot(aes(value)) + geom_histogram(aes(y = ..density.., fill = tstat)) + facet_grid(rows = vars(tree), cols = vars(tstat)) + theme_bw() + geom_vline(xintercept = 0.05, color = "black") +
  theme(strip.text = element_text(size = 12), axis.title = element_text(size = 12), axis.text = element_text(size =8), panel.grid = element_blank(), legend.position = "none") + xlab("P-values") + scale_fill_manual(values = custom_pal)

# Number of times OU was the best model (single rate only)

# Number of genes tested
all_pvals <- full_join(pvals_amalgam, pvals_butterflies) %>% full_join(pvals_cichlids) %>% full_join(pvals_coevolution) %>%
  full_join(pvals_fish) %>% full_join(pvals_inter) %>% full_join(pvals_mam) %>% full_join(pvals_snakes) %>% full_join(pvals_kmrr) %>% select(!m.sig)

nrow(all_pvals)

# Number of genes that were inadequate 
all_inadequacies <- all_pvals %>% transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>% transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/sum(n)) %>% mutate(inade = as.character(inade)) %>% drop_na()

all_inadequacies %>% ggplot(aes(x = inade, y = n)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2))) +
  xlab("Number of inadequacies") + ylab("Number of genes") + theme_classic()

all_pvals %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram() + facet_wrap(~tstat, nrow = 1) + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12)) + xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_brewer(palette = "Set1")

#Figure 2.2 Right
right <- all_pvals %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram(alpha = 0.8) + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank(), axis.text.x = element_text(angle = 30)) +
  xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_manual(values = custom_pal) +
  facet_grid(rows = vars(source), cols = vars(tstat), scales = "free_y")

all_pvals %>% 
  transmute(c.var = c.var <= 0.05, s.var = s.var <= 0.05,
            s.asr = s.asr <= 0.05, s.hgt = s.hgt <= 0.05 & !is.na(s.hgt),
            d.cdf = d.cdf <= 0.05) %>% drop_na() %>% summarise(across(.fns = ~sum(.x, na.rm = TRUE))) %>% pivot_longer(cols = everything(), names_to = "test statistic") %>%
  mutate(value = value/nrow(all_pvals), value = round(value, digits = 3)) %>%
  ggplot(aes(x = `test statistic`, y = value, fill = `test statistic`)) + geom_col() +
  geom_text(aes(label = round(value, digits = 2))) +  theme_classic() + ylab("Proportion of genes with an inadequacy") + xlab("Test Statistic") + scale_fill_brewer(palette = "Set1") + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12), strip.text = element_text(size = 12), legend.position = "none", panel.grid = element_blank())


all_aics <- aics_amalgam %>% full_join(aics_butterflies) %>% full_join(aics_cichlids) %>% full_join(aics_fish) %>% full_join(aics_inter) %>%
  full_join(aics_kmrr) %>% full_join(aics_mam) %>% full_join(aics_snakes) %>% full_join(aics_coevolution)

#Figure 2.2 Left
left <- all_aics %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_bw() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank()) +
  facet_wrap(~source, ncol = 1, scales = "free_y", strip.position = "right") + ylab("Number of Genes") + xlab("Model")

### With BMS models
model_count <- function (fit) {
  ou = 0
  bm = 0
  eb = 0
  bms = 0
  for(f in fit){
    vec <- f
    ifelse(vec$model == "OU", ou <- ou + 1, ifelse(vec$model == "BM", bm <- bm + 1, ifelse(vec$model == "EB", eb <- eb + 1, bms <- bms + 1)))
  }
  df <- data.frame(OU = ou, BM = bm, EB = eb, BMS = bms)
  b <- df %>% pivot_longer(c(OU, BM, EB, BMS), names_to = "model")
  b
}

## Mammal organs
aics_mam <- readRDS("Mammal_organs/species_phylogeny/arbutus/BMS/fit_br") %>% model_count() %>% mutate(source = "Mammals")
pvals_mam <- readRDS("Mammal_organs/species_phylogeny/arbutus/BMS/pvals_br") %>% mutate(source = "Mammals")

## Cichlids
path <- "cichlids/arbutus/multirate/"
cichs_fits <- list.files(paste0(path, "Fits/"))
cichs_pvals <- list.files(paste0(path,"pvals/")) %>% grep("^p", x = ., value = TRUE)
aics_cichlids <- purrr::map(cichs_fits, readfile) %>% flatten() %>% model_count() %>% mutate(source = "Cichlids")
pvals_cichlids <- purrr::map_df(cichs_pvals, readfile2) %>% mutate(source = "Cichlids") %>% slice_head(n = 13555)

## Fishes
path <- "fishes/arbutus/multirate/"
fish_fits <- list.files(paste0(path, "Fits/")) %>% grep("^m", x = ., value = TRUE)
fish_pvals <- list.files(paste0(path,"pvals/")) %>% grep("^m", x = ., value = TRUE)

aics_fish <- purrr::map(fish_fits, readfile) %>% flatten() %>% model_count() %>% mutate(source = "Extremophiles")
pvals_fish <- purrr::map_df(fish_pvals, readfile2) %>% mutate(source = "Extremophiles")

## Butterflies
pvals_butterflies <- readRDS("Heliconius_Butterflies/multirate_arbutus/pvals_male") %>% mutate(source = "Heliconius")
aics_butterflies <- readRDS("Heliconius_Butterflies/multirate_arbutus/fit_male") %>% model_count() %>% mutate(source = "Heliconius")

## Snakes
aics_snakes <- readRDS("snakes/arbutus/BMS/fit") %>% model_count() %>% mutate(source = "Venom")
pvals_snakes <- readRDS("snakes/arbutus/BMS/pvals") %>% mutate(source = "Venom")

## Amalgam
aics_amalgam <- readRDS("/home/fieldima/R/amalgam_data/arbutus/fits/BMS_fit_brain") %>% model_count() %>% mutate(source = "Amalgamated")
pvals_amalgam <- readRDS("/home/fieldima/R/amalgam_data/arbutus/pvals/BMS_pvals_brain") %>% select(!m.sig) %>% mutate(source = "Amalgamated")
pvals_amalgam %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram() + facet_wrap(~tstat, nrow = 1) + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12)) + xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_brewer(palette = "Set1")

aics_amalgam %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_classic() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12)) 
## Interspecific
aics_inter <- readRDS("/home/fieldima/R/interspecific_rnaseq/arbutus/best/best_fit_bms") %>% model_count() %>% mutate(source = "Cave Fish")
pvals_inter <- readRDS("/home/fieldima/R/interspecific_rnaseq/arbutus/best/best_pvals_bms") %>% mutate(source = "Cave Fish")

## Coevolution
aics_coevolution <- readRDS("/home/fieldima/R/GeneExpression_coevolution/BMS_fits") %>% model_count() %>% mutate(source = "Fungi")
pvals_coevolution <- readRDS("/home/fieldima/R/GeneExpression_coevolution/BMS_pvals") %>% mutate(source = "Fungi")

#put all together
all_pvals_bms <- full_join(pvals_amalgam, pvals_butterflies) %>% full_join(pvals_cichlids) %>% full_join(pvals_coevolution) %>%
  full_join(pvals_fish) %>% full_join(pvals_inter) %>% full_join(pvals_mam) %>% full_join(pvals_snakes) %>% select(!m.sig) 

all_pvals_bms %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram() + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank(), axis.text.x = element_text(angle = 30)) +
  xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_brewer(palette = "Set1") +
  facet_grid(rows = vars(source), cols = vars(tstat), scales = "free_y")

all_pvals_bms %>% pivot_longer(cols = -c(source), names_to = "tstat") %>%
  ggplot(aes(value, fill = tstat)) + geom_histogram() + theme_bw() + theme(axis.text = element_text(12), legend.position = "none") +
  theme(axis.title = element_text(size = 14), axis.text = element_text(size = 8), strip.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank(), axis.text.x = element_text(angle = 30)) +
  xlab("P-value") + geom_vline(xintercept = 0.05, color = "black") + ylab("Number of Genes") + scale_fill_brewer(palette = "Set1") + facet_wrap(~tstat, nrow = 1)

woBMS <- all_pvals %>% filter(!source %in% c("KMRR", "Heliconius")) %>% 
  transmute(c.var = c.var <= 0.05, s.var = s.var <= 0.05,
            s.asr = s.asr <= 0.05, s.hgt = s.hgt <= 0.05 & !is.na(s.hgt),
            d.cdf = d.cdf <= 0.05) %>% drop_na() %>% summarise(across(.fns = ~sum(.x, na.rm = TRUE))) %>% pivot_longer(cols = everything(), names_to = "test statistic") %>%
  mutate(prop = value/nrow(all_pvals %>% filter(!source %in% c("KMRR", "Heliconius"))), prop = round(prop, digits = 3)) %>% mutate(models = "w/o BMS") 

wBMS <- all_pvals_bms %>% filter(!source %in% c("KMRR", "Heliconius")) %>%
  transmute(c.var = c.var <= 0.05, s.var = s.var <= 0.05,
            s.asr = s.asr <= 0.05, s.hgt = s.hgt <= 0.05 & !is.na(s.hgt),
            d.cdf = d.cdf <= 0.05) %>% drop_na() %>% summarise(across(.fns = ~sum(.x, na.rm = TRUE))) %>% pivot_longer(cols = everything(), names_to = "test statistic") %>%
  mutate(prop = value/nrow(all_pvals_bms %>% filter(!source %in% c("KMRR", "Heliconius"))), prop = round(prop, digits = 3)) %>% mutate(models = "w/ BMS") 

full_join(wBMS, woBMS) %>% mutate(models = factor(models, levels = c("w/o BMS", "w/ BMS"))) %>%
  ggplot(aes(x = `test statistic`, y = value, fill = `test statistic`)) + geom_col() +
  geom_text(aes(label = value)) +  theme_classic() + ylab("Number of genes") + xlab("Test Statistic") +
  scale_fill_brewer(palette = "Set1") + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12), strip.text = element_text(size = 12), legend.position = "none", panel.grid = element_blank()) +
  facet_wrap(~models)
ggsave("Pvals_BMS_noBMS.png")

# Overall adequacy comparison
p_df_num <- all_pvals %>% filter(!source %in% c("KMRR", "Heliconius")) %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/nrow(all_pvals %>% filter(!source %in% c("KMRR", "Heliconius")))) %>% mutate(inade = as.character(inade))

p_df <- all_pvals %>% filter(!source %in% c("KMRR")) %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/nrow(all_pvals)) %>% mutate(inade = as.character(inade)) %>% mutate(BMS = "W/o BMS")

p <- p_df %>% drop_na() %>% ggplot(aes(x = inade, y = prop)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Number of genes") + theme_classic() + theme(strip.text = element_text(size = 15), legend.position = "none", axis.title = element_text(size = 15), axis.text = element_text(size = 15), title = element_text(size = 20), plot.title = element_text(hjust = 0.5)) +
  ggtitle("W/o BMS") + scale_fill_brewer(palette = "Set2")
p
p_dfb_num <- all_pvals_bms %>% filter(!source %in% c("KMRR", "Heliconius")) %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/nrow(all_pvals_bms %>% filter(!source %in% c("KMRR", "Heliconius")))) %>% mutate(inade = as.character(inade))
p_dfb <- all_pvals_bms %>% filter(!source %in% c("KMRR")) %>%
  transmute(c.less = c.var <= 0.05, sv.less = s.var <= 0.05, sa.less = s.asr <= 0.05, sh.less = s.hgt <= 0.05 & !is.na(s.hgt), d.less = d.cdf <= 0.05) %>%
  transmute(inade = c.less + sv.less + sa.less + sh.less + d.less) %>% count(inade) %>% mutate(prop = n/nrow(all_pvals_bms)) %>% mutate(inade = as.character(inade)) %>% mutate(BMS = "W/ BMS")

pb <- p_dfb %>% drop_na() %>% ggplot(aes(x = inade, y = prop)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Number of genes") + theme_classic() + theme(strip.text = element_text(size = 15), legend.position = "none", axis.title = element_text(size = 15), axis.text = element_text(size = 15), title = element_text(size = 20), plot.title = element_text(hjust = 0.5)) +
  ggtitle("W/ BMS") + scale_fill_brewer(palette = "Set2")
pb
cowplot::plot_grid(p, pb)

p_final <- full_join(p_df, p_dfb) %>% mutate(BMS = factor(BMS, levels = c("W/o BMS", "W/ BMS")))

p_final %>% drop_na() %>% ggplot(aes(x = inade, y = prop)) + geom_bar(stat = "identity", fill = "#E5B80B") + geom_text(aes(label = round(prop, digits = 2)), size = 6) +
  xlab("Number of inadequacies") + ylab("Proportion of genes") + theme_classic() + theme(strip.text = element_text(size = 15), legend.position = "none", axis.title = element_text(size = 15), axis.text = element_text(size = 15), title = element_text(size = 20), plot.title = element_text(hjust = 0.5)) +
  scale_fill_brewer(palette = "Set2") + facet_wrap(~BMS)

ggsave("Overall_Adequacy_BMS_noBMS.png")

#AIC with BMS

all_aics <- aics_amalgam %>% full_join(aics_butterflies) %>% full_join(aics_cichlids) %>% full_join(aics_fish) %>% full_join(aics_inter) %>%
  full_join(aics_kmrr) %>% full_join(aics_mam) %>% full_join(aics_snakes) %>% full_join(aics_coevolution)

all_aics %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_bw() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank()) +
  facet_wrap(~source, ncol = 1, scales = "free_y", strip.position = "right") + ylab("Number of Genes") + xlab("Model")
all_aics %>% mutate(model = as.factor(model), model = fct_relevel(model, "BM", "OU", "EB")) %>%
  ggplot(aes(x = model, y = value)) + geom_col(fill = "#E5B80B") + theme_bw() + theme(axis.title = element_text(size = 14), axis.text = element_text(size = 12), strip.text.y = element_text(size = 9), panel.grid = element_blank()) +
  ylab("Number of Genes") + xlab("Model")
