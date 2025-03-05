##Plot derived from:https://github.com/martykardos/KillerWhaleInbreeding/blob/main/FigureCode/rCode_Fig_ED_1.R
#Focus on the first 50 generations:

par(xpd=FALSE,mfrow=c(1,1))
library(scales)
library(matrixStats)

#SCAL
plot(c(0,100),c(0,5000000),type="n",xlab="Generations back in time",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")),
     cex.lab=1.5)
files <- paste("SCAL_outfileLD_TEMP/outfileLD_",1:500,"_GONE_Nebest",sep="")
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
lines(1:500,rowMedians(NeMat[1:500,]),col="#33A02C",lwd=4)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI[1:500,1],rev(NeCI[1:500,2])),col=adjustcolor("#33A02C",alpha.f=0.2),border=NA)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI2[1:500,1],rev(NeCI2[1:500,2])),col=adjustcolor("#33A02C",alpha.f=0.3),border=NA)
par(xpd=FALSE,mfrow=c(1,1))


#CCAL
plot(c(0,100),c(0,5000000),type="n",xlab="Generations back in time",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")),
     cex.lab=1.5)
files <- paste("CCAL_outfileLD_TEMP/outfileLD_",1:500,"_GONE_Nebest",sep="")
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
lines(1:500,rowMedians(NeMat[1:500,]),col="#33A02C",lwd=4)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI[1:500,1],rev(NeCI[1:500,2])),col=adjustcolor("#33A02C",alpha.f=0.2),border=NA)
polygon(x=c(1:500,rev(1:500)),y=c(NeCI2[1:500,1],rev(NeCI2[1:500,2])),col=adjustcolor("#33A02C",alpha.f=0.3),border=NA)
par(xpd=FALSE,mfrow=c(1,1))


#INYO
plot(c(0,100),c(0,1000),type="n",xlab="Generations back in time",ylab=expression(paste("Historical ",italic(""*N*"")[e],sep="")),
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



