#Load R packages
library(ggplot2)
library(readxl)

#Subet length of scaffolds and plot
length_scaff <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/Sequence_lengths_reference.xlsx")
ggplot(data=length_scaff, aes(y=LengthKB,x=reorder(LengthKB,Contig)))+geom_bar(stat="identity")+theme_classic()+ylab("Length (kb)")+xlab("Contig")+theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+ geom_hline(yintercept=100, linetype="dashed", color = "red")


ggsave("S1a.svg")
ggsave("S1a.pdf")




#Pre/post breadth
depth_breadth <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")
depth_breadth$Pop <- factor(depth_breadth$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

ggplot(data=depth_breadth, aes(y=Breadth5x, x=reorder(SampleID,Breadth5x),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("5x Breadth")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())+facet_wrap(~Filter,ncol=1)


#Mean Depth
depth_breadth <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")
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
map <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/mapping_rate.xlsx")
map$Pop <- factor(map$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))
ggplot(data=map, aes(y=MappingTotal, x=reorder(SampleID,MappingTotal),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("% Mapped Reads")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())
ggsave("S1e.svg")
ggsave("S1e.pdf")

ggplot(data=map, aes(y=MappingPaired, x=reorder(SampleID,MappingPaired),fill=Pop))+geom_bar(stat="identity")+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+xlab("Sample (N=81)")+ylab("% Mapped Properly Paired Reads")+theme( axis.ticks.x=element_blank(),axis.text.x = element_blank())

ggsave("S1f.svg")
ggsave("S1f.pdf")

#Phred score distribution (Fig_S3)

phred<-read.table("~/LEPC_full_qaNF.qs",header = T)
ggplot(phred, aes(x=qscore,y=counts)) + geom_bar(stat="identity")+theme_classic()+ scale_x_discrete(name ="Phred score",limits=c(13:37))+ylab("Number of bases") + geom_vline(xintercept = 30,linetype="dashed")
ggsave("~/phred_lepc.svg")
ggsave("~/phred_lepc.pdf")

       
