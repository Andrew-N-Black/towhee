ml bioinfo
ml bedtools
ml bioawk

#GENES
cat GCF_028551555.1_PUWL_Pcris_2_genomic.gtf | awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' > towhee_genes.bed

#INTER
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' GCF_028551555.1_PUWL_Pcris_2_genomic.gtf > exon.bed
head gencode_v14_exon.bed
sortBed -i exon.bed > exon_temp.bed
mv -f exon_temp.bed exon.bed
mergeBed -i v14_exon.bed > exon_merged.bed
cat GCF_028551555.1_PUWL_Pcris_2_genomic.gtf | awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' > gene.bed
sortBed -i gene.bed > gene_temp.bed
mv -f gene_temp.bed gene.bed
subtractBed -a gene.bed -b exon_merged.bed > intron.bed
bioawk -c fastx '{ print $name, length($seq) }' < GCF_028551555.1_PUWL_Pcris_2_genomic.fna > chrom
complementBed -i gene.bed -g chrom > towhee_intergenic.bed




http://crazyhottommy.blogspot.com/2013/05/find-exons-introns-and-intergenic.html
