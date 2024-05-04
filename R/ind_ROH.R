library(ggplot2)
library(readxl)
library(reshape2)

ind_roh <-read_excel("/Users/andrew/Library/CloudStorage/Box-Box/Personal/Postdoc_Purdue/Towhee/Black_analysis/ind_rohs.xlsx")
ind_roh<-as.data.frame(ind_roh)
melt_data<-melt(ind_roh,id.vars = c("ID","Pop","Sites"))
melt_data$Pop <- factor(melt_data$Pop, levels = c("OREG","CCAL", "INYO","SCAL"))

ggplot(melt_data, aes(fill=Pop, y=value, x=reorder(ID,value))) +geom_bar(stat="identity",position="dodge")+facet_grid(variable~Pop,scales = "free")+theme(axis.title.x=element_blank(),axis.text.x=element_blank(),axis.ticks.x=element_blank())+theme_classic()+ylab("fROH")+xlab("Sample (N=81)")+
    theme(legend.position="none")+theme(axis.title.x=element_blank(), axis.text.x=element_blank(), axis.ticks.x=element_blank())+ scale_fill_brewer(palette="Paired")

ggsave("~/towhee_rohs.svg")

shapiro.test(ind_roh$Total)

	Shapiro-Wilk normality test

data:  ind_roh$Total
W = 0.82069, p-value = 1.634e-08


kruskal.test(Total ~ Pop, data = ind_roh)

     CCAL    INYO    OREG   
INYO 1.9e-07 -       -      
OREG 1.5e-06 0.0556  -      
SCAL 0.0066  1.9e-08 3.9e-09

	Kruskal-Wallis rank sum test

data:  Total by Pop
Kruskal-Wallis chi-squared =
50.217, df = 3, p-value = 7.183e-11


pairwise.wilcox.test(ind_roh$Total, ind_roh$Pop, p.adjust.method = "BH")

	Pairwise comparisons using Wilcoxon rank sum exact test 



kruskal.test(`>1MB` ~ Pop, data = ind_roh)

	Kruskal-Wallis rank sum test

data:  >1MB by Pop
Kruskal-Wallis chi-squared = 28.161, df
= 3, p-value = 3.359e-06

     CCAL    INYO    OREG   
INYO 1.9e-07 -       -      
OREG 1.5e-06 0.0556  -      
SCAL 0.0066  1.9e-08 3.9e-09

P value adjustment method: BH 


kruskal.test(`100kb-1MB` ~ Pop, data = ind_roh)

	Kruskal-Wallis rank sum test

data:  100kb-1MB by Pop
Kruskal-Wallis chi-squared = 49.578, df
= 3, p-value = 9.827e-11



pairwise.wilcox.test(ind_roh$100kb-1MB, ind_roh$Pop, p.adjust.method = "BH")

	Pairwise comparisons using Wilcoxon rank sum exact test 

data:  ind_roh$`100kb-1MB` and ind_roh$Pop 

     CCAL    INYO    OREG   
INYO 3.1e-08 -       -      
OREG 2.4e-08 0.8743  -      
SCAL 0.0055  9.8e-10 9.8e-10

P value adjustment method: BH 
pairwise.wilcox.test(ind_roh$`>1MB`, ind_roh$Pop, p.adjust.method = "BH")
data:  ind_roh$Total and ind_roh$Pop 

     CCAL    INYO    OREG   
INYO 0.00058 -       -      
OREG 0.32370 2.9e-05 -      
SCAL 0.02605 2.9e-05 0.23569

P value adjustment method: BH 



#Summarize ROHs by factor
library(dplyr)
ind_roh$Pop <- ordered(ind_roh$Pop,levels = c("OREG","CCAL","INYO","SCAL"))

group_by(ind_roh, Pop) %>% summarise(count = n(),mean = mean(`100kb-1MB`, na.rm = TRUE),sd = sd(`100kb-1MB`, na.rm = TRUE),median = median(`100kb-1MB`, na.rm = TRUE),IQR = IQR(`100kb-1MB`, na.rm = TRUE))

# A tibble: 4 × 6
  Pop   count   mean     sd median    IQR
  <ord> <int>  <dbl>  <dbl>  <dbl>  <dbl>
1 OREG     14 0.112  0.0182 0.110  0.0249
2 CCAL     30 0.0552 0.0284 0.0621 0.0447
3 INYO     14 0.135  0.0642 0.106  0.0457
4 SCAL     23 0.0360 0.0234 0.0216 0.0445

group_by(ind_roh, Pop) %>% summarise(count = n(),mean = mean(`>1MB`, na.rm = TRUE),sd = sd(`>1MB`, na.rm = TRUE),median = median(`>1MB`, na.rm = TRUE),IQR = IQR(`>1MB`, na.rm = TRUE))
 
Pop   count   mean      sd  median     IQR
  <ord> <int>  <dbl>   <dbl>   <dbl>   <dbl>
1 OREG     14 0.0150 0.00676 0.0135  0.00325
2 CCAL     30 0.0190 0.00972 0.0177  0.0191 
3 INYO     14 0.0476 0.0348  0.0353  0.0275 
4 SCAL     23 0.0133 0.0103  0.00741 0.0195 


group_by(ind_roh, Pop) %>% summarise(count = n(),mean = mean(`Total`, na.rm = TRUE),sd = sd(`Total`, na.rm = TRUE),median = median(`Total`, na.rm = TRUE),IQR = IQR(`Total`, na.rm = TRUE))

 Pop   count   mean     sd median
  <ord> <int>  <dbl>  <dbl>  <dbl>
1 OREG     14 0.128  0.0236 0.123 
2 CCAL     30 0.0750 0.0371 0.0864
3 INYO     14 0.184  0.0975 0.139 
4 SCAL     23 0.0498 0.0338 0.0311



