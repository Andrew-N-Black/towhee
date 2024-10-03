#!/bin/bash
#SBATCH -A fnrdewoody
#SBATCH --error=busco3.err
#SBATCH --output=busco3.out
#SBATCH --job-name=busco3
#SBATCH --mem=80G
#SBATCH -n 64
#SBATCH -t 10-00:00:00

ml biocontainers
ml busco/5.4.7
ml ncbi-datasets/16.10.3
datasets download genome taxon Passerellidae
mv ncbi_dataset/data/G*/*fna .

for i in `ls -1 *fna`
do
busco -i $i -l passeriformes_odb10 -o OUT_$i -m geno -f -c 64
done
