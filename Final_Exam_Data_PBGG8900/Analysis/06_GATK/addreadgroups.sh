#!/bin/bash
#SBATCH --job-name=readgroups
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G
#SBATCH --time=08:00:00
#SBATCH --output=readgroups.out
#SBATCH --error=readgroups.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load picard/3.3.0-Java-17
module load SAMtools/1.18-GCC-12.3.0

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK

for file in *_sorted.bam
do
    base=$(basename "$file" _sorted.bam)

    java -jar $EBROOTPICARD/picard.jar AddOrReplaceReadGroups \
        I=$file \
        O=${base}_RG.bam \
        RGSM=$base \
        RGLB=$base \
        RGPL=illumina \
        RGPU=${base}.1

    samtools index ${base}_RG.bam

done
