ml bioinfo
ml bedtools

#GENES
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' GCF_028551555.1_PUWL_Pcris_2_genomic.gtf |  bedtools sort | bedtools merge -i - > towhee_genes.bed


#INTER
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' GCF_028551555.1_PUWL_Pcris_2_genomic.gtf > gencode_v14_exon.bed
head gencode_v14_exon.bed
sortBed -i gencode_v14_exon.bed > gencode_v14_exon_temp.bed
mv -f gencode_v14_exon_temp.bed gencode_v14_exon.bed
mergeBed -i gencode_v14_exon.bed > gencode_v14_exon_merged.bed
cat GCF_028551555.1_PUWL_Pcris_2_genomic.gtf | awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' > gencode_v14_gene.bed
sortBed -i gencode_v14_gene.bed > gencode_v14_gene_temp.bed
mv -f gencode_v14_gene_temp.bed gencode_v14_gene.bed
subtractBed -a gencode_v14_gene.bed -b gencode_v14_exon_merged.bed > gencode_v14_intron.bed



http://crazyhottommy.blogspot.com/2013/05/find-exons-introns-and-intergenic.html
