#!/bin/bash
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=towhee_Fst-sitesM
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
#saf for Site1M
#Site1_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site1M \
  -minInd 6 -minMapQ 30 -minQ 30 \
  -bam ./Site1_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site2M
#Site2_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site2M \
  -minInd 4 -minMapQ 30 -minQ 30 \
  -bam ./Site2_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site3M
#Site3_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site3M \
  -minInd 2 -minMapQ 30 -minQ 30 \
  -bam ./Site3_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site5M
#Site5_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site5M \
  -minInd 3 -minMapQ 30 -minQ 30 \
  -bam ./Site5_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site6M
#Site6_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site6M \
  -minInd 2 -minMapQ 30 -minQ 30 \
  -bam ./Site6_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site7M
#Site7_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site7M \
  -minInd 2 -minMapQ 30 -minQ 30 \
  -bam ./Site7_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site8M
#Site8_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site8M \
  -minInd 6 -minMapQ 30 -minQ 30 \
  -bam ./Site8_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site9M
#Site9_bamlistM.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site9M \
  -minInd 5 -minMapQ 30 -minQ 30 \
  -bam ./Site9_bamlistM.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
cd ./angsd_out/

#calculate the 1D SFS from allele freq likelihoods
for i in {1..9}; do
  [[ ${i} -eq 4 ]] && continue
  realSFS FST/Site${i}M.saf.idx -P 64 -fold 1 > FST/Site${i}M.sfs
done

#calculate the 2D SFS
for i in {1..9}; do
  [[ ${i} -eq 4 ]] && continue
  for j in {1..9}; do
    [[ ${j} -eq 4 ]] && continue
    if [[ $i -lt $j ]]; then
      echo "pairwise-Fst estimation between Site${i}M and Site${j}M started"
      realSFS FST/Site${i}M.saf.idx FST/Site${j}M.saf.idx -P 64 > FST/Site${i}M.Site${j}M.ml
      echo "pairwise-Fst estimation between Site${i}M and Site${j}M finished"
    fi
  done
done


#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
mkdir FST/out
for i in {1..9}; do
  [[ ${i} -eq 4 ]] && continue
  for j in {1..9}; do
    [[ ${j} -eq 4 ]] && continue
    if [[ ${i} -lt ${j} ]]; then
      echo "pairwise-Fst indexing between Site${i}M and Site${j}M started"
      realSFS fst index FST/Site${i}M.saf.idx FST/Site${j}M.saf.idx -sfs FST/Site${i}M.Site${j}M.ml -fstout FST/out/Site${i}M.Site${j}M -P 64
      echo "pairwise-Fst indexing between Site${i}M and Site${j}M finished"
    fi
  done
done

#Global pairwise estimates
for i in {1..9}; do
  [[ ${i} -eq 4 ]] && continue
  for j in {1..9}; do
    [[ ${j} -eq 4 ]] && continue
    if [[ ${i} -lt ${j} ]]; then
      echo "Global pairwise-Fst estimation between Site${i}M and Site${j}M started"
      realSFS fst stats FST/out/Site${i}M.Site${j}M.fst.idx -P 64
      echo "Global pairwise-Fst estimation between Site${i}M and Site${j}M finished"
    fi
  done
done


#DONE