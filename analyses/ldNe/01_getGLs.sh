#!/bin/sh -l
#SBATCH -A fnrblack
#SBATCH -N 1
#SBATCH -n 20
#SBATCH -t 150:00:00
#SBATCH --job-name=angsd
#SBATCH -e angsd
#SBATCH -o angsd

##########################################################################
###                          Samarth Mathur, PhD                        ###
###                       The Ohio State University                     ###
###                                                                     ###
###########################################################################
###########################################################################
###                     getGLs.sh                 				        ###
###########################################################################

cd $SLURM_SUBMIT_DIR
module purge
module load biocontainers
#module load samtools
#module load vcftools
#module load gsl
#module load bwa

#module load plink/1.90b6.4

### Comment:
### Adding Waples contemporary Ne estimates would be very useful and help support the argument (i.e. line 524-525). 
### His 2016 paper adds an adjustment factor for genome data BUT I've written a script that simply randomly samples 
### the genome X number of times to calculate Ne (via R2) with SE. It works well and is quick and I'm happy to share via the editor, 
### as having pi (or long-term Ne) and contemporary Ne I think would help round-off the ROH patterns. That said, it's not difficult to write: 
### Waples (2006) equations are based on genotype correlations (R2) and you can apply the sample size correction of Waples et al. (2016). 
### All we did was randomly sample the VCF file to produce "unlinked" data of a desired size.

## Notes from Andrew Black:
## I filtered the BAM files by removing all reads within genic areas AND those that were +/1 100kb from the start / end of genic coordinates.

ngsLD="/depot/fnrdewoody/apps/ngsLD"
angsd="/depot/fnrdewoody/apps/angsd"
MAINDIR="/scratch/bell/mathur20/towhee"

cd $MAINDIR/data

## Step0: Index reference

#samtools faidx GCF_028551555.1_PUWL_Pcris_2_genomic.fna
#bwa index GCF_028551555.1_PUWL_Pcris_2_genomic.fna

## Step1: Get genotype likelihoods 

# per pop

# for pop in CCAL SCAL INYO OREG
# do 
#     $angsd/angsd \
#     -bam $MAINDIR/data/$pop.bamlist.txt \
#     -ref $MAINDIR/data/GCF_028551555.1_PUWL_Pcris_2_genomic.fna \
#     -GL 1  -doGlf 2 -P 20 -minMapQ 30 -doCounts 1 -setMinDepth 3 -domaf 1 -domajorminor 1 -dosnpstat 1 -doHWE 1 \
#     -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -setMinDepthInd 3 -snp_pval 1e-6 -minMaf 0.05 \
#     -out $MAINDIR/results/angsd/$pop
# done

# all sample

$angsd/angsd \
-bam $MAINDIR/data/allSample.bamlist.txt \
-ref $MAINDIR/data/GCF_028551555.1_PUWL_Pcris_2_genomic.fna \
-GL 1  -doGlf 2 -P 20 -minMapQ 30 -doCounts 1 -setMinDepth 3 -domaf 1 -domajorminor 1 -dosnpstat 1 -doHWE 1 \
    -uniqueOnly 1 -remove_bads 1 -only_proper_pairs 1 -C 50 -setMinDepthInd 3 -snp_pval 1e-6 -minMaf 0.05 \
-out $MAINDIR/results/angsd/allSample


