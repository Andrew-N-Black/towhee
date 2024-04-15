##########################################################################
###                          Samarth Mathur, PhD                        ###
###                       The Ohio State University                     ###
###                                                                     ###
###########################################################################
###########################################################################
###                     filterSNPs.sh                 			        ###
###########################################################################

library(tidyverse)
library(plyr)
library(dplyr)
library(reshape2)
library(tidyr)
library(ape)
library(writexl)
library(vcfR)

### Comment:
### Adding Waples contemporary Ne estimates would be very useful and help support the argument (i.e. line 524-525). 
### His 2016 paper adds an adjustment factor for genome data BUT I've written a script that simply randomly samples 
### the genome X number of times to calculate Ne (via R2) with SE. It works well and is quick and I'm happy to share via the editor, 
### as having pi (or long-term Ne) and contemporary Ne I think would help round-off the ROH patterns. That said, it's not difficult to write: 
### Waples (2006) equations are based on genotype correlations (R2) and you can apply the sample size correction of Waples et al. (2016). 
### All we did was randomly sample the VCF file to produce "unlinked" data of a desired size.

## Notes from Andrew Black:
## I filtered the BAM files by removing all reads within genic areas AND those that were +/1 100kb from the start / end of genic coordinates.

MAINDIR="/scratch/bell/mathur20/towhee"
workdir="/scratch/bell/mathur20/towhee/results/angsd"
outdir="/scratch/bell/mathur20/towhee/results/snps"

pops <- c("CCAL", "SCAL", "INYO", "OREG")


setwd(workdir)

snp_list <- list()
for (pop in pops)
{
    hwe <- read.table(gzfile(paste(pop,".hwe.gz",sep="")),header=T)
    hwe <- hwe %>%
    filter(p.value < 0.05)
    snp_list[[pop]] <- outbred

}

snps1 <- inner_join(snp_list[["CCAL"]],snp_list[["SCAL"]],
    by=c("Chromo", "Position"))

snps2 <- inner_join(snps1,snp_list[["INYO"]],
    by=c("Chromo", "Position"))

snps3 <- inner_join(snps2,snp_list[["OREG"]],
    by=c("Chromo", "Position"))

outbred.all <- snps3 %>%
    select(Chromo,Position)

write.table(outbred.all,paste(outdir,"allSample.outbred.filtered.snps.txt",sep="/"),quote=F,row.names=F)