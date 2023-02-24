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
 pca1<-glPca(dace,nf=2,parallel = TRUE,n.cores = 4)
 meta<-read.table(" /Users/andrew/Library/CloudStorage/Box-Box/Foskett\ Dace\ Population\ Genetics/Files_popgen/info.txt")
 DACE<-cbind(pca1$scores,meta)
 ggplot(data=DACE,aes(y=PC2, x=PC1,group=V2,shape=V2))+geom_point(size=5,aes(fill=V2,shape=V2),colour="black",pch=21)+ theme_classic() + xlab("PC1 (15.5%)") +ylab("PC2 (6.0%)")+scale_fill_manual("Population", values =c("Coleman_Creek"="grey20","Dace_Spring"="grey","Deep_Creek"="grey40","Foskett_Spring"="grey92","Twentymile_Creek"="white"))
 ggsave("~/figure_3.svg")


