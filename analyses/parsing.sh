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
subtractBed -a towhee_genes.bed -b exon_merged.bed > intron.bed
bioawk -c fastx '{ print $name, length($seq) }' < GCF_028551555.1_PUWL_Pcris_2_genomic.fna > chrom
complementBed -i gene.bed -g chrom > towhee_intergenic.bed
