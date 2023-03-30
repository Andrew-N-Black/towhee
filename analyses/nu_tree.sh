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

