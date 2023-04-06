#!/bin/bash

#SBATCH --job-name=towhee_omni
#SBATCH -A highmem
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=jeon96@purdue.edu
#SBATCH -o %x_%j.log

module load julia
cd /scratch/bell/jeon96/Towhee/

#cp /scratch/bell/jeon96/Towhee/rga/all/topo/Results/ele_low.slo_low.asp_low.asc /scratch/bell/jeon96/Towhee/rga/all/topo/Results/ele_low.slo_low.asp_low.omni.asc

# run julia script
export JULIA_DEPOT_PATH="$HOME/.Julia"
export JULIA_NUM_THREADS=64
julia towhee_omni.jl