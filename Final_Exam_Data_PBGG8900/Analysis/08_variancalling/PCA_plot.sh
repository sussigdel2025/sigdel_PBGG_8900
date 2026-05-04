#!/bin/bash
#SBATCH --job-name=pca_pipeline
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --output=pca_pipeline.out
#SBATCH --error=pca_pipeline.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load PLINK/2.0.0-a.6.20-gfbf-2024a

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

########################################################
# Step 1: Convert VCF to PLINK format
# - assign unique variant IDs
# - remove samples with >20% missing data
########################################################

plink2 \
    --vcf All_sample_50_MAF_filtered.vcf.gz \
    --set-all-var-ids @:# \
    --mind 0.2 \
    --make-bed \
    --out sweetgum_final_fixed

########################################################
# Step 2: Calculate allele frequencies
########################################################

plink2 \
    --bfile sweetgum_final_fixed \
    --freq \
    --out sweetgum_freq

########################################################
# Step 3: Run PCA
########################################################

plink2 \
    --bfile sweetgum_final_fixed \
    --read-freq sweetgum_freq.afreq \
    --pca 3 \
    --out sweetgum_pca
