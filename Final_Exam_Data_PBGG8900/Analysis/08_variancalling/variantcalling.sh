#!/bin/bash
#SBATCH --job-name=variant
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=40G
#SBATCH --time=12:00:00
#SBATCH --output=variant.out
#SBATCH --error=variant.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17
module load SAMtools/1.18-GCC-12.3.0

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
INPUT=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK/02_dedup

mkdir -p vcf

for file in ${INPUT}/*_dedup.bam
do
    base=$(basename "$file" _dedup.bam)

    # ensure index exists
    samtools index $file

    gatk HaplotypeCaller \
        -R $REF \
        -I $file \
        -O vcf/${base}_Variant_raw.vcf.gz 

done
