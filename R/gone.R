#Quick plot of all regions:
Ne <- read_excel("Ne.xlsx")
Ne$Pop <- factor(Ne$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
ggplot()+geom_line(data=Ne, aes(x=(Generation),y=Geometric_mean,color=Pop), lwd=.9,linetype="solid")+theme_bw()+xlab("generation")+ylab("Effective Population Size")+scale_y_continuous(trans='log10')+scale_x_continuous(trans='log10')+ scale_color_brewer(palette="Paired")





##Plot derived from:https://github.com/martykardos/KillerWhaleInbreeding/blob/main/FigureCode/rCode_Fig_ED_1.R
#Focus on the first 50 generations:

par(xpd=FALSE,mfrow=c(1,1))
library(scales)
library(matrixStats)



plot(c(0,50),c(0,1000),type="n",xlab="Generations back in time",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")),
     cex.lab=1.5)

setwd("~/")
files <- paste("INYO_outfileLD_TEMP/outfileLD_",1:500,"_GONE_Nebest",sep="")
NeMat <- NULL
for(i in 1:500){
    dat <- read.table(files[i],skip=2)
    NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=500,ncol=2)
NeCI2 <- matrix(NA,nrow=500,ncol=2)

for(i in 1:500){
    NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
    NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.25,0.75))
}
lines(1:500,rowMedians(NeMat[1:500,]),col="#B2DF8A",lwd=4)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI[1:500,1],rev(NeCI[1:500,2])),col=adjustcolor("#B2DF8A",alpha.f=0.2),border=NA)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI2[1:500,1],rev(NeCI2[1:500,2])),col=adjustcolor("#B2DF8A",alpha.f=0.3),border=NA)





#########Expand to 150###############
plot(c(0,150),c(0,5000),type="n",xlab="Generations back in time",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")),
     cex.lab=1.5)

setwd("~/")
files <- paste("INYO_outfileLD_TEMP/outfileLD_",1:500,"_GONE_Nebest",sep="")
NeMat <- NULL
for(i in 1:500){
    dat <- read.table(files[i],skip=2)
    NeMat <- cbind(NeMat,dat[,2])
}

# get CI
NeCI <- matrix(NA,nrow=500,ncol=2)
NeCI2 <- matrix(NA,nrow=500,ncol=2)

for(i in 1:500){
    NeCI[i,] <- quantile(NeMat[i,],probs=c(0.025,0.975))
    NeCI2[i,] <- quantile(NeMat[i,],probs=c(0.25,0.75))
}
lines(1:500,rowMedians(NeMat[1:500,]),col="#B2DF8A",lwd=4)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI[1:500,1],rev(NeCI[1:500,2])),col=adjustcolor("#B2DF8A",alpha.f=0.2),border=NA)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI2[1:500,1],rev(NeCI2[1:500,2])),col=adjustcolor("#B2DF8A",alpha.f=0.3),border=NA)
#########################################
##PLOT DERIVED FROM:https://github.com/edegreef/arctic-whales-resequencing/blob/main/demography/gone/04-GONE_plot.R
library(tidyverse)

## Using the 500 iterations to make a 95% confidence interval (based off of Kardos et al. 2023's script: https://github.com/martykardos/KillerWhaleInbreeding/blob/main/FigureCode/rCode_Fig_ED_1.R)

library(scales)
library(matrixStats)


####### 
setwd("~/")

data <- read.csv("~/Output_Ne_INYO-DOC5-20E.renamed.genoE", row.names=NULL, sep="")

# going to look at within last 200 generations
data <- subset(data[1:200,])



# quick plot of the means
Ne <- read_excel("Ne.xlsx")
Ne$Pop <- factor(Ne$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
ggplot()+geom_line(data=Ne, aes(x=(Generation),y=Geometric_mean,color=Pop), lwd=.9,linetype="solid")+theme_bw()+xlab("generation")+ylab("Effective Population Size")+scale_y_continuous(trans='log10')+scale_x_continuous(trans='log10')+ scale_color_brewer(palette="Paired")

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

