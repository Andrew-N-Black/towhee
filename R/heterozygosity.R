library(ggplot2)
HET<- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Figures/het.xlsx")
HET$Pop <- factor(HET$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

#Color by region
ggplot(HET,aes(x=Pop,y=HET,fill=Pop))+geom_boxplot(show.legend =FALSE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme_classic()+scale_fill_manual(values=c("grey","bisque","black","cadetblue"))+theme(legend.position="none")
ggsave("~/towhee.svg")
#Color by region and order by site
ggplot(HET,aes(x=reorder(Sites,HET),y=HET,fill=Pop))+geom_boxplot(show.legend =FALSE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme_classic()+scale_fill_manual(values=c("grey","bisque","black","cadetblue"))+theme(axis.text.x=element_text(angle = 45, vjust = 0.75))


#Summarize by Population
library(dplyr)
ind_roh$Pop <- ordered(ind_roh$Pop,levels = c("OREG","CCAL","INYO","SCAL"))
group_by(het, Pop) %>% summarise(count = n(),mean = mean(`HET`, na.rm = TRUE),sd = sd(`HET`, na.rm = TRUE),median = median(`HET`, na.rm = TRUE),IQR = IQR(`HET`, na.rm = TRUE))
