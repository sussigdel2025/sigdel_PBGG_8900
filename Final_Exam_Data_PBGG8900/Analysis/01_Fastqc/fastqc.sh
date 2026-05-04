#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=fastqc.out
#SBATCH --error=fastqc.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

# Load module
module purge
module load FastQC

# Move to Analysis directory (optional safety)
cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis

# Create output directory
mkdir -p results

# Run FastQC on all raw data
fastqc -t 6 -o results ../Rawdata/*.fq.gz
