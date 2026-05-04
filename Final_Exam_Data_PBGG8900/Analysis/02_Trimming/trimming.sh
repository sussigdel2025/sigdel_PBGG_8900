#!/bin/bash
#SBATCH --job-name=trim
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=16G
#SBATCH --time=02:00:00
#SBATCH --output=trim.out
#SBATCH --error=trim.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load cutadapt

# Stay in this directory
cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/02_Trimming

# Make output folder
mkdir -p trimmed_reads

# Loop through all raw files
for file in /scratch/ss70339/Final_Exam_Data_PBGG8900/Rawdata/*.fq.gz
do
    base=$(basename $file .fq.gz)

    cutadapt \
    -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCA \
    -q 20 \
    -m 30 \
    -o trimmed_reads/${base}_trimmed.fq.gz \
    $file
done
