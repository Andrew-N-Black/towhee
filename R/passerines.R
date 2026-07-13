# =============================================================================
# GENOMIC DIVERSITY ANALYSIS: Heterozygosity and Runs of Homozygosity (ROH)
# Compares genetic diversity metrics across a broader panel of songbird
# (passerine) species/populations, grouped by IUCN conservation status
# category, to contextualize the California towhee results.
# =============================================================================

# ─── SECTION 1: INDIVIDUAL HETEROZYGOSITY (H) BY Binary IUCN assignment ──────────

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


# ─── SECTION 2: fROH BY Binary IUCN assignment ───────────────────────────────────
# fROH = fraction of genome in Runs of Homozygosity; relative inbreeding

# Load ROH data for songbirds
SONG_BIRDS_roh <- read_excel("/Users/andrewblack/Documents/Research/Towhee/Black_analysis/SONG_BIRDS-rohC.xlsx")

# Reshape from wide to long format; keep Organism, SHORT, and N50 as ID variables
# N50 = assembly quality metric (contig/scaffold N50)
# Resulting 'variable' column will distinguish ROH size classes (e.g., KB, MB)
roh <- melt(SONG_BIRDS_roh, id.vars = c("Organism", "SHORT", "N50"))

# Order populations once by mean fROH, so boxplots, points, and n-labels
# below all share the same x-axis order (inline reorder() in aes() would
# NOT be visible to the separate n_labels data frame used for annotation)
roh$SHORT <- as.factor(roh$SHORT)
roh$SHORT <- reorder(roh$SHORT, roh$value, FUN = mean, na.rm = TRUE)

# Sample size per population, for the F1MB panel only
# (every individual should have the same n across classes; showing it on
# all panels would just be redundant clutter)
n_labels <- aggregate(value ~ variable + SHORT, data = roh, FUN = length)
names(n_labels)[names(n_labels) == "value"] <- "n"
n_labels <- n_labels[n_labels$variable == "F1MB", ]

# Boxplot + jittered points of fROH by population, faceted by ROH size class
# - Jitter adds transparency (alpha) to reduce overplotting
# - Free y-axis scales allow each ROH class to display its own range
# - n labels sit at the bottom of the F1MB panel only (y = -Inf resolves
#   per-panel, so this still works correctly under scales = "free_y")
# - coord_cartesian pads the left edge so the first boxplot isn't flush
#   against the axis; xlim here doesn't drop any data (unlike scale_x_*)
ggplot(roh, aes(y = value, x = SHORT)) +
    geom_boxplot(aes(color = SHORT)) +
    geom_jitter(aes(color = SHORT), width = 0.4, alpha = 0.5) +
    geom_text(data = n_labels, aes(x = SHORT, y = -Inf, label = n),
              inherit.aes = FALSE, vjust = -0.4, size = 5) +
    coord_cartesian(ylim = c(-0.01, NA)) +
    theme_classic(base_size = 22) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
    xlab("") +
    ylab("fROH") +
    scale_color_manual(values = c("#1F78B4", "#B2DF8A", "grey",
                                  "#A6CEE3", "#33A02C", "grey", "grey")) +
    theme(legend.position = "none") +
    facet_wrap(~variable, scales = "free_y") # Separate panel per ROH size class

# ─── SECTION 3: STATISTICAL TESTS — fROH BY IUCN CATEGORY ───────────────────

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

