#!/bin/bash
#SBATCH --job-name=metrics
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=06:00:00
#SBATCH --output=metrics.out
#SBATCH --error=metrics.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load picard/3.3.0-Java-17

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
INPUT=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK/02_dedup

mkdir -p alignment_metrics

for file in ${INPUT}/*_dedup.bam
do
    base=$(basename "$file" _dedup.bam)

    java -jar $EBROOTPICARD/picard.jar CollectAlignmentSummaryMetrics \
        R=$REF \
        INPUT=$file \
        OUTPUT=alignment_metrics/${base}_alignment_metrics.txt

done
