
library(reshape2)
library(readxl)
library(ggplot2)
library(pophelper)


sample_pop_sites <- read_excel("sample-pop-sites.xlsx")
both <- as.data.frame(sample_pop_sites[,c(2,3)])
bothT <- as.data.frame(sample_pop_sites[,c(3,2)])

slist<-readQ(files =c("k2.qopt","k3.qopt","k4.qopt","k5.qopt","k6.qopt"))
plotQ(slist[1:5],returnplot=T,exportplot=T,imgoutput = "join",clustercol=c("black","cadetblue","azure4","bisque","grey","blue"),grplab=bothT,ordergrp=T,showlegend=F,height=.6,indlabsize=1.8,indlabheight=0.08,indlabspacer=1,barbordercolour="black",divsize = 0.1,grplabsize=0.6,barbordersize=0,linesize=0.4,showsp = F,splabsize = 0,outputfilename="plotq",imgtype="png",exportpath=getwd(),splab = c("K=2","K=3","K=4","K=5","K=6"),divcol = "black",splabcol="black",grplabheight=1.5,grplabangle =45)




