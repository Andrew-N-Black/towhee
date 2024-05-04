library(plyr)
library(dplyr)
library(ggplot2)
library(DataCombine)
library(detectRUNS)
library(gridExtra)
library(stringr)

setwd("/scratch/bell/mathur20/towhee/results/ngsLD/shuff")
popInfo <- read.csv("../sampleinfo.csv",header =T)
popInfo <- popInfo[,c(1:3)]


df.ldne <- NULL
for (i in stringr::str_pad(1:999, width = 3, pad = "0"))
{
  for (pop in unique(popInfo$Location))
  {
    df <- read.csv(paste(pop,i,".txt",sep = ""),header = F,sep = "\t")
    colnames(df) <- c("snp1", "snp2", "distance","r2","D","Dprime","R2","samp","a","b","c","d","e","f","g","h","j","k","l")
    rawR2 <- mean(df$r2)
    sampSize <- median(df$samp)
    primeR2 <- rawR2 - 0.0018 - (0.907/sampSize) - (4.44/(sampSize)^2)
    df.r2 <- data.frame(Pop=pop,Run=i,primeR2=primeR2)
    df.ldne <- rbind(df.ldne,df.r2)
  }
}

write.csv(df.ldne,"df.ldne.csv",quote = F, row.names = F)

### From Robin Waples (2006)
# If primeR2<0, thenall the disequilibrium can be explained by sampling error and the appropriate estimate of Ne is infinite.
# If, primeR2 is large, the square-root term can be negative; this implies small Ne,and an approximate estimate is :

## Ne = (1/3)/(2*primeR2) for random mating
df.ldne <- read.csv("df.ldne.csv",header=T)

ldne <- NULL
for (i in 1:dim(df.ldne)[1])
{
  sqrt_term <- 0.308^2 - 2.08*df.ldne$primeR2[i]
  if (sqrt_term > 0)
  {
    ldne[i] <- (0.308+(0.308^2 - 2.08*df.ldne$primeR2[i])^0.5)/(2*df.ldne$primeR2[i])
  }
  if (sqrt_term < 0)
  {
    ldne[i] <- (1/3)/(2*df.ldne$primeR2[i])
  }
}




df.ldne <- cbind(df.ldne,ldne)
df.ldne.mean <- ddply(df.ldne, "Pop", summarise, meanldNe=mean(ldne),sdldNe=sd(ldne))
print(df.ldne.mean)