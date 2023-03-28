library(ggplot2)
het <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/het.xlsx")
het$Pop <- factor(het$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

#Color by region
ggplot(het,aes(x=Pop,y=HET,fill=Pop))+geom_boxplot(show.legend =FALSE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme_classic()+scale_fill_manual(values=c("darkorchid","tan2","black","cadetblue"))+theme(legend.position="none")
ggsave("~/het_towhee.svg")
#Color by region and order by site
ggplot(het,aes(x=reorder(Sites,HET),y=HET,fill=Pop))+geom_boxplot(show.legend =TRUE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme_classic()+scale_fill_manual("Population",values=c("darkorchid","tan2","black","cadetblue"))+theme(axis.text.x=element_text(angle = 45, vjust = 0.8,hjust = 1))
ggsave("~/het_site_towhee.svg")

#Summarize by Population
library(dplyr)

group_by(het, Pop) %>% summarise(count = n(),mean = mean(`HET`, na.rm = TRUE),sd = sd(`HET`, na.rm = TRUE),median = median(`HET`, na.rm = TRUE),IQR = IQR(`HET`, na.rm = TRUE))

 Pop   count    mean        sd  median
  <fct> <int>   <dbl>     <dbl>   <dbl>
1 OREG     14 0.00169 0.0000630 0.00171
2 CCAL     30 0.00201 0.000127  0.00203
3 INYO     14 0.00180 0.000188  0.00185
4 SCAL     23 0.00246 0.0000572 0.00247

