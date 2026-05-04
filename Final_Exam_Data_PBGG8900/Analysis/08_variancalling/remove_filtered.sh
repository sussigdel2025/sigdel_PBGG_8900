#!/bin/bash
#SBATCH --job-name=pass_only
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --output=pass.out
#SBATCH --error=pass.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

BASE_DIR=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

mkdir -p SNPs_PASS INDELs_PASS

# SNP PASS only
for file in ${BASE_DIR}/SNPs_filtered/*_SNP_filtered.vcf.gz
do
    base=$(basename "$file" _SNP_filtered.vcf.gz)

    gatk SelectVariants \
        --exclude-filtered \
        -V $file \
        -O SNPs_PASS/${base}_SNP_PASS.vcf.gz

done

# INDEL PASS only

for file in ${BASE_DIR}/INDELs_filtered/*_INDEL_filtered.vcf.gz
do
    base=$(basename "$file" _INDEL_filtered.vcf.gz)

    gatk SelectVariants \
        --exclude-filtered \
        -V $file \
        -O INDELs_PASS/${base}_INDEL_PASS.vcf.gz

done
