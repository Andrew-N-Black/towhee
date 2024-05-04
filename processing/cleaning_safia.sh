#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 30
#SBATCH -t 14-00:00:00
#SBATCH --job-name=trim
#SBATCH -e adapter_removal
#SBATCH -o adapter_removal



cd $SLURM_SUBMIT_DIR

# Go to the folder where you want to trimmomatic output

#cd trimmomatic
# Step 0: Make a list of all samples (samples.txt) with the name of each sample in a new line

#Step 1: Create folders for jobcodes and errors
#mkdir jobcodes errors

#Step 1: Create jobcodes for each sample

while read -a sample
do 
	echo "#!/bin/sh -l
#SBATCH -A fnrpupfish
#SBATCH -N 1
#SBATCH -n 10 # Change accordingly
#SBATCH -t 14-00:00:00 # Change accordingly
#SBATCH --job-name=${sample}.adptrem
#SBATCH -e %x
#SBATCH -o %x

cd $SLURM_SUBMIT_DIR
module load bioinfo
module load trimmomatic

# Step1: Adapter removal 

#java -jar /apps/trimmomatic/0.38/trimmomatic-0.38.jar
trimmomatic PE /scratch/bell/sjanjua/demo/data/${sample}*R1*fastq.gz /scratch/bell/sjanjua/demo/data/${sample}*R2*fastq.gz \
/scratch/bell/sjanjua/demo/trimmed/${sample}.R1.paired /scratch/bell/sjanjua/demo/trimmed/${sample}.R1.unpaired \
/scratch/bell/sjanjua/demo/trimmed/${sample}.R2.paired /scratch/bell/sjanjua/demo/trimmed/${sample}.R2.unpaired \
LEADING:20 TRAILING:20 MINLEN:30 -threads 20 \
ILLUMINACLIP:NexteraPE-PE.fa:2:40:10" > jobcodes/${sample}.adptrem.sh
done < samples.txt
#
#

#Step2: Run job in the errors folder for each sample

while read -a sample
do
	cd errors/
	sbatch ../jobcodes/${sample}.adptrem.sh
