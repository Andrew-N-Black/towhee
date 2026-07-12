#!/bin/sh
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=vcf_tree
#SBATCH -e vcf.err
#SBATCH -o vcf.o

# =============================================================================
# NUCLEAR PHYLOGENY: call variants, convert the filtered VCF to a pseudo-FASTA
# alignment (vcf-kit), then build a maximum-likelihood tree in IQ-TREE with
# 1000 ultrafast bootstrap and SH-aLRT replicates.
# =============================================================================

module purge
module load biocontainers
ml vcf-kit/0.2.9
module load bioinfo
module load bcftools/1.15.1
module load iqtree/2.1.2

# Call variant sites across all samples in bamlist
bcftools mpileup -f /scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa \
-b bamlist | bcftools call -mv -Ov -o towhee_raw.vcf

# Convert filtered VCF genotypes into a whole-genome pseudo-FASTA alignment
vk phylo fasta towhee_filtered.vcf.recode.vcf > towhee_nu.fasta
# ML tree with ultrafast bootstrap (-B) and SH-aLRT (-alrt) support
iqtree -s towhee_nu.fasta -B 1000 -alrt 1000 -T 16

#Alignment has 81 sequences with 8246056 columns, 5803135 distinct patterns
#5119975 parsimony-informative, 1051380 singleton sites, 2074700 constant sites
