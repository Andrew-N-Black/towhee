#Heterozygosity
library(readxl)
library(reshape2)
library(ggplot2)
H <- read_excel("H.xlsx", col_types = c("text", "text", "numeric"))
H$IUCN=as.factor(H$IUCN)

ggplot(H, aes(y=H, x=reorder(IUCN,H))) + geom_boxplot(aes(color=IUCN))+ geom_jitter(aes(color=IUCN),width = 0.2,alpha=0.9,size=3)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("H")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","grey","#33A02C","#A6CEE3","grey"))+ theme(legend.position="none")+geom_hline(yintercept = 0.0017970595,linetype="dashed")
ggsave("~/FigureX.svg")

#Individual heterozygosity (H) according to IUCN category 
kruskal.test(H ~ IUCN, data = H)

	Kruskal-Wallis rank sum test

data:  H by IUCN
Kruskal-Wallis chi-squared =
197.3, df = 7, p-value <
2.2e-16

     CCAL    EN      INYO    LC      NT      OREG    SCAL   
EN   0.13768 -       -       -       -       -       -      
INYO 0.00018 0.07044 -       -       -       -       -      
LC   5.1e-15 2.3e-11 6.3e-09 -       -       -       -      
NT   0.14951 0.14263 0.17642 0.11096 -       -       -      
OREG 6.8e-09 0.01197 0.00916 4.9e-09 0.17642 -       -      
SCAL 4.5e-14 0.69603 1.3e-09 7.6e-10 0.15580 1.3e-09 -      
VU   0.06652 0.74604 8.5e-08 3.6e-08 0.69603 9.5e-11 0.00091

## ROH

library(readxl)
library(reshape2)
library(ggplot2)
SONG_BIRDS_roh <- read_excel("~/ROH.xlsx")
roh<-melt(SONG_BIRDS_roh, id.vars = c("Species","IUCN")))
roh$IUCN=as.factor(roh$IUCN)
ggplot(roh, aes(y=value, x=reorder(IUCN,value))) + geom_boxplot(aes(color=IUCN))+ geom_jitter(aes(color=IUCN),width = 0.4,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("fROH")+facet_grid(~variable,scales = "free_y",)+
    scale_color_manual(values =c("#1F78B4","grey","#B2DF8A","grey","grey","#33A02C","#A6CEE3","grey"))+ theme(legend.position="none")




#Ancestral fROH by IUCN category
kruskal.test(KB ~ IUCN, data = SONG_BIRDS_roh)

	Kruskal-Wallis rank sum test

data:  KB by IUCN
Kruskal-Wallis chi-squared =
135.96, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$KB, SONG_BIRDS_roh$IUCN, p.adjust.method = "bonf")

data:  SONG_BIRDS_roh$KB and SONG_BIRDS_roh$IUCN 

     CCAL    EN      INYO    LC      NT     OREG    SCAL   
EN   5.9e-11 -       -       -       -      -       -      
INYO 5.9e-07 1.6e-09 -       -       -      -       -      
LC   4.1e-07 1.0000  2.9e-06 -       -      -       -      
NT   1.0000  0.7310  0.0824  1.0000  -      -       -      
OREG 3.3e-07 1.6e-09 1.0000  4.8e-06 0.0824 -       -      
SCAL 0.1290  1.4e-06 9.2e-09 0.0016  1.0000 9.2e-09 -      
VU   5.8e-05 7.6e-15 0.0849  3.1e-10 0.3500 0.0184  8.5e-09

P value adjustment method: bonferroni 

#Recent fROH by IUCN category
kruskal.test(MB ~ IUCN, data = SONG_BIRDS_roh)
	Kruskal-Wallis rank sum test

data:  MB by IUCN
Kruskal-Wallis chi-squared = 162.41, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$MB, SONG_BIRDS_roh$IUCN, p.adjust.method = "bonf")

	CCAL    EN      INYO    LC      NT      OREG    SCAL   
EN   7.8e-09 -       -       -       -       -       -      
INYO 0.00806 1.6e-06 -       -       -       -       -      
LC   2.0e-14 1.00000 6.8e-10 -       -       -       -      
NT   0.14899 1.00000 0.27318 1.00000 -       -       -      
OREG 1.00000 8.9e-06 0.00027 8.0e-08 0.27318 -       -      
SCAL 0.48635 4.6e-07 0.00024 2.6e-10 0.68887 1.00000 -      
VU   0.90811 5.4e-08 8.6e-07 8.4e-13 0.27166 1.00000 1.00000


#fTOTAL by IUCN category (SHORT)

kruskal.test(TOTAL ~ IUCN, data = SONG_BIRDS_roh)

	Kruskal-Wallis rank sum test

data:  TOTAL by IUCN
Kruskal-Wallis chi-squared = 138.19, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$TOTAL, SONG_BIRDS_roh$IUCN, p.adjust.method = "bonf")

data:  SONG_BIRDS_roh$TOTAL and SONG_BIRDS_roh$IUCN 

     CCAL    EN      INYO    LC      NT      OREG    SCAL   
EN   2.9e-11 -       -       -       -       -       -      
INYO 2.7e-06 1.6e-09 -       -       -       -       -      
LC   3.0e-08 1.00000 1.8e-06 -       -       -       -      
NT   1.00000 0.73103 0.08235 1.00000 -       -       -      
OREG 2.8e-05 1.6e-09 1.00000 9.0e-06 0.08235 -       -      
SCAL 0.15411 6.3e-07 1.7e-07 0.00027 1.00000 1.8e-08 -      
VU   0.08074 1.5e-14 0.00132 3.8e-10 0.07903 0.03870 2.2e-05

