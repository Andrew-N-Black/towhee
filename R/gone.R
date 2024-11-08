

library(tidyverse)

## Using the 500 iterations to make a 95% confidence interval (based off of Kardos et al. 2023's script: https://github.com/martykardos/KillerWhaleInbreeding/blob/main/FigureCode/rCode_Fig_ED_1.R)

library(scales)
library(matrixStats)


####### Bowhead
setwd("~/")

data <- read.csv("~/Output_Ne_INYO-DOC5-20E.renamed.genoE", row.names=NULL, sep="")

# going to look at within last 200 generations
data <- subset(data[1:200,])

# quick plot of the means
ggplot()+
    geom_line(data=ne, aes(x=(Generation),y=Geometric_mean), color="#B2DF8A", lwd=1.5)+
    theme_bw()+
    xlim(0,100)+
    xlab("generation")+ylab("Effective Population Size")+scale_y_continuous(trans='log10')+scale_x_continuous(trans='log10')
    

# load all the iteration files and put it in a matrix
files <- paste("outfileLD_TEMP/outfileLD_",1:500,"_GONE_Nebest",sep="")
# create empty matrix
NeMat <- NULL

# fill in matrix with all the info from the iterations
for(i in 1:500){
  dat <- read.table(files[i],skip=2)
  NeMat <- cbind(NeMat,dat[,2])
}

# get CI for the recent 200 generations
NeCI <- matrix(NA,nrow=789,ncol=2)
for(i in 1:789){
  NeCI[i,] <- quantile(NeMat[i,],probs=c(0.05,0.95))
}

# set up data to get ready for ggplot
NeCI_dat <- as.data.frame(NeCI)
NeCI_dat$Generation <- 1:nrow(NeCI_dat)

Ne_med <- as.data.frame(rowMedians(NeMat[1:789,]))
colnames(Ne_med) <- "median"
Ne_med$Generation <- 1:nrow(Ne_med)

ggplot()+
    geom_ribbon(data=NeCI_dat, aes(x=Generation, ymin=V1, ymax=V2), fill="#ffe38c", alpha=0.5)+
    geom_line(data=Ne_med, aes(x=(Generation),y=median), color="#B2DF8A", lwd=1.5)+
    theme_bw()+
    xlab("Generations")+
    theme(panel.grid.minor = element_blank(),panel.grid.major = element_blank())+ylab(expression(paste("Effective population size")))+
ylab(expression(paste("Effective population size (")*10^{3}*")"))+ylim(0,4000)+scale_y_continuous(trans='log10')+scale_x_continuous(trans='log10')+xlim(0,150)+ylim(50,1200)

