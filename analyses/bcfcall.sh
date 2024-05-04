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
module load vcf-kit/0.2.9
module load bioinfo
module load bcftools/1.15.1
module load iqtree/2.1.2




bcftools mpileup -f /scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa \
 -b bamlist | bcftools call -mv -Ov -o towhee_raw.vcf
