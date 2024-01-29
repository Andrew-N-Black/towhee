

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Submit job to create filtered beagle file for CCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=Beagle_LD
#SBATCH --error=Beagle_LD.e
#SBATCH --output=Beagle_LD.o
#SBATCH --mem=100G
module load biocontainers
module load angsd

#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
angsd -GL 1 -out ccal_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 9 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam CCAL_bamlist_inter.txt  \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


zcat ccal_I.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > Sites_ccal_I.txt
sed 1d  Sites_ccal_I.txt | wc -l
#

zcat ccal_I.beagle.gz | cut -f 4- | gzip  > ccal_format_I.beagle.gz

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl


#Remove header, which format conflicts with next step
sed 1d ccal_I.ld > ccal.LD

~/ngsLD/ngsLD --geno ccal_format_I.beagle.gz --probs --n_ind 30 --n_sites 3747089 --outH ccal.ld --posH Sites_ccal_I.txt --n_threads 20 --min_maf 0.05

#Remove physically linked sites, after removing header in north.ld file
 ~/prune_graph/target/release/prune_graph --in ccal.LD --weight-filter "column_3 <= 100000" --out ccalLD_unlinked_I.pos
 




&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Submit job to create filtered beagle file for INYO population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -n 10
#SBATCH -t 1-00:00:00
#SBATCH --job-name=Beagle_inyo
#SBATCH --error=Beagle_in.e
#SBATCH --output=Beagle_in.o
#SBATCH --mem=50G
module load biocontainers
module load angsd

#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
angsd -GL 1 -out inyo_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 9 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam INYO_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


zcat inyo_I.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > Sites_inyo_I.txt
sed 1d  Sites_inyo_I.txt | wc -l
#2861526

zcat inyo_I.beagle.gz | cut -f 4- | gzip  > inyo_I_format.beagle.gz



source  /etc/bashrc 
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl


~/ngsLD/ngsLD --geno inyo_format.beagle.gz --probs --n_ind 14 --n_sites 2861526 --outH inyo.ld --posH Sites_inyo.txt --n_threads 20 --min_maf 0.05 

#Remove header
sed 1d inyo.ld > inyo.LD
#Remove physically linked sites, after removing header in north.ld file
 ~/prune_graph/target/release/prune_graph --in inyo.LD --weight-field column_7 --weight-filter "column_3 <= 50000 && column_7 >= 0.5" --out northLD_unlinked.pos


&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Submit job to create filtered beagle file for OREG population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
#!/bin/sh -l
#SBATCH -A highmem
#SBATCH -n 10
#SBATCH -t 1-00:00:00
#SBATCH --job-name=Beagle_OR
#SBATCH --error=Beagle_OR.e
#SBATCH --output=Beagle_OR.o
#SBATCH --mem=50G
module load biocontainers
module load angsd

#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
angsd -GL 1 -out oregon -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 10 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam OREG_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


zcat oregon_I.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > Sites_oreg_I.txt
sed 1d  Sites_oreg_I.txt | wc -l
#2483151

zcat oregon_I.beagle.gz | cut -f 4- | gzip  > oregon_I_format.beagle.gz



source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl


~/ngsLD/ngsLD --geno oregon_format.beagle.gz --probs --n_ind 14 --n_sites 2483151 --outH oreg.ld --posH Sites_inyo.txt --n_threads 20 --min_maf 0.05

#Remove physically linked sites, after removing header in north.ld file
 ~/prune_graph/target/release/prune_graph --in oreg.LD --weight-field column_7 --weight-filter "column_3 <= 50000 && column_7 >= 0.5" --out oregonLD_unlinked.pos

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Submit job to create filtered beagle file for SCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=Beagle_OR
#SBATCH --error=Beagle_OR.e
#SBATCH --output=Beagle_OR.o
#SBATCH --mem=50G
module load biocontainers
module load angsd

#Move to bam folder
cd /scratch/bell/blackan/TOWHEE/angsd_out
angsd -GL 1 -out scal_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 15 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam SCAL_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


zcat scal.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > Sites_scal.txt
sed 1d  Sites_scal.txt | wc -l
#4185182

zcat scal.beagle.gz | cut -f 4- | gzip  > scal_format.beagle.gz



source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl


~/ngsLD/ngsLD --geno scal_format.beagle.gz --probs --n_ind 23 --n_sites 4185182 --outH scal.ld --posH Sites_scal.txt --n_threads 20 --min_maf 0.05

#Remove header
sed 1d scal.ld > scal.LD

#Remove physically linked sites, after removing header in north.ld file
 ~/prune_graph/target/release/prune_graph --in scal.LD --weight-field column_7 --weight-filter "column_3 <= 50000 && column_7 >= 0.5" --out scalLD_unlinked.pos


&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&   Identify shared sites among all populations and index file to filter each population    &&&&&&&&&&&&&&&&                                                    
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


 # Identify unlinked sites that are shared between both populations
 wc -l *pos

  
 awk 'NR==FNR {a[$1]; next} $1 in a' inyoLD_unlinked.pos oregLD_unlinked.pos > sites.match1
 awk 'NR==FNR {a[$1]; next} $1 in a' ccalLD_unlinked.pos scalLD_unlinked.pos > sites.match2
 awk 'NR==FNR {a[$1]; next} $1 in a' sites.match1 sites.match2 > sites.match

#Shared sites
 wc -l sites.match* 
  #10723 sites.match
  #33912 sites.match1
  #502457 sites.match2

#Change delim and copy for new beagle file generation
 sed 's|:|\t|g' sites.match > LD.sites 
 
 ml biocontainers angsd
 angsd sites inex LD.sites


&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of shared LD sites for CCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=ld
#SBATCH --error=ld.e
#SBATCH --output=ld.o
#SBATCH --mem=50G
module load biocontainers 
module load angsd


angsd -GL 1 -out ccal_ld -sites LD.sites -P 10 -bam ccal \
-doGlf 2 -doMajorMinor 1 -doMaf 1   \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa


&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of shared LD sites for SCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

 #!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=ld
#SBATCH --error=ld.e
#SBATCH --output=ld.o
#SBATCH --mem=50G
module load biocontainers 
module load angsd


angsd -GL 1 -out scal_ld -sites LD.sites -P 10 -bam scal \
-doGlf 2 -doMajorMinor 1 -doMaf 1   \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of shared LD sites for OREG population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

 #!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=ld
#SBATCH --error=ld.e
#SBATCH --output=ld.o
#SBATCH --mem=50G
module load biocontainers 
module load angsd


angsd -GL 1 -out oreg_ld -sites LD.sites -P 10 -bam oreg \
-doGlf 2 -doMajorMinor 1 -doMaf 1   \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of shared LD sites for INYO population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

 #!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=ld
#SBATCH --error=ld.e
#SBATCH --output=ld.o
#SBATCH --mem=50G
module load biocontainers 
module load angsd


angsd -GL 1 -out inyo_ld -sites LD.sites -P 10 -bam inyo \
-doGlf 2 -doMajorMinor 1 -doMaf 1   \
-ref /scratch/bell/blackan/TOWHEE/ref/NCBI/ref.fa

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of filtered R2 for INYO population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat inyo_ld.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > LDSites_inyo.txt
sed 1d  LDSites_inyo.txt | wc -l
#10723

zcat inyo_ld.beagle.gz | cut -f 4- | gzip  > inyo_ld_format.beagle.gz

~/ngsLD/ngsLD --geno inyo_ld_format.beagle.gz --probs --n_ind 14 --n_sites 10723 --outH filtered_inyo.ld --posH LDSites_inyo.txt --n_threads 20 --min_maf 0.05

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of filtered R2 for OREG population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat oreg_ld.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > LDSites_oreg.txt
sed 1d  LDSites_oreg.txt | wc -l
#10723

zcat oreg_ld.beagle.gz | cut -f 4- | gzip  > oreg_ld_format.beagle.gz

~/ngsLD/ngsLD --geno oreg_ld_format.beagle.gz --probs --n_ind 14 --n_sites 10723 --outH filtered_oreg.ld --posH LDSites_oreg.txt --n_threads 20 --min_maf 0.05

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of filtered R2 for SCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat scal_ld.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > LDSites_scal.txt
sed 1d  LDSites_scal.txt | wc -l
#10723

zcat scal_ld.beagle.gz | cut -f 4- | gzip  > scal_ld_format.beagle.gz

~/ngsLD/ngsLD --geno scal_ld_format.beagle.gz --probs --n_ind 23 --n_sites 10723 --outH filtered_scal.ld --posH LDSites_scal.txt --n_threads 20 --min_maf 0.05

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Create beagle file of filtered R2 for CCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat ccal_ld.beagle.gz | cut -f 1 | sed 's/NW_/NW./g' | tr "_" "\t" | sed 's/NW./NW_/g' > LDSites_ccal.txt
sed 1d  LDSites_ccal.txt | wc -l
#10723

zcat ccal_ld.beagle.gz | cut -f 4- | gzip  > ccal_ld_format.beagle.gz

~/ngsLD/ngsLD --geno ccal_ld_format.beagle.gz --probs --n_ind 30 --n_sites 10723 --outH filtered_ccal.ld --posH LDSites_ccal.txt --n_threads 20 --min_maf 0.05




