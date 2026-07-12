# =============================================================================
# Evanno et al. (2005) deltaK plot for choosing the best-supported K
# (number of ancestral populations) from ADMIXTURE/NGSadmix log-likelihoods.
# =============================================================================

library(ggplot2)
library(readxl)
delta <- read_excel("/Users/andrewblack/Documents/Research/Towhee/Black_analysis/k.xlsx")
ggplot(delta,aes(x=K,y=`mean(|L"(K)|)/stdev[L(K)]")`))+geom_line(color="black") + geom_point(color="grey22",size=6)+theme_classic()+ylab("∆K")
ggsave("~/delta.svg",width = 12,height = 3)
