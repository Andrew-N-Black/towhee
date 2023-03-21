library(reshape2)
library(readxl)
library(ggplot2)
library(pophelper)



#FIGURE 3
#Figure.3.pop <- read.csv("~/Figure 3 pop.txt", sep="")
sample_pop_sites <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/het.xlsx")
sample_pop_sites$Pop <- factor(sample_pop_sites$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
cov<-as.matrix(read.table("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/pca-towhee.cov"))
axes<-eigen(cov)
head(axes$values/sum(axes$values)*100)
#[1] 7.751829 5.941751 4.167590 2.001211

PC1_3<-as.data.frame(axes$vectors[,1:3])
title1<-"Population"
title2<-"Site"

#By Population
ggplot(data=PC1_3, aes(y=V2, x=V1))+geom_point(size=7,pch=21,aes(fill=sample_pop_sites$Pop))+ theme_classic() + xlab("PC1 (7.75%)") +ylab("PC2 (5.94%)")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_fill_manual("Population", values=c("darkorchid","tan2","black","cadetblue"))

ggsave("~/pca.towhee.svg")
ggsave("~/pca.towhee.pdf")

