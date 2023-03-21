#Load R packages
library(ggplot2)
library(readxl)

#Subet length of scaffolds and plot
length_scaff <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/Sequence_lengths_reference.xlsx")
ggplot(data=length_scaff, aes(y=LengthKB,x=reorder(LengthKB,Contig)))+geom_bar(stat="identity")+theme_classic()+ylab("Length (kb)")+xlab("Contig")+theme(axis.text.x=element_blank(), axis.ticks.x=element_blank())+ geom_hline(yintercept=100, linetype="dashed", color = "red")


ggsave("S1a.svg")
ggsave("S1a.pdf")

#Mapping rate
depth_breadth <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/summary_stats.xlsx")

ggplot(data=depth_breadth, aes(y=map, x=reorder(ID,map),fill=HABITAT))+geom_bar(stat="identity")+scale_fill_manual(title1, values =c("Shinnery-Oak-Prairie"="bisque","Mixed-Grass-Prairie"="blue","Sand-Sagebrush-Prairie"="darkorchid1","Shortgrass-CRP-Mosaic"="darkolivegreen3"))+xlab("Sample (N=420)")+ylab("Reads Aligned (% properly paired)")+theme( axis.ticks.y=element_blank(),axis.text.y = element_blank())+coord_flip()+ylim(c(0,100))
ggsave("S1b.svg")
ggsave("S1b.pdf")


#Plotting Depth:

depth_breadth <- read_excel("~/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/LEPC/analysis/depth_breadth_filt.xlsx")
ggplot(data=depth_breadth, aes(y=filt.d, x=reorder(ID,filt.d),fill=HABITAT))+ geom_bar(stat="identity")+scale_fill_manual(title1, values =c("Shinnery-Oak-Prairie"="bisque","Mixed-Grass-Prairie"="blue","Sand-Sagebrush-Prairie"="darkorchid1","Shortgrass-CRP-Mosaic"="darkolivegreen3"))+xlab("Sample (N=420)")+ylab("Coverage")+theme( axis.ticks.y=element_blank(),axis.text.y = element_blank())+coord_flip()

ggsave("S1c.svg")
ggsave("S1c.pdf")

#Plotting Breadth
ggplot(data=depth_breadth, aes(y=filt.b, x=reorder(ID,filt.b),fill=HABITAT))+  geom_bar(stat="identity")+scale_fill_manual(title1, values =c("Shinnery-Oak-Prairie"="bisque","Mixed-Grass-Prairie"="blue","Sand-Sagebrush-Prairie"="darkorchid1","Shortgrass-CRP-Mosaic"="darkolivegreen3"))+xlab("Sample (N=420)")+ylab("Breadth")+theme( axis.ticks.y=element_blank(),axis.text.y = element_blank())+coord_flip()+ylim(c(0,100))
ggsave("S1d.svg")
ggsave("S1d.pdf")

#Plotting global depth
all_LEPC_depthGlobal <- read_excel("all_LEPC_depthGlobal_4k.xls")
View(all_LEPC_depthGlobal)

#Plot global depth among all 420 samples
x<-read.table("~/LEPC_full_qaNF.depthGlobal",header = T)
ggplot(data=x,aes(x=COV,y=SITES))+geom_bar(stat="identity")+theme_classic()+xlab("Global Depth")+
    ylab("#Sites")+theme(axis.text=element_text(size=8),axis.title=element_text(size=10,face="bold"))+
    geom_vline(xintercept = 1740)+geom_vline(xintercept = 2500)+ theme(axis.text.x = element_text(size = 12)) +xlim(c(1000,2300))
ggsave("S1e.svg")
ggsave("S1e.pdf")


#Sample Depth, population origin factor (Fig_S2)
#Edit by pasting sample names in col.1 and habitat  in col.2.
LEPC_full_qaNF_edited <- read.delim("~/LEPC_full_qaNF_edited.txt")
y<-LEPC_full_qaNF_edited[,c(1:23)]
b <- melt(y, id.vars=c("ID","HABITAT"))
ggplot(b, aes(x=variable,y=value,fill=as.factor(HABITAT))) + geom_bar(stat="identity")+theme_classic()+facet_wrap(~HABITAT,ncol=1,scales = "free_y")+scale_fill_manual("Ecoregion", values =c("Shinnery-Oak-Prairie"="bisque","Mixed-Grass-Prairie"="blue","Sand-Sagebrush-Prairie"="darkorchid1","Shortgrass-CRP-Mosaic"="darkolivegreen3"))+ theme(legend.position="none")+xlab("Coverage Level")+ylab("Number of Nucleotides")+ theme(axis.text.x = element_text(size = 6))
ggsave("Fig_S2.svg")
ggsave("Fig_S2.pdf")

#Phred score distribution (Fig_S3)

phred<-read.table("~/LEPC_full_qaNF.qs",header = T)
ggplot(phred, aes(x=qscore,y=counts)) + geom_bar(stat="identity")+theme_classic()+ scale_x_discrete(name ="Phred score",limits=c(13:37))+ylab("Number of bases") + geom_vline(xintercept = 30,linetype="dashed")
ggsave("~/phred_lepc.svg")
ggsave("~/phred_lepc.pdf")

       
