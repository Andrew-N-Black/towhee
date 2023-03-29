library(pophelper)
labels <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/labels.xlsx")

list<-readQ(files ="~/pca-towhee.admix.4.Q")
plotQ(slist,returnplot=T,exportplot=T,clustercol=c("blue","bisque","darkolivegreen3","darkorchid1"),grplab=labels,ordergrp=T,showlegend=F,height=6,indlabsize=1.8,indlabheight=0.8,indlabspacer=1,barbordercolour="black",divsize = 0.1,grplabsize=3,barbordersize=0,linesize=0.4,showsp = F,splabsize = 8,outputfilename="plotq",imgtype="png",exportpath=getwd(),splab = "K=4",divcol = "black",splabcol="black",grplabheight=5,grplabjust = 0.5, grplabangle = 45)
