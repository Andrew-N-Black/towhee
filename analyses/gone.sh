#!/bin/sh -l
#SBATCH -A fnrchook
#SBATCH -N 1
#SBATCH -n 128
#SBATCH -t 14-00:00:00
#SBATCH --job-name=gone
#SBATCH --error=%x_%j.out
#SBATCH --output=%x_%j.out
#SBATCH --mem=249G

POP=CCAL,SCAL,OREG,INYO
bash script_GONE.sh POP
