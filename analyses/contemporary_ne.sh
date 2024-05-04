

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
angsd -GL 1 -out ccal_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 9 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam CCAL_bamlist_inter.txt  \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat ccal_I.beagle.gz | awk 'NR % 1000 == 0' | cut -f 4- | gzip > ccal_subset1k.beagle.gz
zcat ccal_I.mafs.gz | cut -f 1,2 |  awk 'NR % 1000 == 0' | sed 's/:/_/g'| gzip > ccal_pos.gz
 
 
~/ngsLD/ngsLD --geno ccal_subset1k.beagle.gz --probs --n_ind 30 --n_sites 3747 --outH ccal_I.ld --pos ccal_pos.gz --n_threads 20 --min_maf 0.05  --max_kb_dist 0



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

angsd -GL 1 -out inyo_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 9 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam INYO_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa


source  /etc/bashrc 
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat inyo_I.beagle.gz | awk 'NR % 1000 == 0' | cut -f 4- | gzip > inyo_subset1k.beagle.gz
zcat inyo_I.mafs.gz | cut -f 1,2 |  awk 'NR % 1000 == 0' | sed 's/:/_/g'| gzip > inyo_pos.gz
 
 
~/ngsLD/ngsLD --geno inyo_subset1k.beagle.gz --probs --n_ind 14 --n_sites 2861 --outH inyo_I.ld --pos inyo_pos.gz --n_threads 20 --min_maf 0.05  --max_kb_dist 0

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
#SBATCH --mem=100G
module load biocontainers
module load angsd

#Move to bam folder
angsd -GL 1 -out oregon_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 10 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam OREG_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl

zcat oregon_I.beagle.gz | awk 'NR % 1000 == 0' | cut -f 4- | gzip > oreg_subset1k.beagle.gz
zcat oregon_I.mafs.gz | cut -f 1,2 |  awk 'NR % 1000 == 0' | sed 's/:/_/g'| gzip > oreg_pos.gz
 
 
~/ngsLD/ngsLD --geno oreg_subset1k.beagle.gz --probs --n_ind 14 --n_sites 2483 --outH oreg_I.ld --pos oreg_pos.gz --n_threads 20 --min_maf 0.05  --max_kb_dist 0

&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
                   Submit job to create filtered beagle file for SCAL population                                                             
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&

#!/bin/bash
#SBATCH -A highmem
#SBATCH -n 10
#SBATCH -t 10-00:00:00
#SBATCH --job-name=Beagle_OR
#SBATCH --error=Beagle_OR.e
#SBATCH --output=Beagle_OR.o
#SBATCH --mem=100G
module load biocontainers
module load angsd

#Move to bam folder
angsd -GL 1 -out scal_I -minQ 30 -P 10 -doDepth 1 -doCounts 1 -setMinDepthInd 3 \
-minInd 15 -doGlf 2 -doMajorMinor 1 -doMaf 1 -minMaf 0.05 -skipTriallelic 1 -SNP_pval 1e-6 -bam SCAL_bamlist_inter.txt \
-minHWEpval 0.05 -doHWE 1  \
-ref /scratch/bell/blackan/TOWHEE/analysis/ref/NCBI/ref.fa

source  /etc/bashrc
module reset
module --force purge
module load anaconda/2020.11-py38
conda activate ld
ml gcc
ml zlib
ml gsl


zcat scal_I.beagle.gz | awk 'NR % 1000 == 0' | cut -f 4- | gzip > scal_subset1k.beagle.gz
zcat scal_I.mafs.gz | cut -f 1,2 |  awk 'NR % 1000 == 0' | sed 's/:/_/g'| gzip > scal_pos.gz
 
 
~/ngsLD/ngsLD --geno scal_subset1k.beagle.gz --probs --n_ind 21 --n_sites 4306 --outH scal_I.ld --pos scal_pos.gz --n_threads 20 --min_maf 0.05  --max_kb_dist 0

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




