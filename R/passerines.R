#Plot US species heterozygosity according to USFWS listing status
ggplot(heterozygosity_passeriformes,aes(x=reorder(USFWS,H),y=H))+geom_boxplot()+theme_bw() + labs(x = "", y = "Heterozygosity")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("USFWS listing") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
    axis.title.y = element_text(size = 20))

