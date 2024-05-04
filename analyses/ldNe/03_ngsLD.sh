#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 60
#SBATCH -t 150:00:00
#SBATCH --job-name=ngsLD
#SBATCH -e ngsLD
#SBATCH -o ngsLD

##########################################################################
###                          Samarth Mathur, PhD                        ###
###                       The Ohio State University                     ###
###                                                                     ###
###########################################################################
###########################################################################
###                     ngsLD.sh                 				        ###
###########################################################################

cd $SLURM_SUBMIT_DIR
module purge
module load biocontainers
module load gsl
#module load biopython

module load use.own                                       
# module load conda-env/ngsLD-py3.9.1
module load anaconda
conda activate gt
#module load vcftools

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

ngsLD="/home/mathur20/ngsLD"
angsd="/depot/fnrdewoody/apps/angsd"
MAINDIR="/scratch/bell/mathur20/towhee"
OUTDIR="/scratch/bell/mathur20/towhee/results/ngsLD"

cd $OUTDIR



# for pop in CCAL SCAL INYO OREG
# do
#     N_IND=$(wc -l < $MAINDIR/data/$pop.bamlist.txt)
#     less $MAINDIR/results/angsd/$pop.beagle.gz | cut -f1 | sed 's/1_/1\t/g' | sed '1d' >  $pop.sites.txt
#     N_SITES=$(less $pop.sites.txt | wc -l)
#     $ngsLD/ngsLD \
#         --geno $MAINDIR/results/angsd/$pop.beagle.gz --probs \
#         --pos $pop.sites.txt \
#         --max_kb_dist 10 --min_maf 0.05 --extend_out \
#         --N_thresh 0.3 --call_thresh 0.9 \
#         --n_threads 60 --verbose 1 \
#         --n_ind $N_IND --n_sites $N_SITES | \
#             sort -k 1,1Vr -k 2,2V > $pop.allSNPs.ld

# done

for pop in CCAL SCAL INYO OREG
do
    $ngsLD/scripts/prune_ngsLD.py \
    --input $pop.allSNPs.ld \
    --max_dist 50000 \
    --min_weight 0.1 \
    --out $pop.allSNPs.unlinked.pos
done
