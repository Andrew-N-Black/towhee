#!/bin/sh
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=towhee_muscle
#SBATCH --mem=120G

ml biocontainers
ml clustalw/2.1
module load iqtree/2.1.2
 
clustalw -INFILE=towhee_mt_all.fa -align -outfile=towhee_clustal.fa

iqtree -s towhee_clustal.fa -B 1000 -alrt 1000 -T 16
 
