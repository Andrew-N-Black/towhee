

library(reshape2)
library(readxl)
library(ggplot2)

#FIGURE 2
Figure_2A <- read_excel("tow/Figure_2A.xlsx")
melt_data<-melt(Figure_2A ,id.vars = "Species")
melt_data$Species <- factor(melt_data$Species,levels = c("Chipping Sparrow","Song sparrow","Grasshopper sparrow","Dark eyed junco","White throated sparrow", "Inyo Towhee","California towhee" ))

ggplot(melt_data,aes(Species,value))+geom_bar(aes(fill=variable),stat = "identity")+theme_classic()+xlab("")+ylab("% BUSCO") +  scale_y_reverse()+scale_fill_manual("", values = c("Complete and single-copy"="black","Complete and duplicated"="bisque","Fragmented"="azure4","Missing"="cadetblue4"))+coord_flip()+ theme(legend.position="top")
ggsave("~/tow/figure_2.svg")



