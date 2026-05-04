#!/bin/bash
#SBATCH --job-name=fastqc_trim
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=12G
#SBATCH --time=01:00:00
#SBATCH --output=fastqc_trim.out
#SBATCH --error=fastqc_trim.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load FastQC

# Go to this folder
cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/03_FastQC

# Make results folder
mkdir -p results

#change folder to the trimmed data
ls /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/02_Trimming/trimmed_reads/*.fq.gz

# Run FastQC
fastqc -t 6 \
-o results \
/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/02_Trimming/trimmed_reads/*.fq.gz
