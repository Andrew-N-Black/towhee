#Heterozygosity

##Full IUCN classification:
library(readxl)
library(reshape2)
library(ggplot2)
H <- read_excel("H.xlsx", col_types = c("text", "text", "numeric"))
H$IUCN=as.factor(H$IUCN)

#Full IUCN classification
ggplot(H, aes(y=H, x=reorder(IUCN,H))) + geom_boxplot(aes(color=IUCN))+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("H")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","grey","#33A02C","#A6CEE3","grey"))+ theme(legend.position="none")+geom_hline(yintercept = 0.0017970595,linetype="dashed")+stat_summary(fun.y = median, fun.ymax = length,geom = "text", aes(label = ..ymax..), vjust = -1)+ylim(0,0.015)
ggsave("~/FigureX.svg")

#Binary IUCN classification
H <- read_excel("H.xlsx", col_types = c("text", "text", "text", "numeric"))
H$IUCN=as.factor(H$IUCN)

ggplot(H, aes(y=H, x=reorder(SHORT,H))) + geom_boxplot(aes(color=SHORT))+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("H")+
    scale_color_manual(values = c("#1F78B4","#B2DF8A", "grey", "#A6CEE3","#33A02C","grey"))+ theme(legend.position="none")+geom_hline(yintercept = 0.0017970595,linetype="dashed")+ylim(0,0.025)+stat_summary(fun.y = median, fun.ymax = length,geom = "text", aes(label = ..ymax..), vjust = -1)
ggsave("~/FigureX_shortlist.svg")




#Individual heterozygosity (H) according to IUCN category 
kruskal.test(H$H, H$SHORT, p.adjust.method = "bonf",exact=FALSE)

	Kruskal-Wallis rank sum test

data:  H$H and H$SHORT
Kruskal-Wallis chi-squared = 193.28, df =
5, p-value < 2.2e-16

pairwise.wilcox.test(H$H, H$SHORT, p.adjust.method = "bonf",exact=FALSE)

     CCAL    EN      INYO    LC      NT     OREG    SCAL  
EN   1.0000  -       -       -       -      -       -     
INYO 0.0057  1.0000  -       -       -      -       -     
LC   5.1e-15 6.9e-11 5.7e-08 -       -      -       -     
NT   1.0000  1.0000  1.0000  1.0000  -      -       -     
OREG 1.4e-05 0.2233  0.1753  4.0e-08 1.0000 -       -     
SCAL 1.8e-08 1.0000  1.4e-05 3.8e-09 1.0000 1.4e-05 -     
VU   1.0000  1.0000  3.7e-05 4.0e-07 1.0000 1.9e-06 0.0178

* <0.05
** <0.001
** <0.0001

## ROH

#Full IUCN categories
library(readxl)
library(reshape2)
library(ggplot2)
SONG_BIRDS_roh <- read_excel("~/ROH.xlsx")
roh<-melt(SONG_BIRDS_roh, id.vars = c("Species","IUCN","SHORT"))
roh$IUCN=as.factor(roh$IUCN)
ggplot(roh, aes(y=value, x=reorder(IUCN,value))) + geom_boxplot(aes(color=IUCN))+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("fROH")+facet_wrap(~variable, scales = "free_y")+
    scale_color_manual(values =c("#1F78B4","grey","#B2DF8A","grey","grey","#33A02C","#A6CEE3","grey"))+ theme(legend.position="none")+stat_summary(fun.y = median, fun.ymax = length,geom = "text", aes(label = ..ymax..), vjust = 1)+ylim(0,0.45)


#Binary IUCN categories
library(readxl)
library(reshape2)
library(ggplot2)
SONG_BIRDS_roh <- read_excel("~/SONG_BIRDS-rohC.xlsx")
roh<-melt(SONG_BIRDS_roh, id.vars = c("Organism","SHORT","N50"))
roh$SHORT=as.factor(roh$SHORT)
ggplot(roh, aes(y=value, x=reorder(SHORT,value))) + geom_boxplot(aes(color=SHORT))+ geom_jitter(aes(color=SHORT),width = 0.4,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("fROH")+facet_grid(~variable,scales = "free",)+
    scale_color_manual(values =c("#1F78B4","#B2DF8A","grey","#A6CEE3","#33A02C","grey","grey"))+ theme(legend.position="none")


#Ancestral fROH by IUCN category
kruskal.test(KB ~ IUCN, data = SONG_BIRDS_roh)

	Kruskal-Wallis rank sum test

data:  KB by IUCN
Kruskal-Wallis chi-squared =
135.96, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$KB, SONG_BIRDS_roh$SHORT, p.adjust.method = "bonf",exact=FALSE)

data:  SONG_BIRDS_roh$KB and SONG_BIRDS_roh$IUCN 

     CCAL    EN      INYO    LC      NT      OREG    SCAL   
EN   4.5e-08 -       -       -       -       -       -      
INYO 3.4e-05 6.1e-06 -       -       -       -       -      
LC   4.1e-07 1.00000 2.9e-06 -       -       -       -      
NT   1.00000 0.89909 0.27444 1.00000 -       -       -      
OREG 2.7e-05 6.1e-06 1.00000 4.8e-06 0.27444 -       -      
SCAL 0.14730 1.9e-05 1.4e-05 0.00156 1.00000 1.4e-05 -      
VU   0.00019 4.0e-09 0.10792 3.1e-10 0.55839 0.02921 9.1e-07

* <0.05
** <0.001
** <0.0001

P value adjustment method: bonferroni 

#Recent fROH by IUCN category
kruskal.test(MB ~ IUCN, data = SONG_BIRDS_roh)
	Kruskal-Wallis rank sum test

data:  MB by IUCN
Kruskal-Wallis chi-squared = 162.41, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$MB, SONG_BIRDS_roh$IUCN, p.adjust.method = "bonf",exact=FALSE)

     CCAL    EN      INYO    LC      NT     OREG   SCAL  
EN   7.8e-09 -       -       -       -      -      -     
INYO 0.0149  1.6e-06 -       -       -      -      -     
LC   2.0e-14 1.0000  6.8e-10 -       -      -      -     
NT   0.1490  1.0000  0.2732  1.0000  -      -      -     
OREG 1.0000  8.9e-06 0.0020  8.0e-08 0.2732 -      -     
SCAL 0.5118  4.6e-07 0.0012  2.6e-10 0.6889 1.0000 -     
VU   0.9282  5.4e-08 4.3e-05 8.4e-13 0.2717 1.0000 1.0000

* <0.05
** <0.001
** <0.0001
#fTOTAL by IUCN category (SHORT)

kruskal.test(TOTAL ~ IUCN, data = SONG_BIRDS_roh)

	Kruskal-Wallis rank sum test

data:  TOTAL by IUCN
Kruskal-Wallis chi-squared = 138.19, df = 7, p-value < 2.2e-16


pairwise.wilcox.test(SONG_BIRDS_roh$TOTAL, SONG_BIRDS_roh$IUCN, p.adjust.method = "bonf",exact=FALSE)

data:  SONG_BIRDS_roh$TOTAL and SONG_BIRDS_roh$IUCN 

     CCAL    EN      INYO    LC      NT      OREG    SCAL   
EN   3.3e-08 -       -       -       -       -       -      
INYO 7.3e-05 6.1e-06 -       -       -       -       -      
LC   3.0e-08 1.00000 1.8e-06 -       -       -       -      
NT   1.00000 0.89909 0.27444 1.00000 -       -       -      
OREG 0.00027 6.1e-06 1.00000 9.0e-06 0.27444 -       -      
SCAL 0.17373 1.2e-05 3.1e-05 0.00027 1.00000 1.6e-05 -      
VU   0.09374 4.5e-09 0.00369 3.8e-10 0.27185 0.05470 0.00011

* <0.05
** <0.001
** <0.0001

