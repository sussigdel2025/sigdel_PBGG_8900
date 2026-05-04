#!/bin/bash
#SBATCH --job-name=apply_bqsr
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=30G
#SBATCH --time=06:00:00
#SBATCH --output=apply.out
#SBATCH --error=apply.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17
module load SAMtools/1.18-GCC-12.3.0

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
BAM_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK/02_dedup
TABLE_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling/recal_tables

mkdir -p recalibrated_bam

for file in ${BAM_DIR}/*_dedup.bam
do
    base=$(basename "$file" _dedup.bam)

    gatk ApplyBQSR \
        -R $REF \
        -I $file \
        --bqsr-recal-file ${TABLE_DIR}/${base}_recal.table \
        -O recalibrated_bam/${base}_BR.bam

    samtools index recalibrated_bam/${base}_BR.bam

done
