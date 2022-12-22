#!/bin/bash
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH --error=het.err
#SBATCH --output=het.out
#SBATCH --job-name=produce_het_SLURMM_jobs



mkdir jobs_het
mkdir HET
#cat bams | cut -d "/" -f 7 | sed 's/.bam//g' >sample.list
while read -a line
do 
	echo "#!/bin/sh -l
#SBATCH -A fnrtowhee
#SBATCH -n 5
#SBATCH -t 14-00:00:00
#SBATCH --job-name=${line[0]}_het_stats
#SBATCH --error=${line[0]}_het_stats.e
#SBATCH --output=${line[0]}_het_stats.o
#SBATCH --mem=10G


#Move to the angsd_output folder containing folder
cd /scratch/bell/blackan/TOWHEE/angsd_out


/depot/fnrdewoody/apps/angsd/angsd -i ../final_bams/${line[0]}.bam -ref /scratch/bell/blackan/TOWHEE/ref/calt-purged.rm.fa -anc /scratch/bell/blackan/TOWHEE/ref/calt-purged.rm.fa -dosaf 1 \
-minMapQ 30 -GL 1 -P 5 -out HET/${line[0]} -doCounts 1 -setMinDepth 3

/depot/fnrdewoody/apps/angsd/misc/realSFS -P 5 -fold 1 HET/${line[0]}.saf.idx > HET/${line[0]}_est.ml" > ./jobs_het/${line[0]}_alignment.sh

done < ./sample.list

#for i in `ls -1 *sh`; do  echo "sbatch $i" ; done > jobs ; source ./jobs

