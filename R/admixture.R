
library(reshape2)
library(readxl)
library(ggplot2)
library(pophelper)

setwd("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/towhee_admix/")

labels <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/labels.xlsx")
#sample_pop_sites <- read_excel("sample-pop-sites.xlsx")
#both <- as.data.frame(sample_pop_sites[,c(2,3)])
#bothT <- as.data.frame(sample_pop_sites[,c(3,2)])

slist<-readQ(files =c("pop_K3-combined-merged.Q","pop_K4-combined-merged.Q","pop_K5-combined-merged.Q"))

#palette.colors(8,"Paired")
#[1] "#A6CEE3" "#1F78B4" "#B2DF8A"
#[4] "#33A02C" "#FB9A99" "#E31A1C"
#[7] "#FDBF6F" "#FF7F00"
plotQ(slist[1:3],returnplot=T,exportplot=T,imgoutput = "join",clustercol=c("#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99"),grplab=labels,ordergrp=T,showlegend=F,height=.6,indlabsize=1.8,indlabheight=0.08,indlabspacer=1,barbordercolour="black",divsize = 0.1,grplabsize=0.6,barbordersize=0,linesize=0.4,showsp = F,splabsize = 0,outputfilename="plotq",imgtype="pdf",exportpath=getwd(),splab = c("K=3","K=4","K=5"),divcol = "black",splabcol="black",grplabheight=1.5,grplabangle =45)


#MAF 0.10
setwd("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/")
slist<-readQ(files =c("pop_K3-combined-mergedMAF.10.txt","pop_K4-combined-mergedMAF.10.txt","pop_K5-combined-mergedMAF.10.txt"))

#Only singletons removed
slist<-readQ(files =c("~/K_3_singleton.txt","~/K4_singletons.txt","~/K5_singletons.txt"))

