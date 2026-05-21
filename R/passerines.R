# =============================================================================
# GENOMIC DIVERSITY ANALYSIS: Heterozygosity and Runs of Homozygosity (ROH)
# Compares genetic diversity metrics across IUCN conservation status categories
# =============================================================================

# ─── SECTION 1: INDIVIDUAL HETEROZYGOSITY (H) BY SPECIES/POPULATION ──────────

library(readxl)   # For reading Excel files
library(reshape2) # For reshaping data between wide and long formats
library(ggplot2)  # For plotting

# Load heterozygosity data
H <- read_excel("/Users/andrewblack/Documents/Research/Towhee/Black_analysis/H.xlsx")

# Convert SHORT (abbreviated species/population label) to a categorical factor
H$SHORT <- as.factor(H$SHORT)

# Boxplot of heterozygosity (H) by population/species, ordered by median H
# - Colors are manually assigned per group
# - Dashed line marks a reference heterozygosity value (e.g., a benchmark species)
# - Median sample sizes are displayed above each box via stat_summary
ggplot(H, aes(y = H, x = reorder(SHORT, H))) +
    geom_boxplot(aes(color = SHORT)) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("H") +
    theme(legend.position = "none") +
    geom_hline(yintercept = 0.0017970595, linetype = "dashed") + # Reference H value
    stat_summary(fun.y = median, fun.ymax = length,              # Show sample size (n) above boxes
                 geom = "text", aes(label = ..ymax..), vjust = -1) +
    ylim(0, 0.025) +
    scale_color_manual(values = c("#1F78B4", "#B2DF8A", "grey",
                                  "#A6CEE3", "#33A02C", "grey"))


# ─── SECTION 2: fROH BY SPECIES/POPULATION ───────────────────────────────────
# fROH = fraction of genome in Runs of Homozygosity; proxy for inbreeding

library(readxl)
library(reshape2)
library(ggplot2)

# Load ROH data for songbirds
SONG_BIRDS_roh <- read_excel("/Users/andrewblack/Documents/Research/Towhee/Black_analysis/SONG_BIRDS-rohC.xlsx")

# Reshape from wide to long format; keep Organism, SHORT, and N50 as ID variables
# N50 = assembly quality metric (contig/scaffold N50)
# Resulting 'variable' column will distinguish ROH size classes (e.g., KB, MB)
roh <- melt(SONG_BIRDS_roh, id.vars = c("Organism", "SHORT", "N50"))
roh$SHORT <- as.factor(roh$SHORT)

# Boxplot + jittered points of fROH by population, faceted by ROH size class
# - Jitter adds transparency (alpha) to reduce overplotting
# - Free y-axis scales allow each ROH class to display its own range
ggplot(roh, aes(y = value, x = reorder(SHORT, value))) +
    geom_boxplot(aes(color = SHORT)) +
    geom_jitter(aes(color = SHORT), width = 0.4, alpha = 0.5) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("fROH") +
    scale_color_manual(values = c("#1F78B4", "#B2DF8A", "grey",
                                  "#A6CEE3", "#33A02C", "grey", "grey")) +
    theme(legend.position = "none") +
    facet_wrap(~variable, scales = "free_y") # Separate panel per ROH size class


# ─── SECTION 3: H BY FULL IUCN CLASSIFICATION ────────────────────────────────
# Uses all IUCN Red List categories (e.g., LC, NT, VU, EN, CR...)

library(readxl)
library(reshape2)
library(ggplot2)

# Note: trailing space in filename — may need correcting depending on OS
H <- read_excel("/Users/andrewblack/Documents/Research/Towhee/Black_analysis/H.xlsx ",
                col_types = c("text", "text", "numeric"))
H$IUCN <- as.factor(H$IUCN)

# Boxplot ordered by median H, colored by full IUCN category
ggplot(H, aes(y = H, x = reorder(IUCN, H))) +
    geom_boxplot(aes(color = IUCN)) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("H") +
    scale_color_manual(values = c("#1F78B4", "grey", "#B2DF8A", "grey",
                                  "grey", "#33A02C", "#A6CEE3", "grey")) +
    theme(legend.position = "none") +
    geom_hline(yintercept = 0.0017970595, linetype = "dashed") + # Reference H
    stat_summary(fun.y = median, fun.ymax = length,
                 geom = "text", aes(label = ..ymax..), vjust = -1) +
    ylim(0, 0.015)
ggsave("~/FigureX.svg") # Save as scalable vector graphic


# ─── SECTION 4: H BY BINARY IUCN CLASSIFICATION ──────────────────────────────
# Simplified classification: e.g., threatened vs. non-threatened

# Four column types: SHORT group label added alongside IUCN
H <- read_excel("H.xlsx", col_types = c("text", "text", "text", "numeric"))
H$IUCN <- as.factor(H$IUCN)

ggplot(H, aes(y = H, x = reorder(SHORT, H))) +
    geom_boxplot(aes(color = SHORT)) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("H") +
    scale_color_manual(values = c("#1F78B4", "#B2DF8A", "grey",
                                  "#A6CEE3", "#33A02C", "grey")) +
    theme(legend.position = "none") +
    geom_hline(yintercept = 0.0017970595, linetype = "dashed") +
    ylim(0, 0.025) +
    stat_summary(fun.y = median, fun.ymax = length,
                 geom = "text", aes(label = ..ymax..), vjust = -1)
ggsave("~/FigureX_shortlist.svg")


# ─── SECTION 5: STATISTICAL TESTS — H BY IUCN CATEGORY ──────────────────────
# Non-parametric tests used because H values are unlikely to be normally distributed

# Kruskal-Wallis test: checks whether any IUCN groups differ significantly in H
kruskal.test(H$H, H$SHORT, p.adjust.method = "bonf", exact = FALSE)
# Result: chi-squared = 193.28, df = 5, p < 2.2e-16 → significant overall difference

# Post-hoc pairwise Wilcoxon tests with Bonferroni correction
# Identifies which specific pairs of groups differ
pairwise.wilcox.test(H$H, H$SHORT, p.adjust.method = "bonf", exact = FALSE)
# Key significant comparisons (p < 0.05) include LC vs. most threatened groups
# INYO, CCAL, SCAL show notably lower H than LC (least concern)


# ─── SECTION 6: ROH — FULL IUCN CATEGORIES ───────────────────────────────────

library(readxl)
library(reshape2)
library(ggplot2)

SONG_BIRDS_roh <- read_excel("~/ROH.xlsx")

# Melt to long format; Species, IUCN, SHORT are ID variables
roh <- melt(SONG_BIRDS_roh, id.vars = c("Species", "IUCN", "SHORT"))
roh$IUCN <- as.factor(roh$IUCN)

# Faceted boxplot by IUCN category and ROH class
# - Free y-axis scales per facet
# - Sample sizes shown inside boxes (vjust = 1 places text lower)
ggplot(roh, aes(y = value, x = reorder(IUCN, value))) +
    geom_boxplot(aes(color = IUCN)) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("fROH") +
    facet_wrap(~variable, scales = "free_y") +
    scale_color_manual(values = c("#1F78B4", "grey", "#B2DF8A", "grey",
                                  "grey", "#33A02C", "#A6CEE3", "grey")) +
    theme(legend.position = "none") +
    stat_summary(fun.y = median, fun.ymax = length,
                 geom = "text", aes(label = ..ymax..), vjust = 1) +
    ylim(0, 0.45)


# ─── SECTION 7: ROH — BINARY IUCN CATEGORIES ─────────────────────────────────

library(readxl)
library(reshape2)
library(ggplot2)

SONG_BIRDS_roh <- read_excel("~/Documents/Research/Towhee/Black_analysis/SONG_BIRDS-rohC.xlsx")
roh <- melt(SONG_BIRDS_roh, id.vars = c("Organism", "SHORT", "N50"))
roh$SHORT <- as.factor(roh$SHORT)

# facet_grid (vs facet_wrap above) arranges panels in a strict grid layout
ggplot(roh, aes(y = value, x = reorder(SHORT, value))) +
    geom_boxplot(aes(color = SHORT)) +
    geom_jitter(aes(color = SHORT), width = 0.4, alpha = 0.5) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("fROH") +
    facet_grid(~variable, scales = "free") + # One row of panels, free x and y scales
    scale_color_manual(values = c("#1F78B4", "#B2DF8A", "grey",
                                  "#A6CEE3", "#33A02C", "grey", "grey")) +
    theme(legend.position = "none")


# ─── SECTION 8: STATISTICAL TESTS — fROH BY IUCN CATEGORY ───────────────────

# --- 8a. Ancestral ROH (KB = kilobase-scale ROH; reflects ancient inbreeding) ---

kruskal.test(F100 ~ SHORT, data = SONG_BIRDS_roh)
#Kruskal-Wallis chi-squared = 147.28, df = 5, p-value <2.2e-16

kruskal.test(F1MB ~ SHORT, data = SONG_BIRDS_roh)
#Kruskal-Wallis chi-squared = 159.93, df = 5, p-value <2.2e-16

kruskal.test(Ftotal ~ SHORT, data = SONG_BIRDS_roh)
#Kruskal-Wallis chi-squared = 147.31, df = 5, p-value <2.2e-16



pairwise.wilcox.test(SONG_BIRDS_roh$F100, SONG_BIRDS_roh$SHORT,p.adjust.method = "bonf", exact = FALSE)
               CCAL    INYO    Not Threatened OREG    SCAL   
INYO           1.8e-05 -       -              -       -      
Not Threatened 2.0e-12 1.2e-08 -              -       -      
OREG           1.4e-05 1.00000 9.7e-09        -       -      
SCAL           0.07891 7.5e-06 1.3e-07        7.5e-06 -      
Threatened     1.00000 0.00015 2.5e-10        7.1e-05 1.00000

P value adjustment method: bonferroni 

pairwise.wilcox.test(SONG_BIRDS_roh$F1MB, SONG_BIRDS_roh$SHORT,p.adjust.method = "bonf", exact = FALSE)
               CCAL    INYO    Not Threatened OREG    SCAL   
INYO           0.00796 -       -              -       -      
Not Threatened < 2e-16 2.3e-12 -              -       -      
OREG           1.00000 0.00106 4.0e-11        -       -      
SCAL           0.27419 0.00066 1.2e-14        1.00000 -      
Threatened     1.6e-05 6.1e-07 4.4e-09        0.02719 0.05331

P value adjustment method: bonferroni 

pairwise.wilcox.test(SONG_BIRDS_roh$Ftotal, SONG_BIRDS_roh$SHORT,p.adjust.method = "bonf", exact = FALSE)
               CCAL    INYO    Not Threatened OREG    SCAL   
INYO           3.9e-05 -       -              -       -      
Not Threatened 6.5e-13 2.0e-08 -              -       -      
OREG           0.00015 0.84814 2.4e-08        -       -      
SCAL           0.09307 1.7e-05 4.1e-08        8.8e-06 -      
Threatened     0.75974 1.4e-05 8.7e-10        0.00011 1.00000

P value adjustment method: bonferroni 

