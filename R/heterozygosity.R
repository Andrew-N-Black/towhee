library(ggplot2)
library(RColorBrewer)

het <- read_excel("Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/het.xlsx")
het$Pop <- factor(het$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

#Color by region
ggplot(het,aes(x=Pop,y=HET,fill=Pop))+geom_boxplot(show.legend =FALSE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme_classic()+scale_fill_manual(values=c("darkorchid","tan2","black","cadetblue"))+theme(legend.position="none")+ scale_fill_brewer(palette="Paired")
ggsave("~/het_towhee.svg")
#Color by region and order by site
ggplot(het,aes(x=reorder(Sites,HET),y=HET,fill=Pop))+geom_boxplot(show.legend =TRUE)+xlab("")+ylab("Individual Heterozygosity")+theme_classic()+theme(axis.text.x=element_text(angle = 45, vjust = 0.8,hjust = 1))+ scale_fill_brewer(palette="Paired")+theme(legend.title=element_blank())
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

shapiro.test(het$HET)

	Shapiro-Wilk normality test

data:  het$HET
W = 0.93444, p-value = 0.0004497

kruskal.test(HET ~ Pop, data = het)

	Kruskal-Wallis rank sum test

data:  HET by Pop
Kruskal-Wallis chi-squared =
65.821, df = 3, p-value = 3.347e-14

pairwise.wilcox.test(het$HET, het$Pop, p.adjust.method = "BH")

	Pairwise comparisons using Wilcoxon rank sum exact test 

data:  het$HET and het$Pop 

     OREG    CCAL    INYO   
CCAL 3.6e-09 -       -      
INYO 0.0049  0.0001  -      
SCAL 6.5e-10 1.9e-14 6.5e-10

P value adjustment method: BH 
