#Plot US species heterozygosity according to USFWS listing status
heterozygosity_passeriformes <- read_excel("heterozygosity_passeriformes_USFWS.xlsx")
ggplot(heterozygosity_passeriformes,aes(x=reorder(USFWS,H),y=H))+geom_boxplot()+theme_bw() + labs(x = "", y = "Heterozygosity")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("USFWS listing") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
    axis.title.y = element_text(size = 20))

#Plot all passerine species and towhee according to IUCN classification
heterozygosity_passeriformes <- read_excel("heterozygosity_passeriformes.xlsx")
ggplot(heterozygosity_passeriformes,aes(x=reorder(IUCN_long,H),y=H))+geom_boxplot()+theme_bw() + labs(x = "", y = "Heterozygosity")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot total fROH only for US species, according to USFWS status
passerine_roh_usfws <- read_excel("passerine_roh_usfws.xlsx")
ggplot(passerine_roh_usfws,aes(x=reorder(USFWS,`Total Froh`),y=`Total Froh`))+geom_boxplot()+theme_bw() + labs(x = "", y = "Total fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("USFWS Status") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot total fROH  for all species, according to IUCN Category 
passerine_roh_Total_IUCN <- read_excel("passerine_roh_Total_IUCN.xlsx")
ggplot(passerine_roh_Total_IUCN,aes(x=reorder(group,total),y=total))+geom_boxplot()+theme_bw() + labs(x = "", y = "Total fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot short fROH  for all species, according to IUCN Category
passerine_roh_short_IUCN <- read_excel("passerine_roh_short_IUCN.xlsx")
ggplot(passerine_roh_short_IUCN,aes(x=reorder(group,short),y=short))+geom_boxplot()+theme_bw() + labs(x = "", y = "Short fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))

#Plot long fROH  for all species, according to IUCN Category
passerine_roh_long_IUCN <- read_excel("passerine_roh_long_IUCN.xlsx")
ggplot(passerine_roh_long_IUCN,aes(x=reorder(group,long),y=long))+geom_boxplot()+theme_bw() + labs(x = "", y = "Long fROH")+ theme( plot.title = element_text(size = 20, face = "bold"),axis.text = element_text(size = 16))+ggtitle("IUCN Category") +theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))+theme(
+     axis.title.y = element_text(size = 20))


