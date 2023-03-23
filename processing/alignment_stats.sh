#!/bin/bash
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -t 1-00:00:00
#SBATCH --error=align.err
#SBATCH --output=align.out
#SBATCH --job-name=produce_align_SLURMM_jobs


module purge
module load bioinfo
module load bwa
module load picard-tools
module load bedops
module load GATK/3.6.0
module load samtools

#Move to fastq containing directory
cd /scratch/bell/blackan/TOWHEE/raw
#Make sample list
ls -1 *.fastq.gz | sed "s/_R[1-2]_001.fastq.gz//g" | uniq > sample.list
#Make directory to hold all SLURMM jobs
mkdir jobs2


while read -a line
do 
	echo "#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 05-00:00:00
#SBATCH --job-name=${line[0]}_aln
#SBATCH --error=${line[0]}_aln.e
#SBATCH --output=${line[0]}_aln.o
#SBATCH --mem=15G
module --force purge
module load bioinfo
module load bwa
module load picard-tools
module load bedops
module load GATK/3.6.0
module load samtools
#Move to the paired-end fastq containing folder
cd /scratch/bell/blackan/TOWHEE/aligned
PicardCommandLine BuildBamIndex INPUT=${line[0]}.fixmate.bam

# STEP_3: Get mapping stats


samtools depth -a ${line[0]}.fixmate.bam \
| awk '{c++;s+=\$3}END{print s/c}' \
> ${line}.towhee.meandepth.txt

samtools depth -a ${line[0]}.fixmate.bam \
| awk '{c++; if(\$3>0) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.1xbreadth.txt

samtools depth -a ${line[0]}.fixmate.bam \
| awk '{c++; if(\$3>=5) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.5xbreadth.txt

samtools depth -a ${line[0]}.fixmate.bam \
| awk '{c++; if(\$3>=10) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.10xbreadth.txt" > ./jobs2/${line[0]}_aln.sh
done < sample.list


#for i in `ls -1 *sh`; do  echo "sbatch $i" ; done > jobs ; source jobs
