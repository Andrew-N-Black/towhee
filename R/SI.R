#Load R packages
library(ggplot2)
library(readxl)

#Subet length of scaffolds and plot
length_scaff <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/Sequence_lengths_reference.xlsx")
new<-subset(length_scaff,LengthKB < 100,select=c(Contig,LengthKB))
ggplot(data=length_scaff, aes(y=LengthKB,x=reorder(LengthKB,Contig)))+geom_bar(stat="identity")+theme_classic()+ylab("Length (kb)")+xlab("Contig")+theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+ geom_hline(yintercept=100, linetype="dashed", color = "red")


ggsave("S1a.svg")
ggsave("S1a.pdf")

ggplot(data=new, aes(y=LengthKB,x=reorder(LengthKB,Contig)))+geom_bar(stat="identity")+theme_classic()+ylab("Length (kb)")+xlab("Contig")+theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+ geom_hline(yintercept=100, linetype="dashed", color = "red")
ggsave("S1aa.svg")
ggsave("S1aa.pdf")


#Pre/post breadth
depth_breadth <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")
depth_breadth$Pop <- factor(depth_breadth$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

ggplot(data=depth_breadth, aes(y=Breadth1x, x=reorder(SampleID,Breadth5x),fill=Pop))+geom_bar(stat="identity")+theme_classic()+xlab("Sample (N=81)")+ylab("1x Breadth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+facet_wrap(~Filter,ncol=1)+ scale_fill_brewer(palette="Paired")+theme(legend.title=element_blank())



#Pre/post Depth
depth_breadth <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")
depth_breadth$Pop <- factor(depth_breadth$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
ggplot(data=depth_breadth, aes(y=Depth, x=reorder(SampleID,Depth),fill=Pop))+geom_bar(stat="identity")+theme_classic()+xlab("Sample (N=81)")+ylab("Mean Depth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+ scale_fill_brewer(palette="Paired")+theme(legend.title=element_blank())+facet_wrap(~Filter,ncol=1)
ggsave("Figure_S4.svg")
ggsave("Figure_S4.pdf")

#Mean Depth
depth_breadth <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")
depth_breadth$Pop <- factor(depth_breadth$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
depth_breadth$Filter <- factor(depth_breadth$Filter, levels = c("Pre","Post"))
ggplot(data=depth_breadth, aes(y=Depth, x=reorder(SampleID,Depth),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("Mean Depth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())
ggsave("S1b.svg")
ggsave("S1b.pdf")

#Mean Breadth 1x
ggplot(data=depth_breadth, aes(y=Breadth1x, x=reorder(SampleID,Breadth1x),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("1x Breadth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+facet_wrap(~Filter,ncol=1)
ggsave("S1c.svg")
ggsave("S1c.pdf")


#Mean Breadth 5x
ggplot(data=depth_breadth, aes(y=Breadth5x, x=reorder(SampleID,Breadth5x),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("5x Breadth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+facet_wrap(~Filter,ncol=1)
ggsave("S1d.svg")
ggsave("S1d.pdf")

#Mapping rate
map <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/mapping_rate.xlsx")
map$Pop <- factor(map$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
ggplot(data=map, aes(y=MappingTotal, x=reorder(SampleID,MappingTotal),fill=Pop))+geom_bar(stat="identity")+theme_classic()+xlab("Sample (N=81)")+ylab("% Mapped Reads")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+ scale_fill_brewer(palette="Paired")+theme(legend.title=element_blank())
ggsave("S1e.svg")
ggsave("S1e.pdf")

ggplot(data=map, aes(y=MappingPaired, x=reorder(SampleID,MappingPaired),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("% Mapped Properly Paired Reads")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())

ggsave("S1f.svg")
ggsave("S1f.pdf")


#Figure S6, PCA

sample_pop_sites <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/het.xlsx")
sample_pop_sites$Pop <- factor(sample_pop_sites$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
sample_pop_sites <- read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/het.xlsx")
sample_pop_sites$Pop <- factor(sample_pop_sites$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
cov<-as.matrix(read.table("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/pca-towhee.cov"))
axes<-eigen(cov)
head(axes$values/sum(axes$values)*100)

x<-cbind(PC1_3,sample_pop_sites)
ggplot(data=x, aes(y=V2, x=V1,colour=Sites,shape=Pop))+geom_point(size=7)+ theme_classic() + xlab("PC1 (7.75%)") +ylab("PC2 (5.94%)")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+scale_shape_manual("Sites", values=c(4,20,10,23))+ scale_color_brewer(palette="Paired")+theme(legend.title=element_blank())
ggsave("~/Figure_S6.svg")
ggsave("~/Figure_S6.pdf")




#Phred score distribution (Fig_S3)

phred<-read.table("~/LEPC_full_qaNF.qs",header = T)
ggplot(phred, aes(x=qscore,y=counts)) + geom_bar(stat="identity")+theme_classic()+ scale_x_discrete(name ="Phred score",limits=c(13:37))+ylab("Number of bases") + geom_vline(xintercept = 30,linetype="dashed")
ggsave("~/phred_lepc.svg")
ggsave("~/phred_lepc.pdf")


#Figure S12
#PCA maf 0.10
cov<-as.matrix(read.table("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/pca-towhee.maf.10.cov"))
axes<-eigen(cov)
head(axes$values/sum(axes$values)*100)
[1] 8.037325 5.999671 4.231956 1.996710
[5] 1.894460 1.609028


PC1_3<-as.data.frame(axes$vectors[,1:3])
title1<-"Population"
title2<-"Site"

ggplot(data=PC1_3, aes(y=V2, x=V1))+geom_point(size=7,pch=21,aes(fill=sample_pop_sites$Pop))+ theme_classic() + xlab("PC1 (8.04%)") +ylab("PC2 (5.99%)")+geom_hline(yintercept=0,linetype="dashed")+geom_vline(xintercept =0,linetype="dashed")+ scale_fill_brewer(palette="Paired")+theme(legend.title=element_blank())

