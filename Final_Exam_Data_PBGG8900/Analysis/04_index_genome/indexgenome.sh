#!/bin/bash
#SBATCH --job-name=bwa_index
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=8G
#SBATCH --time=01:00:00
#SBATCH --output=index.out
#SBATCH --error=index.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load BWA/0.7.18-GCCcore-13.3.0
module load SAMtools/1.18-GCC-12.3.0

# Go to indexing folder
cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/04_Index_genome

# Copy genome here (optional but cleaner)
cp /scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta .

# Run BWA index
bwa index Lst.genome.fasta

