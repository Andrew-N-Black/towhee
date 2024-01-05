library(pophelper)
labels <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/labels.xlsx")

#Maf 0.05
list<-readQ(files ="/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/pca-towhee.admix.4.Q")
plotQ(list,returnplot=T,exportplot=T,clustercol=c("cadetblue","tan2","darkorchid","black"),grplab=labels,ordergrp=T,showlegend=F,height=3,indlabsize=1,indlabheight=0,indlabspacer=0,barbordercolour="black",divsize = 0.1,grplabsize=1.3,barbordersize=0,linesize=0.4,showsp = F,splabsize = .1,outputfilename="plotq",imgtype="png",exportpath=getwd(),splab = "K=4",divcol = "black",splabcol="black",grplabheight=0.1,grplabjust = 0.5, grplabangle = 45)

#MAF 0.10
list<-readQ(files ="/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/pca-towhee.maf.10.admix.4.Q")
plotQ(list,returnplot=T,exportplot=T,clustercol=c("#A6CEE3","#1F78B4","#B2DF8A","#33A02C","#FB9A99"),grplab=labels,ordergrp=T,showlegend=F,height=3,indlabsize=1,indlabheight=0,indlabspacer=0,barbordercolour="black",divsize = 0.1,grplabsize=1.3,barbordersize=0,linesize=0.4,showsp = F,splabsize = .1,outputfilename="plotq",imgtype="png",exportpath="~/",splab = "K=4",divcol = "black",splabcol="black",grplabheight=0.1,grplabjust = 0.5, grplabangle = 45)
