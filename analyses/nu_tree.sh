#!/bin/sh
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=vcf_tree
#SBATCH -e vcf.err
#SBATCH -o vcf.o



module purge
module load biocontainers
ml vcf-kit/0.2.9
module load bioinfo
module load bcftools/1.15.1
module load iqtree/2.1.2




bcftools mpileup -f /scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa \
-b bamlist | bcftools call -mv -Ov -o towhee_raw.vcf

vk phylo fasta towhee_filtered.vcf.recode.vcf > towhee_nu.fasta
iqtree -s towhee_nu.fasta -B 1000 -alrt 1000 -T 16

#Alignment has 81 sequences with 8246056 columns, 5803135 distinct patterns
#5119975 parsimony-informative, 1051380 singleton sites, 2074700 constant sites
