#!/bin/bash

#SBATCH --job-name=towhee_rga
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jeon96@purdue.edu
#SBATCH -o %x_%j.log

#install.packages("raster", repos="https://cran.case.edu/")

#load modules
#module load gdal
module load gdal/3.5.3_sqlite3
#module load geos/3.8.1
module load geos/3.9.4
module load r/4.1.2
module load udunits2/2.2.24
module load proj/8.2.1

#run Rscript
Rscript towhee_rga.R