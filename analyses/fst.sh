#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 126
#SBATCH -t 12-00:00:00
#SBATCH --job-name=Fst
#SBATCH -e fst.err
#SBATCH -o fst.out
#SBATCH --mem=235G

module load biocontainers
module load angsd

REF=/scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa

#Angsd need the reference to be indexed first
samtools faidx /scratch/bell/blackan/TOWHEE/ref/NCBI/ref_100kb.fa



#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for OREG
#OREG_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/TOWHEE/angsd_out/FST/OREG \
-minInd 11 -minMapQ 30 -minQ 30 \
-bam ./OREG_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for CCAL
#CCAL_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/TOWHEE/angsd_out/FST/CCAL \
-minInd 24 -minMapQ 30 -minQ 30 \
-bam ./CCAL_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for INYO
#INYO_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/TOWHEE/angsd_out/FST/INYO \
-minInd 11 -minMapQ 30 -minQ 30 \
-bam ./INYO_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate per pop site allele frequency likelihoods (saf) for each population
#saf for SCAL
#SCAL_bamlist.txt

angsd -P 126 -out /scratch/bell/blackan/TOWHEE/angsd_out/FST/SCAL \
-minInd 18 -minMapQ 30 -minQ 30 \
-bam ./SCAL_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF


#calculate the 1D SFS from allele freq likelihoods
realSFS FST/OREG.saf.idx -P 126 -fold 1 > FST/OREG.sfs
realSFS FST/CCAL.saf.idx -P 126 -fold 1 > FST/CCAL.sfs
realSFS FST/INYO.saf.idx -P 126 -fold 1 > FST/INYO.sfs
realSFS FST/SCAL.saf.idx -P 126 -fold 1 > FST/SCAL.sfs


#calculate the 2D SFS
realSFS FST/OREG.saf.idx FST/CCAL.saf.idx -P 126 > FST/OREG.CCAL.ml
realSFS FST/OREG.saf.idx FST/INYO.saf.idx -P 126 > FST/OREG.INYO.ml
realSFS FST/OREG.saf.idx FST/SCAL.saf.idx -P 126 > FST/OREG.SCAL.ml
realSFS FST/CCAL.saf.idx FST/INYO.saf.idx -P 126 > FST/CCAL.INYO.ml
realSFS FST/CCAL.saf.idx FST/SCAL.saf.idx -P 126 > FST/CCAL.SCAL.ml
realSFS FST/INYO.saf.idx FST/SCAL.saf.idx -P 126 > FST/INYO.SCAL.ml


#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
mkdir FST/out
realSFS fst index FST/OREG.saf.idx FST/CCAL.saf.idx -sfs FST/OREG.CCAL.ml -fstout FST/out/OREG.CCAL -P 126
realSFS fst index FST/OREG.saf.idx FST/INYO.saf.idx -sfs FST/OREG.INYO.ml -fstout FST/out/OREG.INYO -P 126
realSFS fst index FST/OREG.saf.idx FST/SCAL.saf.idx -sfs FST/OREG.SCAL.ml -fstout FST/out/OREG.SCAL -P 126
realSFS fst index FST/CCAL.saf.idx FST/INYO.saf.idx -sfs FST/CCAL.INYO.ml -fstout FST/out/CCAL.INYO -P 126
realSFS fst index FST/CCAL.saf.idx FST/SCAL.saf.idx -sfs FST/CCAL.SCAL.ml -fstout FST/out/CCAL.SCAL -P 126
realSFS fst index FST/INYO.saf.idx FST/SCAL.saf.idx -sfs FST/INYO.SCAL.ml -fstout FST/out/INYO.SCAL -P 126

#Global pairwise estimates
realSFS fst stats FST/out/OREG.CCAL.fst.idx 
realSFS fst stats FST/out/OREG.INYO.fst.idx
realSFS fst stats FST/out/OREG.SCAL.fst.idx
realSFS fst stats FST/out/CCAL.INYO.fst.idx
realSFS fst stats FST/out/CCAL.SCAL.fst.idx
realSFS fst stats FST/out/INYO.SCAK.fst.idx



#sliding window analysis among all population samples

realSFS fst index FST/OREG.saf.idx FST/CCAL.saf.idx FST/INYO.saf.idx FST/SCAL.saf.idx -sfs FST/OREG.CCAL.ml -sfs FST/OREG.INYO.ml -sfs FST/OREG.SCAL.ml -sfs FST/CCAL.INYO.ml  -sfs FST/CCAL.SCAL.ml  -sfs FST/INYO.SCAL.ml -fstout FST/out/four_pop -P 126

realSFS fst stats2 FST/four_pop.fst.idx -win 50000 -step 25000 -P 126 > FST/out/slidingwindow

#Calculate average fst for each sliding windown analysis:
#cut -f 5 slidingwindow | tail -n +2 | awk '{ sum += $1 } END { print(sum / NR) }'

#cut -f 6 slidingwindow | tail -n +2 | awk '{ sum += $1 } END { print(sum / NR) }'

#cut -f 7 slidingwindow | tail -n +2 | awk '{ sum += $1 } END { print(sum / NR) }'

#cut -f 8 slidingwindow | tail -n +2 | awk '{ sum += $1 } END { print(sum / NR) }'


#DONE
