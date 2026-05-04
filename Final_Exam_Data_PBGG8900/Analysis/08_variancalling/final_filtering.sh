#!/bin/bash
#SBATCH --job-name=final_filter
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --output=final_filter.out
#SBATCH --error=final_filter.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

# Paths
REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
WORKDIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

cd $WORKDIR

# SNP FILTERING

gatk VariantFiltration \
    -R $REF \
    -V All_sample_final_SNP.vcf.gz \
    -O All_sample_final_SNP_filtered.vcf.gz \
    --filter-name "QD_filter" --filter-expression "QD < 2.0" \
    --filter-name "FS_filter" --filter-expression "FS > 60.0" \
    --filter-name "MQ_filter" --filter-expression "MQ < 40.0" \
    --filter-name "SOR_filter" --filter-expression "SOR > 4.0"

# INDEL FILTERING

gatk VariantFiltration \
    -R $REF \
    -V All_sample_final_INDEL.vcf.gz \
    -O All_sample_final_INDEL_filtered.vcf.gz \
    --filter-name "QD_filter" --filter-expression "QD < 2.0" \
    --filter-name "FS_filter" --filter-expression "FS > 200.0" \
    --filter-name "SOR_filter" --filter-expression "SOR > 10.0"

# EXTRACT PASS VARIANTS

gatk SelectVariants \
    --exclude-filtered \
    -V All_sample_final_SNP_filtered.vcf.gz \
    -O All_sample_final_SNP_PASS.vcf.gz

gatk SelectVariants \
    --exclude-filtered \
    -V All_sample_final_INDEL_filtered.vcf.gz \
    -O All_sample_final_INDEL_PASS.vcf.gz
