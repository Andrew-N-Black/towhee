# =============================================================================
# GENOME FEATURE PARSING: derive BED files of genes, introns, and intergenic
# regions from the NCBI GTF/FASTA annotation, for annotating variants/regions
# by genomic context.
# =============================================================================

ml bioinfo
ml bedtools
ml bioawk

#GENES: extract gene-feature coordinates from the GTF
cat GCF_028551555.1_PUWL_Pcris_2_genomic.gtf | awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' > towhee_genes.bed

#INTER: derive introns as gene regions minus merged exons
awk 'BEGIN{OFS="\t";} $3=="gene" {print $1,$4,$5}' GCF_028551555.1_PUWL_Pcris_2_genomic.gtf > exon.bed
head gencode_v14_exon.bed
sortBed -i exon.bed > exon_temp.bed
mv -f exon_temp.bed exon.bed
mergeBed -i v14_exon.bed > exon_merged.bed
subtractBed -a towhee_genes.bed -b exon_merged.bed > intron.bed
# Build a genome/chromosome-size file, then complement gene regions to get intergenic regions
bioawk -c fastx '{ print $name, length($seq) }' < GCF_028551555.1_PUWL_Pcris_2_genomic.fna > chrom
complementBed -i gene.bed -g chrom > towhee_intergenic.bed
