#Heterozygosity
SONG_BIRDS_het <- read_excel("SONG_BIRDS.xlsx")
SONG_BIRDS_het$SHORT=as.factor(SONG_BIRDS_het$SHORT)

ggplot(SONG_BIRDS_het, aes(y=H, x=reorder(SHORT,H))) + geom_boxplot(aes(color=SHORT))+ geom_jitter(aes(color=SHORT),width = 0.2,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("H")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","#A6CEE3","#33A02C","grey"))+ theme(legend.position="none")+geom_hline(yintercept = 0.0017970595)

SONG_BIRDS_het$SHORT=as.factor(SONG_BIRDS_het$SHORT)
CCAL<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "CCAL", ]
Delisted<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "Delisted", ]
INYO<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "INYO", ]
Not_Threatened<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "Not Threatened", ]
OREG<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "OREG", ]
SCAL<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "SCAL", ]
Threatened<-SONG_BIRDS_het[ SONG_BIRDS_het$SHORT == "Threatened", ]


## ROH

library(readxl)
library(reshape2)
library(ggplot2)
SONG_BIRDS_roh <- read_excel("SONG_BIRDS-roh.xlsx")
roh<-melt(SONG_BIRDS_roh, id.vars = c("SHORT","Organism","N50"))
roh$SHORT=as.factor(roh$SHORT)
mean(roh$value)+2*sd(roh$value)
#[1] 0.1241392
ggplot(roh, aes(y=value, x=reorder(SHORT,value))) + geom_boxplot(aes(color=SHORT))+ geom_jitter(aes(color=SHORT),width = 0.2,alpha=0.5)+theme_bw()+xlab("")+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("fROH")+facet_grid(rows=vars(variable),scales="free_y")+
    scale_color_manual(values = c("#1F78B4","grey","#B2DF8A","grey","#A6CEE3","#33A02C","grey"))+ theme(legend.position="none")










SONG_BIRDS_long_filt <- read_excel("SONG_BIRDS-long-filt.xlsx")

SONG_BIRDS_long_filt$SHORT=as.factor(SONG_BIRDS_long_filt$SHORT)


mean(SONG_BIRDS_long_filt$F100)
0.04718723
sd(SONG_BIRDS_long_filt$F100)
0.07093977
0.04718723+2*0.07093977
0.1890668

ggplot(SONG_BIRDS_long_filt, aes(y=F100, x=reorder(SHORT,F100))) + geom_boxplot(outlier.colour = "grey")+ geom_jitter(width = 0.2,color="grey",alpha=0.5)+theme_bw()+xlab("")+geom_hline(yintercept = 0.139112226)+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("Short ROHs")+ylim(c(0,0.1890668))
ggsave("~/short-filt.svg")

levels(SONG_BIRDS_long_filt$SHORT)
[1] "CCAL"           "Delisted"       "INYO"          
[4] "Not Threatened" "OREG"           "SCAL"          
[7] "Threatened"

CCAL<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "CCAL", ]
Delisted<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "Delisted", ]
INYO<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "INYO", ]
Not_Threatened<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "Not Threatened", ]
OREG<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "OREG", ]
SCAL<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "SCAL", ]
Threatened<-SONG_BIRDS_long_filt[ SONG_BIRDS_long_filt$SHORT == "Threatened", ]


wilcox.test(INYO$Ftotal,Not_Threatened$Ftotal)


##LONG ROH
SONG_BIRDS_long_filt <- read_excel("SONG_BIRDS-long-filt.xlsx")

sd(SONG_BIRDS_long_filt$F1MB)
#[1] 0.04583629

mean(SONG_BIRDS_long_filt$F1MB)
0.01396362

0.01396362+2*0.04583629
ggplot(SONG_BIRDS_long_filt, aes(y=F1MB, x=reorder(SHORT,F1MB))) + geom_boxplot(outlier.colour = "grey")+ geom_jitter(width = 0.2,color="grey",alpha=0.5)+theme_bw()+xlab("")+geom_hline(yintercept = 0.04759638)+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("Long ROHs")+ylim(c(0,0.1056362))
ggsave("~/long-filt.svg")




#TOTAL FROH
SONG_BIRDS_long_filt <- read_excel("SONG_BIRDS-long-filt.xlsx")

mean(SONG_BIRDS_long_filt$Ftotal)
 #0.06115085
sd(SONG_BIRDS_long_filt$Ftotal)
 #0.11169
0.06115085+2*0.11169
#[1] 0.2845309


ggplot(SONG_BIRDS_long_filt, aes(y=Ftotal, x=reorder(SHORT,Ftotal))) + geom_boxplot(outlier.colour = "grey")+ geom_jitter(width = 0.2,color="grey",alpha=0.5)+theme_bw()+xlab("")+geom_hline(yintercept = 0.182110811)+theme_classic(base_size = 22)+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+ylab("Total ROHs")+ylim(c(0,0.2845309))
ggsave("~/total.svg")




0.182110811 #INYO MEAN





#Plot US species heterozygosity according to USFWS listing status
heterozygosity_passeriformes <- read_excel("heterozygosity_passeriformes_USFWS.xlsx")
ggplot(heterozygosity_passeriformes,aes(x=reorder(USFWS,H),y=H))+geom_boxplot()+theme_bw() + labs(x = "", y = "Heterozygosity")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("USFWS listing") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
    axis.title.y = element_text(size = 20))

#Plot all passerine species and towhee according to IUCN classification
heterozygosity_passeriformes <- read_excel("heterozygosity_passeriformes.xlsx")
ggplot(heterozygosity_passeriformes,aes(x=reorder(IUCN_long,H),y=H))+geom_boxplot()+theme_bw() + labs(x = "", y = "Heterozygosity")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))
heterozygosity_passeriformes[, as.list(summary(H)), by = IUCN_long]
               IUCN_long        Min.     1st Qu.      Median         Mean     3rd Qu.        Max.
                  <char>       <num>       <num>       <num>        <num>       <num>       <num>
1:         Least_Concern 0.001663000 0.003224500 0.005205200 0.0312419158 0.045700000 0.175070000
2:       Near_Threatened 0.001000000 0.001800000 0.002600000 0.0025525429 0.003233900 0.004200000
3: Critically_Endangered 0.000500000 0.004600000 0.004600000 0.0042666667 0.004625000 0.004700000
4:            Vulnerable 0.000200000 0.000850000 0.001300000 0.0027666667 0.002350000 0.010400000
5:            Endangered 0.000500000 0.000550000 0.000600000 0.0009666667 0.001200000 0.001800000
6:                  OREG 0.001593591 0.001648875 0.001707078 0.0016940771 0.001735707 0.001801201
7:                  SCAL 0.002340241 0.002424306 0.002470170 0.0024616562 0.002496708 0.002554755
8:                  CCAL 0.001675416 0.001984805 0.002025949 0.0020108766 0.002058755 0.002337212
9:                  INYO 0.001262391 0.001744430 0.001853835 0.0017970595 0.001885623 0.002069989


#Plot total fROH only for US species, according to USFWS status
passerine_roh_usfws <- read_excel("passerine_roh_usfws.xlsx")
ggplot(passerine_roh_usfws,aes(x=reorder(USFWS,`Total Froh`),y=`Total Froh`))+geom_boxplot()+theme_bw() + labs(x = "", y = "Total fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("USFWS Status") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot total fROH  for all species, according to IUCN Category 
passerine_roh_Total_IUCN <- read_excel("passerine_roh_Total_IUCN.xlsx")
ggplot(passerine_roh_Total_IUCN,aes(x=reorder(group,total),y=total))+geom_boxplot()+theme_bw() + labs(x = "", y = "Total fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot short fROH  for all species, according to IUCN Category
passerine_roh_short_IUCN <- read_excel("passerine_roh_short_IUCN.xlsx")
ggplot(passerine_roh_short_IUCN,aes(x=reorder(group,short),y=short))+geom_boxplot()+theme_bw() + labs(x = "", y = "Short fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot long fROH  for all species, according to IUCN Category
passerine_roh_long_IUCN <- read_excel("passerine_roh_long_IUCN.xlsx")
ggplot(passerine_roh_long_IUCN,aes(x=reorder(group,long),y=long))+geom_boxplot()+theme_bw() + labs(x = "", y = "Long fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))


#Summary SD
http://www.sthda.com/english/wiki/ggplot2-error-bars-quick-start-guide-r-software-and-data-visualization


data_summary <- function(data, varname, groupnames){
    require(plyr)
    summary_func <- function(x, col){
        c(mean = mean(x[[col]], na.rm=TRUE),
          sd = sd(x[[col]], na.rm=TRUE))
    }
    data_sum<-ddply(data, groupnames, .fun=summary_func,
                    varname)
    data_sum <- rename(data_sum, c("mean" = varname))
    return(data_sum)
}

df2 <- data_summary(test, varname="H",groupnames=c("Organism","IUCN"))
df2$IUCN=as.factor(df2$IUCN)
df2$Organism=as.factor(df2$Organism)

ggplot(df2, aes(y=H, x=reorder(Organism,H))) + geom_point()+coord_flip()+theme_bw()


ggplot(df2, aes(y=H, x=reorder(Organism,H),color=IUCN)) + 
    geom_line() +
    geom_point(size=3)+
    geom_errorbar(aes(ymin=H-sd, ymax=H+sd), width=.2,
                  position=position_dodge(0.05))+coord_flip()+theme_classic()

#By binary (plus towhee) categories
ggplot(test, aes(y=H, x=reorder(USFWS,H))) + geom_boxplot(outlier.shape=16,outlier.size=2, notch=FALSE)+ geom_jitter(width = 0.2,color="grey",alpha=0.5)+theme_bw()+xlab("")
