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

shapiro.test(ind_roh$Total)

	Shapiro-Wilk normality test

data:  ind_roh$Total
W = 0.81661, p-value = 1.666e-08


kruskal.test(Total ~ Pop, data = ind_roh)

	Kruskal-Wallis rank sum test

data:  Total by Pop
Kruskal-Wallis chi-squared = 47.41, df =
3, p-value = 2.843e-10


pairwise.wilcox.test(ind_roh$Total, ind_roh$Pop, p.adjust.method = "BH")

	Pairwise comparisons using Wilcoxon rank sum exact test 



kruskal.test(`>1MB` ~ Pop, data = ind_roh)

	Kruskal-Wallis rank sum test

data:  >1MB by Pop
Kruskal-Wallis chi-squared = 28.161, df
= 3, p-value = 3.359e-06

     CCAL    INYO    OREG
INYO 1.9e-05 -       -   
OREG 0.19    1.9e-05 -   
SCAL 0.19    1.9e-05 0.80

P value adjustment method: BH 


kruskal.test(`100kb-1MB` ~ Pop, data = ind_roh)

	Kruskal-Wallis rank sum test

data:  100kb-1MB by Pop
Kruskal-Wallis chi-squared = 49.578, df
= 3, p-value = 9.827e-11

	Pairwise comparisons using Wilcoxon rank sum exact test 

data:  ind_roh$`100kb-1MB` and ind_roh$Pop 

     CCAL    INYO    OREG   
INYO 3.2e-08 -       -      
OREG 3.2e-08 0.17    -      
SCAL 0.27    5.2e-09 2.0e-09

P value adjustment method: BH 







data:  ind_roh$Total and ind_roh$Pop 

     CCAL    INYO    OREG   
INYO 5.8e-08 -       -      
OREG 8.1e-07 0.023   -      
SCAL 0.233   1.9e-08 1.9e-08

P value adjustment method: BH 


