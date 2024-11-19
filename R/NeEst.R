library(ggplot2)
library(forcats)
k<-ggplot(Ne,aes(x=forcats::fct_reorder(Region, NE, .fun = median),y=NE))
k+geom_point(aes(group=Region,color=Region))+geom_errorbar(aes(ymin=min,ymax=max,color=Region,width=0.2))+theme_classic()
