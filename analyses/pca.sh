#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -n 64
#SBATCH -t 10-00:00:00
#SBATCH --job-name=pca
#SBATCH --error=pca.e
#SBATCH --output=pca.o
#SBATCH --mem=64G
# =============================================================================
# PCA / ADMIXTURE / SELECTION SCAN via PCAngsd
# Computes genotype likelihoods (ANGSD), then runs PCAngsd to get a genotype
# covariance matrix (for PCA, R/pca.R), admixture proportions, and a PCAdapt
# selection scan, once with a standard MAF filter and once retaining singletons.
# =============================================================================
module load biocontainers
module load angsd
module load pcangsd
#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
mkdir PCA
# Genotype likelihoods (beagle format) across all samples in bamlist
angsd -GL 1 -out PCA/towhee -minQ 30 -P 64 \
-minInd 64 -doGlf 2 -doMajorMinor 1 -doMaf 1 -SNP_pval 1e-6 -bam bamlist \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa
#maf 0.05 — standard-filtered covariance matrix, selection scan, tree, and admixture
pcangsd -b  PCA/towhee.beagle.gz --selection --minMaf 0.05 --sites_save --tree -o PCA/pca-towhee --threads 64 --pcadapt --admix
#singletons — retain very rare variants (minMaf just above a single-copy allele)
pcangsd -b  PCA/towhee.beagle.gz --minMaf 0.0061 --sites_save -o PCA/pca-towhee_Singletons --threads 64 --admix
