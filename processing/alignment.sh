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
mkdir jobs
#Define variables to shorten commands
REF=/scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa
DICT=/scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa.dict
FILT=/scratch/bell/blackan/TOWHEE/ref/NCBI/ok.bed
#bwa index $REF
#samtools faidx $REF
#PicardCommandLine CreateSequenceDictionary reference=$REF output=$DICT


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
cd /scratch/bell/blackan/TOWHEE/raw
# Align sample to indexed reference genome
bwa mem -t 10 -M -R \"@RG\tID:group1\tSM:${line[0]}\tPL:illumina\tLB:lib1\tPU:unit1\" \
/scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa \
${line[0]}_R1_001.fastq.gz ${line[0]}_R2_001.fastq.gz > ../aligned/${line[0]}.sam
#Move to aligned directory
cd ../aligned/
#Validate sam file
PicardCommandLine ValidateSamFile I=${line[0]}.sam MODE=SUMMARY O=${line[0]}.sam.txt
#Sort validated sam file by read coordinate
PicardCommandLine SortSam INPUT=${line[0]}.sam OUTPUT=sorted_${line[0]}.bam SORT_ORDER=coordinate
#Get summary stats on initial alignments:
samtools flagstat sorted_${line[0]}.bam > ${line[0]}_mapped.txt
#Mark duplicates
PicardCommandLine MarkDuplicates INPUT=sorted_${line[0]}.bam OUTPUT=dedup_${line[0]}.bam METRICS_FILE=metrics_${line[0]}.bam.txt OPTICAL_DUPLICATE_PIXEL_DISTANCE=2500
#Index in prep for realignment
PicardCommandLine BuildBamIndex INPUT=dedup_${line[0]}.bam
# local realignment of reads
GenomeAnalysisTK -T RealignerTargetCreator -nt 10 -R /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa -I dedup_${line[0]}.bam -o ${line[0]}_forIndelRealigner.intervals
#Realign with established intervals
GenomeAnalysisTK -T IndelRealigner -R /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa -I dedup_${line[0]}.bam -targetIntervals ${line[0]}_forIndelRealigner.intervals -o ${line[0]}_indel.bam
#Make new directory
#Fix mate info
PicardCommandLine FixMateInformation INPUT=dedup_${line[0]}.bam OUTPUT=${line[0]}.fixmate.bam SO=coordinate CREATE_INDEX=true
#   Remove unmapped (4), secondary (256), QC failed (512), duplicate (1024), and
#   supplementary (2048) reads from indel-realigned BAMs, and keep only reads
#   mapped in a proper pair (2) to regions in a BED file (produced from QC_reference.sh)
samtools view -@ 10 -q 30 -b -F 3844 -f 2 -L $FILT ${line[0]}.fixmate.bam > ../final_bams/${line[0]}_filt.bam 
#Move into the final directory
cd ../final_bams/
#Index bam file
PicardCommandLine BuildBamIndex INPUT=${line[0]}_filt.bam
# STEP_3: Get mapping stats


samtools depth -a ${line[0]}_filt.bam \
| awk '{c++;s+=\$3}END{print s/c}' \
> ${line}.towhee.meandepth.txt

samtools depth -a ${line[0]}_filt.bam \
| awk '{c++; if(\$3>0) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.1xbreadth.txt

samtools depth -a ${line[0]}_filt.bam \
| awk '{c++; if(\$3>=5) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.5xbreadth.txt

samtools depth -a ${line[0]}_filt.bam \
| awk '{c++; if(\$3>=10) total+=1}END{print (total/c)*100}' \
> ${line}.towhee.10xbreadth.txt


samtools stats /scratch/bell/sjanjua/towhee/lcwgs/align-caltref/dedup_${line}.towhee.bam \
> ${line}.towhee.stats.txt" > ./jobs/${line[0]}_aln.sh
done < sample.list


#for i in `ls -1 *sh`; do  echo "sbatch $i" ; done > jobs ; source jobs
