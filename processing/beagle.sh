#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 20
#SBATCH -t 10-00:00:00
#SBATCH --job-name=beagle
#SBATCH --error=towhee.e
#SBATCH --output=towhee.o
#SBATCH --mem=35G
module load biocontainers
module load angsd
#Move to bam folder
angsd -GL 1 -out PCA/towhee -minQ 30 -P 20 \
-minInd 64 -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -bam bamlist \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa
