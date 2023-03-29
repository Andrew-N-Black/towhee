
library(qqman)
library(svglite)

slidingwindow_CCAL_INYO <- read.delim("~/slidingwindow_CCAL_INYO")
svglite("CCAL_INYO.svg", width = 6, height = 4)
manhattan(slidingwindow_CCAL_INYO, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()


slidingwindow_INYO_SCAL <- read.delim("~/slidingwindow_INYO_SCAL")
svglite("NYO_SCAL.svg", width = 6, height = 4)
manhattan(slidingwindow_INYO_SCAL, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()

slidingwindow_OREG_SCAL <- read.delim("~/slidingwindow_OREG_SCAL")
svglite("OREG_SCAL.svg", width = 6, height = 4)
manhattan(slidingwindow_OREG_SCAL, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()

slidingwindow_CCAL_SCAL <- read.delim("~/slidingwindow_CCAL_SCAL")
svglite("CCAL_SCAL.svg", width = 6, height = 4)
manhattan(slidingwindow_CCAL_SCAL, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()

slidingwindow_OREG_CCAL <- read.delim("~/slidingwindow_OREG_CCAL")
svglite("OREG_CCAL.svg", width = 6, height = 4)
manhattan(slidingwindow_OREG_CCAL, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()

slidingwindow_OREG_INYO <- read.delim("~/slidingwindow_OREG_INYO")
svglite("OREG_INYO.svg", width = 6, height = 4)
manhattan(slidingwindow_OREG_INYO, chr="chr", bp="midPos", snp="chr_region",suggestiveline = FALSE,p="Fst",ylim=c(0,1),logp=FALSE,ylab="Fst",xlab="Contig")
dev.off()
