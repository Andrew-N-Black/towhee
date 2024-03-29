

library(reshape2)
library(readxl)
library(ggplot2)
library(RColorBrewer)

#FIGURE 2
Figure_2A <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/Figure_2.xlsx")
melt_data<-melt(Figure_2A ,id.vars = "Species")
melt_data$Species <- factor(melt_data$Species,levels = c("Chipping Sparrow","Song sparrow","Grasshopper sparrow","Dark eyed junco","White throated sparrow","California towhee" ))

ggplot(melt_data,aes(Species,value))+geom_bar(aes(fill=variable),stat = "identity")+theme_classic()+xlab("")+ylab("% BUSCO") +  scale_y_reverse()+coord_flip()+ theme(legend.position="top")+theme(axis.text.x = element_text(size = 10)) +theme(axis.text.y  = element_text(size = 14)) +theme(legend.title=element_blank())+ scale_fill_brewer(palette="Paired")
ggsave("~/Figure_2.svg")
ggsave("~/Figure_2.pdf")



