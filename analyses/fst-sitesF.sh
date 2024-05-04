#!/bin/bash
#SBATCH -A fnrtowhee
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=towhee_Fst-sitesF
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
#saf for Site1F
#Site1_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site1F \
  -minInd 6 -minMapQ 30 -minQ 30 \
  -bam ./Site1_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site2F
#Site1_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site2F \
  -minInd 3 -minMapQ 30 -minQ 30 \
  -bam ./Site2_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site3F
#Site3_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site3F \
  -minInd 3 -minMapQ 30 -minQ 30 \
  -bam ./Site3_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site4F
#Site4_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site4F \
  -minInd 5 -minMapQ 30 -minQ 30 \
  -bam ./Site4_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site5F
#Site5_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site5F \
  -minInd 1 -minMapQ 30 -minQ 30 \
  -bam ./Site5_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF

#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site7F
#Site7_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site7F \
  -minInd 4 -minMapQ 30 -minQ 30 \
  -bam ./Site7_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site8F
#Site8_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site8F \
  -minInd 6 -minMapQ 30 -minQ 30 \
  -bam ./Site8_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site9F
#Site9_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site9F \
  -minInd 13 -minMapQ 30 -minQ 30 \
  -bam ./Site9_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
#first calculate site allele frequency likelihoods (saf) for each site
#saf for Site10F
#Site10_bamlistF.txt

angsd -P 64 -out /scratch/bell/dewoody/TOWHEE/angsd_out/FST/Site10F \
  -minInd 2 -minMapQ 30 -minQ 30 \
  -bam ./Site10_bamlistF.txt -doCounts 1 -GL 1 -doSaf 1 -anc $REF -ref $REF
  
cd ./angsd_out/

#calculate the 1D SFS from allele freq likelihoods
for i in {1..10}; do
  [[ ${i} -eq 6 ]] && continue
  realSFS FST/Site${i}F.saf.idx -P 64 -fold 1 > FST/Site${i}F.sfs
done


#calculate the 2D SFS
for i in {1..10}; do
  [[ ${i} -eq 6 ]] && continue
  for j in {1..10}; do
    [[ ${j} -eq 6 ]] && continue
    if [[ $i -lt $j ]]; then
      echo "pairwise-Fst estimation between Site${i}F and Site${j}F started"
      realSFS FST/Site${i}F.saf.idx FST/Site${j}F.saf.idx -P 64 > FST/Site${i}F.Site${j}F.ml
      echo "pairwise-Fst estimation between Site${i}F and Site${j}F finished"
    fi
  done
done


#Now pairwise Fsts

#Index sample so same sites are analyzed for each pop
mkdir FST/out
for i in {1..10}; do
  [[ ${i} -eq 6 ]] && continue
  for j in {1..10}; do
    [[ ${j} -eq 6 ]] && continue
    if [[ ${i} -lt ${j} ]]; then
      echo "pairwise-Fst indexing between Site${i}F and Site${j}F started"
      realSFS fst index FST/Site${i}F.saf.idx FST/Site${j}F.saf.idx -sfs FST/Site${i}F.Site${j}F.ml -fstout FST/out/Site${i}F.Site${j}F -P 64
      echo "pairwise-Fst indexing between Site${i}F and Site${j}F finished"
    fi
  done
done

#Global pairwise estimates
for i in {1..10}; do
  [[ ${i} -eq 6 ]] && continue
  for j in {1..10}; do
    [[ ${j} -eq 6 ]] && continue
    if [[ ${i} -lt ${j} ]]; then
      echo "Global pairwise-Fst estimation between Site${i}F and Site${j}F started"
      realSFS fst stats FST/out/Site${i}F.Site${j}F.fst.idx -P 64
      echo "Global pairwise-Fst estimation between Site${i}F and Site${j}F finished"
    fi
  done
done


#DONE