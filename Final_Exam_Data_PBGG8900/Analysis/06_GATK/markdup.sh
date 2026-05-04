#!/bin/bash
#SBATCH --job-name=markdup
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=12:00:00
#SBATCH --output=markdup.out
#SBATCH --error=markdup.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17
module load SAMtools/1.18-GCC-12.3.0

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK

for file in 01_RG/*_RG.bam
do
    base=$(basename "$file" _RG.bam)

    gatk MarkDuplicatesSpark \
        -I "$file" \
        -M ${base}_metrics.txt \
        -O 02_dedup/${base}_dedup.bam

    samtools index 02_dedup/${base}_dedup.bam

done
