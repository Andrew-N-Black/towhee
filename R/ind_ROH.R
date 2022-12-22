library(ggplot2)
library(readxl)
library(reshape2)

ind_roh <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/ind_roh.xlsx")
melt_data<-melt(ind_roh,id.vars = c("sample","Pop","Sites"))
melt_data$Pop <- factor(melt_data$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

ggplot(melt_data, aes(fill=Pop, y=value, x=reorder(sample,value))) +geom_bar(stat="identity",position="dodge")+facet_grid(variable~Pop,scales = "free")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+theme_classic()+
    scale_fill_manual(values=c("grey","bisque","black","cadetblue"))+ylab("fROH")+xlab("Sample (N=79)")+
    theme(legend.position="none")
    
ggsave("~/towhee_rohs.svg")
