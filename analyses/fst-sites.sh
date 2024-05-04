#!/bin/bash
#SBATCH -A fnrpredator
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=towhee_Fst-sites
#SBATCH -e %x_%j.err
#SBATCH -o %x_%j.out

#This script modified from a script written by Andrew Black

module load biocontainers
module load bioinfo
module load angsd
module load samtools

REF=/scratch/bell/dewoody/TOWHEE/ref/ref_100kb.fa

#Angsd need the reference to be indexed first
#samtools faidx /scratch/bell/dewoody/TOWHEE/ref/ref_100kb.fa

mkdir -p /scratch/bell/dewoody/TOWHEE/angsd_out/FST
cd /scratch/bell/dewoody/TOWHEE/

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site1
#Site1_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site1 \
-minInd 11 -minMapQ 30 -minQ 30 \
-bam ./Site1_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site2
#Site2_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site2 \
-minInd 6 -minMapQ 30 -minQ 30 \
-bam ./Site2_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site3
#Site3_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site3 \
-minInd 4 -minMapQ 30 -minQ 30 \
-bam ./Site3_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site4
#Site4_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site4 \
-minInd 5 -minMapQ 30 -minQ 30 \
-bam ./Site4_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site5
#Site5_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site5 \
-minInd 3 -minMapQ 30 -minQ 30 \
-bam ./Site5_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site6
#Site6_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site6 \
-minInd 2 -minMapQ 30 -minQ 30 \
-bam ./Site6_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site7
#Site7_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site7 \
-minInd 5 -minMapQ 30 -minQ 30 \
-bam ./Site7_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site8
#Site8_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site8 \
-minInd 11 -minMapQ 30 -minQ 30 \
-bam ./Site8_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site9
#Site8_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site9 \
-minInd 17 -minMapQ 30 -minQ 30 \
-bam ./Site9_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site9
#Site8_bamlist.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site10 \
-minInd 2 -minMapQ 30 -minQ 30 \
-bam ./Site10_bamlist.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

cd ./angsd_out/

#calculate the 1D SFS from allele freq likelihoods
realSFS FST/Site1.saf.idx -P 64 -fold 1 > FST/Site1.sfs
realSFS FST/Site2.saf.idx -P 64 -fold 1 > FST/Site2.sfs
realSFS FST/Site3.saf.idx -P 64 -fold 1 > FST/Site3.sfs
realSFS FST/Site4.saf.idx -P 64 -fold 1 > FST/Site4.sfs
realSFS FST/Site5.saf.idx -P 64 -fold 1 > FST/Site5.sfs
realSFS FST/Site6.saf.idx -P 64 -fold 1 > FST/Site6.sfs
realSFS FST/Site7.saf.idx -P 64 -fold 1 > FST/Site7.sfs
realSFS FST/Site8.saf.idx -P 64 -fold 1 > FST/Site8.sfs
realSFS FST/Site9.saf.idx -P 64 -fold 1 > FST/Site9.sfs
realSFS FST/Site10.saf.idx -P 64 -fold 1 > FST/Site10.sfs


#calculate the 2D SFS
for i in {1..10}; do
  for j in {1..10}; do
    if [[ $i -lt $j ]]; then
      echo "pairwise-Fst estimation between Site${i} and Site${j} started"
      realSFS FST/Site${i}.saf.idx FST/Site${j}.saf.idx -P 64 > FST/Site${i}.Site${j}.ml
      echo "pairwise-Fst estimation between Site${i} and Site${j} finished"
    fi
  done
done


#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
mkdir FST/out
for i in {1..10}; do
  for j in {1..10}; do
    if [[ ${i} -lt ${j} ]]; then
      echo "pairwise-Fst indexing between Site${i} and Site${j} started"
      realSFS fst index FST/Site${i}.saf.idx FST/Site${j}.saf.idx -sfs FST/Site${i}.Site${j}.ml -fstout FST/out/Site${i}.Site${j} -P 64
      echo "pairwise-Fst indexing between Site${i} and Site${j} finished"
    fi
  done
done

#Global pairwise estimates
for i in {1..10}; do
  for j in {1..10}; do
    if [[ ${i} -lt ${j} ]]; then
      echo "Global pairwise-Fst estimation between Site${i} and Site${j} started"
      realSFS fst stats FST/out/Site${i}.Site${j}.fst.idx -P 64
      echo "Global pairwise-Fst estimation between Site${i} and Site${j} finished"
    fi
  done
done


#sliding window analysis among all population samples
realSFS fst index FST/Site1.saf.idx FST/Site2.saf.idx FST/Site3.saf.idx FST/Site4.saf.idx FST/Site5.saf.idx \ 
FST/Site6.saf.idx FST/Site7.saf.idx FST/Site8.saf.idx FST/Site9.saf.idx FST/Site10.saf.idx \
-sfs FST/*.ml -fstout FST/out/all_sites -P 64

realSFS fst stats2 FST/all_sites.fst.idx -win 50000 -step 25000 -P 64 > FST/out/slidingwindow_allsites

#DONE