ml bioinfo
ml bedtools
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4-1,$5}' GCF_028551555.1_PUWL_Pcris_2_genomic.gtf |  bedtools sort | bedtools merge -i - > towhee_genes.bed
