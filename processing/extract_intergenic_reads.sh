
#!/bin/bash
#SBATCH -A fnrdewoody
#SBATCH -n 10
#SBATCH -t 1-00:00:00
#SBATCH --job-name=parse
#SBATCH --error=parse.e
#SBATCH --output=parse.o
#SBATCH --mem=100G

module load bioinfo
module load samtools
module load bedtools

for i in `ls -1 *filt.bam`; do bedtools intersect -v -abam $i -b towhee_genes.bed  > ./INTER/${i} ; samtools index ./INTER/${i}; done

#Move to output	directory and rerun with an extended bed file (100kb). OUtput files into a new directory and index
cd INTER
for i in `ls -1 *filt.bam`; do bedtools intersect -v -abam $i -b towhee_genes_100kb.bed  > ./DESERT/${i} ; samtools index ./DESERT/${i}; done

