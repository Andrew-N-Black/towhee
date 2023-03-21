#!/bin/bash
#SBATCH -A fnrchook
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=bcf
#SBATCH --error=bcf.e
#SBATCH --output=bcf.o
#SBATCH --mem=100G
module load biocontainers
module load angsd

#Move to bam folder

angsd -GL 1 -dobcf 1 -dopost 1 -domajorminor 1 -domaf 1 -minQ 30 -P 64 \
-SNP_pval 1e-6 -bam bamlist -ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa

module purge
module load bioinfo
module load bcftools
module load samtools

bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/AF\n' angsdput.bcf | bgzip -c > towhee.freqs.tab.gz
tabix -s1 -b2 -e2 towhee.freqs.tab.gz
bcftools roh --AF-file towhee.freqs.tab.gz --output ROH_TOWHEE_PLraw.txt --threads 64 angsdput.bcf

awk '$1=="RG"' ROH_TOWHEE_PLraw.txt > ROH_RG_all.txt
#for i in `cat sample.names`; do  grep $i ROH_RG_all.txt  > $i.ROH.txt ; done
