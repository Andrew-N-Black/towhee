library(ggplot2)
library(forcats)
k<-ggplot(Ne,aes(x=forcats::fct_reorder(Region, NE, .fun = median),y=NE))
k+geom_point(aes(group=Region,color=Region),size=5)+geom_errorbar(aes(ymin=min,ymax=max,color=Region,width=0.6))+theme_classic()+scale_color_manual(values=c("#1F78B4","#B2DF8A","#A6CEE3","#33A02C"))+xlab("")+ theme(legend.position="none")

