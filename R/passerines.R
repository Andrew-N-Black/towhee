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
