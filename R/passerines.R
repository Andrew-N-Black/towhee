#Heterozygosity
SONG_BIRDS_het <- read_excel("SONG_BIRDS.xlsx")
SONG_BIRDS_het$SHORT=as.factor(SONG_BIRDS_het$SHORT)

ggplot(SONG_BIRDS_het, aes(y=H, x=reorder(SHORT,H))) + geom_boxplot(aes(color=SHORT))+ geom_jitter(aes(color=SHORT),width = 0.2,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("H")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","#A6CEE3","#33A02C","grey"))+ theme(legend.position="none")+geom_hline(yintercept = 0.0017970595)


## ROH

library(readxl)
library(reshape2)
library(ggplot2)
SONG_BIRDS_roh <- read_excel("SONG_BIRDS-rohB.xlsx")
roh<-melt(SONG_BIRDS_roh, id.vars = c("SHORT","Organism","N50"))
roh$SHORT=as.factor(roh$SHORT)
mean(roh$value)+2*sd(roh$value)
#[1] 0.1241392
ggplot(roh, aes(y=value, x=reorder(SHORT,value))) + geom_boxplot(aes(color=SHORT))+ geom_jitter(aes(color=SHORT),width = 0.2,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("fROH")+facet_grid(rows=vars(variable),scales="free_y")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","#A6CEE3","#33A02C","grey"))+ theme(legend.position="none")



##Statistics:
#Individual heterozygosity (H) according to IUCN category (SHROT)
kruskal.test(H ~ SHORT, data = SONG_BIRDS_het)

	Kruskal-Wallis rank sum test

data:  H by SHORT
Kruskal-Wallis chi-squared = 181.16, df = 6, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_het$H, SONG_BIRDS_het$SHORT, p.adjust.method = "BH")

	Pairwise comparisons using Wilcoxon rank sum exact test 

data:  SONG_BIRDS_het$H and SONG_BIRDS_het$SHORT 

               CCAL    Delisted INYO    Not Threatened OREG    SCAL   
Delisted       0.00065 -        -       -              -       -      
INYO           0.00019 0.00386  -       -              -       -      
Not Threatened 3.9e-14 0.36646  1.2e-08 -              -       -      
OREG           1.1e-08 0.00386  0.00606 9.4e-09        -       -      
SCAL           4.0e-14 0.00115  1.4e-09 1.6e-08        1.4e-09 -      
Threatened     0.01641 0.03173  0.00011 1.1e-14        7.8e-06 0.11995

P value adjustment method: BH 


#Ancestral fROH by IUCN category
kruskal.test(F100 ~ SHORT, data = SONG_BIRDS_roh)

Kruskal-Wallis chi-squared = 148.95, df = 6, p-value < 2.2e-16

pairwise.wilcox.test(SONG_BIRDS_roh$F100, SONG_BIRDS_roh$SHORT, p.adjust.method = "bonf")

	Pairwise comparisons using Wilcoxon rank sum exact test 

data:  SONG_BIRDS_roh$F100 and SONG_BIRDS_roh$SHORT 

               CCAL    Delisted INYO    Not Threatened OREG    SCAL   
Delisted       1.00000 -        -       -              -       -      
INYO           4.4e-07 0.06176  -       -              -       -      
Not Threatened 2.7e-12 0.59916  1.6e-08 -              -       -      
OREG           2.5e-07 0.06176  1.00000 1.4e-08        -       -      
SCAL           0.09673 1.00000  6.9e-09 1.8e-07        6.9e-09 -      
Threatened     1.00000 1.00000  0.00021 3.4e-10        1.0e-04 1.00000

P value adjustment method: bonferroni 

	Pairwise comparisons using Wilcoxon rank sum exact test 

#Recent fROH by IUCN category
kruskal.test(F1MB ~ SHORT, data = SONG_BIRDS_roh)
	Kruskal-Wallis rank sum test

data:  F1MB by SHORT
Kruskal-Wallis chi-squared = 161.44, df = 6, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$F1MB, SONG_BIRDS_roh$SHORT, p.adjust.method = "bonf",exact=FALSE)

	Pairwise comparisons using Wilcoxon rank sum test with continuity correction 

data:  SONG_BIRDS_roh$F1MB and SONG_BIRDS_roh$SHORT 

               CCAL    Delisted INYO    Not Threatened OREG    SCAL   
Delisted       0.11174 -        -       -              -       -      
INYO           0.00605 0.20489  -       -              -       -      
Not Threatened < 2e-16 1.00000  3.2e-12 -              -       -      
OREG           1.00000 0.20489  0.00020 5.6e-11        -       -      
SCAL           0.36476 0.51665  0.00018 1.6e-14        1.00000 -      
Threatened     2.3e-05 1.00000  8.5e-07 6.2e-09        0.03806 0.07464



#fTOTAL by IUCN category (SHORT)

kruskal.test(Ftotal ~ SHORT, data = SONG_BIRDS_roh)

	Kruskal-Wallis rank sum test

data:  Ftotal by SHORT
Kruskal-Wallis chi-squared = 149.02, df = 6, p-value < 2.2e-16


data:  SONG_BIRDS_roh$Ftotal and SONG_BIRDS_roh$SHORT 

               CCAL    Delisted INYO    Not Threatened OREG    SCAL   
Delisted       0.94685 -        -       -              -       -      
INYO           2.0e-06 0.06176  -       -              -       -      
Not Threatened 9.2e-13 0.78668  2.8e-08 -              -       -      
OREG           2.1e-05 0.06176  1.00000 3.4e-08        -       -      
SCAL           0.11558 1.00000  1.3e-07 5.7e-08        1.4e-08 -      
Threatened     1.00000 1.00000  2.0e-05 1.2e-09        0.00016 1.00000

P value adjustment method: bonferroni 




