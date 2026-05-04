#!/bin/bash
#SBATCH --job-name=bqsr
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=06:00:00
#SBATCH --output=bqsr.out
#SBATCH --error=bqsr.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
BAM_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/06_GATK/02_dedup
VAR_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

mkdir -p recal_tables

for file in ${BAM_DIR}/*_dedup.bam
do
    base=$(basename "$file" _dedup.bam)

    gatk BaseRecalibrator \
        -R $REF \
        -I $file \
        --known-sites ${VAR_DIR}/SNPs_PASS/${base}_SNP_PASS.vcf.gz \
        --known-sites ${VAR_DIR}/INDELs_PASS/${base}_INDEL_PASS.vcf.gz \
        -O recal_tables/${base}_recal.table

done
