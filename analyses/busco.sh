#!/bin/bash
#SBATCH -A fnrdewoody
#SBATCH --error=busco3.err
#SBATCH --output=busco3.out
#SBATCH --job-name=busco3
#SBATCH --mem=80G
#SBATCH -n 64
#SBATCH -t 10-00:00:00

# =============================================================================
# BUSCO GENE COMPLETENESS across all Passerellidae (New World sparrow family)
# reference genomes on NCBI, for comparison against the towhee assembly
# (feeds R/busco.R, Figure 2).
# =============================================================================

ml biocontainers
ml busco/5.4.7
ml ncbi-datasets/16.10.3
# Download every published Passerellidae genome assembly from NCBI
datasets download genome taxon Passerellidae
mv ncbi_dataset/data/G*/*fna .

# Run BUSCO (passeriformes_odb10 lineage) against each downloaded genome
for i in `ls -1 *fna`
do
busco -i $i -l passeriformes_odb10 -o OUT_$i -m geno -f -c 64
done
