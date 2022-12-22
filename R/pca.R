library(reshape2)
library(readxl)
library(ggplot2)
library(pophelper)



#FIGURE 3
Figure.3.pop <- read.csv("~/Figure 3 pop.txt", sep="")
sample_pop_sites <- read_excel("sample-pop-sites.xlsx")
cov<-as.matrix(read.table("Figure 3.cov"))
head(axes$values/sum(axes$values)*100)
#[1] 7.633992 5.665231 4.160406 2.030399 1.893622
PC1_3<-as.data.frame(axes$vectors[,1:3])
title1<-"Region"
title2<-"site"
x<-cbind(PC1_3,sample_pop_sites)
ggplot(data=x,aes(y=V2, x=V1, color=Pop))+geom_point(size=5,aes(fill=Pop),colour="black",pch=21)+ theme_classic() + xlab("PC1 (7.63%)") +ylab("PC2 (5.66%)")+scale_fill_manual(title1, values =c("INYO"="black","CCAL"="bisque","OREG"="azure4","SCAL"="cadetblue"))
ggsave("~/figure_3.svg")


