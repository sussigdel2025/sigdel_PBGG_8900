#!/bin/bash
#SBATCH --job-name=filter
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --output=filter.out
#SBATCH --error=filter.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta
BASE_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

mkdir -p SNPs_filtered INDELs_filtered

# SNP FILTERING
for file in ${BASE_DIR}/SNPs/*_SNP_raw.vcf.gz
do
    base=$(basename "$file" _SNP_raw.vcf.gz)

    gatk VariantFiltration \
        -R $REF \
        -V $file \
        -O SNPs_filtered/${base}_SNP_filtered.vcf.gz \
        --filter-name "QD_filter" --filter-expression "QD < 2.0" \
        --filter-name "FS_filter" --filter-expression "FS > 60.0" \
        --filter-name "MQ_filter" --filter-expression "MQ < 40.0" \
        --filter-name "SOR_filter" --filter-expression "SOR > 4.0"
done

# INDEL FILTERING
for file in ${BASE_DIR}/INDELs/*_INDEL_raw.vcf.gz
do
    base=$(basename "$file" _INDEL_raw.vcf.gz)

    gatk VariantFiltration \
        -R $REF \
        -V $file \
        -O INDELs_filtered/${base}_INDEL_filtered.vcf.gz \
        --filter-name "QD_filter" --filter-expression "QD < 2.0" \
        --filter-name "FS_filter" --filter-expression "FS > 200.0" \
        --filter-name "SOR_filter" --filter-expression "SOR > 10.0"
done
