#!/bin/bash
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


#Generate angsd output files for all OK regions
cd $WD
angsd -P 8 \
-bam ./revised_bamsSub.txt -doBcf 1 -gl 1 -dopost 1 -domajorminor 1 -domaf 1 -minMaf 0.05 -rmTriallelic 1  \
-setMinDepthInd 3 -minInd 64 -minMapQ 20 -minQ 20 -SNP_pval 1e-6  -ref ../ref/ref.fa -anc ../ref/ref.fa -out ../angsd_out/towhee-DOC3-maf.05

cd ../angsd_out
#wget https://faculty.washington.edu/browning/beagle/beagle.27Jan18.7e1.jar
#chmod +x beagle.27Jan18.7e1.jar

#Convert BCF to VCF
#autosomes
bcftools convert -O b -o towhee-DOC3-maf.05.vcf  towhee-DOC3-maf.05.bcf

#Use beagle to call genotypes from Genotype likelihoods
#Autosomes
ml openjdk/11.0.17_8
java -Xmx100g -jar beagle.27Jan18.7e1.jar gl=towhee-DOC3-maf.05.vcf out=towheeDOC3-genotypes

# ALL_bamlist n=61 including metagenomic samples
#./revised_bams.txt n=49, excluding metagenomic samples
#./revised_bamsSub.txt n=46
