#!/bin/sh
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 14-00:00:00
#SBATCH --job-name=towhee_muscle
#SBATCH --mem=120G

# =============================================================================
# MITOCHONDRIAL PHYLOGENY: align mtDNA sequences with ClustalW, then build a
# maximum-likelihood tree in IQ-TREE with 1000 ultrafast bootstrap and
# SH-aLRT replicates.
# =============================================================================

ml biocontainers
ml clustalw/2.1
module load iqtree/2.1.2

# Multiple sequence alignment of all mitochondrial sequences
clustalw -INFILE=towhee_mt_all.fa -align -outfile=towhee_clustal.fa

# ML tree with ultrafast bootstrap (-B) and SH-aLRT (-alrt) support
iqtree -s towhee_clustal.fa -B 1000 -alrt 1000 -T 16
 
