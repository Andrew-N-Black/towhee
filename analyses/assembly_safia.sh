#!/bin/sh -l
#SBATCH -A fnrquail
#SBATCH --mail-type=ALL
#SBATCH --mail-user=sjanjua@purdue.edu
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -t 1:00:00
#SBATCH --job-name=hifiasm
#SBATCH -e hifiasm-204710
#SBATCH -o hifiasm-204710

cd $SLURM_SUBMIT_DIR

/depot/fnrdewoody/apps/hifiasm/hifiasm -o CALT.asm -t 32 4SMRTcells.hifi_reads.fastq.gz

module purge --force
module load anaconda
conda create -n towhee-busco -c conda-forge -c bioconda busco=5.2.2
conda activate towhee-busco
busco -i all4.asm.bp.p_ctg.fa -l passeriformes_odb10 -o towhee_busco_report -m genome -f

#add a path to search apps
export PATH=$PATH:/depot/fnrdewoody/apps/
export PATH=$PATH:/home/sjanjua/apps/

#load fastQC and trimmomatic
module load zlib/1.2.11
module load bioinfo
module load minimap2/2.17
module load anaconda
module load conda-env/myapps-py3.7.6

#Install Purge_Dups in advance because you may need to modify configuration file
#git clone https://github.com/dfguan/purge_dups.git
#cd purge_dups/src && make
#Install Runnder (optional) needed when you want to run scripts/run_purge_dups.py
git clone https://github.com/dfguan/runner.git
cd runner && python3 setup.py install --user
#Install K-mer comparison plot tool
#git clone https://github.com/dfguan/KMC.git 
#cd KMC && make -j 16

#CONFIG=/home/sjanjua/apps/purge_dups/scripts/pd_config.py

#Generate configuration file
#$CONFIG -n config.Towhee.HiFi.asm.json $BASEDIR'HiFiasm/HiFiasm_output/all.asm.p_ctg.fa' ${BASEDIR}Towhee_HiFi.fofn

#Modify configuration file if needed (e.g. busco lineage)
#I manually made config file and modified the lineage to "passeriformes"

#PURGE_DUPS=/home/sjanjua/apps/purge_dups/scripts/run_purge_dups.py

#Run purge_dups
#python $PURGE_DUPS -p slurm ${BASEDIR}config.Towhee.HiFi.asm.json /home/sjanjua/apps/purge_dups/src Towhee 

#Check the coverage plot to validate the purged assembly
#Busco
#The automated code submits internal jobs into "standby" queues that would be PD forever

#If needed, modify cut-off values and follow manual pipeline: https://github.com/dfguan/purge_dups
PB_list=$`cat /scratch/bell/sjanjua/Practice/Towhee_HiFi.fofn`
PRI_ASM=/scratch/bell/sjanjua/Practice/all.asm.p_ctg.fa

#Step 1. Run minimap2 to align pacbio data and generate paf files, then calculate read depth histogram and base-level read depth. Commands are as follows:
for i in $PB_list
do
	minimap2 -xmap-pb $PRI_ASM $i | gzip -c - > $i.paf.gz
done
bin/pbcstat *.paf.gz #(produces PB.base.cov and PB.stat files)
bin/calcuts PB.stat > cutoffs 2>calcults.log

#Step 1. Split an assembly and do a self-self alignment. Commands are following:
bin/split_fa $PRI_ASM > $PRI_ASM.split
minimap2 -xasm5 -DP $PRI_ASM.split $PRI_ASM.split | gzip -c - > $PRI_ASM.split.self.paf.gz

#Step 2. Purge haplotigs and overlaps with the following command.
bin/purge_dups -2 -T cutoffs -c PB.base.cov $PRI_ASM.split.self.paf.gz > dups.bed 2> purge_dups.log

#Step 3. Get purged primary and haplotig sequences from draft assembly.
bin/get_seqs -e dups.bed $PRI_ASM 

#Check the coverage plot to validate the purged assembly
#Do Busco again and compare


module purge --force
module load bioinfo
module load quast/3.2

# Convert to gfa to fasta
awk '/^S/{print ">"$2"\n"$3}' /scratch/bell/sjanjua/towhee/practice/m64108e_210614_204710/m64108e_210614_204710.asm.bp.p_ctg.gfa | fold > /scratch/bell/sjanjua/towhee/practice/m64108e_210614_204710/m64108e_210614_204710.asm.bp.p_ctg.fa

python /group/bioinfo/apps/apps/quast-3.2/quast.py \
-o /scratch/bell/sjanjua/towhee/practice/quast/m64108e_210614_204710 \
--eukaryote -t 10 \
/scratch/bell/sjanjua/towhee/practice/m64108e_210614_204710/m64108e_210614_204710.asm.bp.p_ctg.fa


