#!/bin/bash
#SBATCH --job-name=plink_convert
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --output=plink.out
#SBATCH --error=plink.err

module purge
module load PLINK/2.0.0-a.6.20-gfbf-2024a

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

plink2 \
    --vcf All_sample_50_MAF_filtered.vcf.gz \
    --mind 0.2 \
    --make-bed \
    --out sweetgum_final
