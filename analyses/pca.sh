#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -n 64
#SBATCH -t 10-00:00:00
#SBATCH --job-name=pca
#SBATCH --error=pca.e
#SBATCH --output=pca.o
#SBATCH --mem=64G
module load biocontainers
module load angsd
module load pcangsd
#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
mkdir PCA
angsd -GL 1 -out PCA/towhee -minQ 30 -P 64 \
-minInd 64 -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -bam bamlist \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa
#maf 0.05
pcangsd -b  PCA/towhee.beagle.gz --selection --minMaf 0.05 --sites_save --tree -o PCA/pca-towhee --threads 64 --pcadapt --admix
#singletons
pcangsd -b  PCA/towhee.beagle.gz --minMaf 0.0061 --sites_save -o PCA/pca-towhee_Singletons --threads 64 --admix
