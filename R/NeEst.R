# =============================================================================
# EFFECTIVE POPULATION SIZE (Ne) BY REGION
# Plots point estimates of Ne with min/max range bars per region, ordered
# by median Ne. Expects a data frame `Ne` with columns: Region, NE, min, max.
# =============================================================================

library(ggplot2)
library(forcats)

# Order regions along the x-axis by their median NE
k<-ggplot(Ne,aes(x=forcats::fct_reorder(Region, NE, .fun = median),y=NE))

# Point estimate per region + error bars spanning min-max Ne range
k+geom_point(aes(group=Region,color=Region),size=5)+geom_errorbar(aes(ymin=min,ymax=max,color=Region,width=0.6))+theme_classic(base_size = 22)+scale_color_manual(values=c("#1F78B4","#B2DF8A","#A6CEE3","#33A02C"))+xlab("")+ theme(legend.position="none")+ylab("Effective Population Size")

