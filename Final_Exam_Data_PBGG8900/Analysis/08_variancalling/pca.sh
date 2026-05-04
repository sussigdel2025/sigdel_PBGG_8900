#!/bin/bash
#SBATCH --job-name=pca
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=20G
#SBATCH --time=02:00:00
#SBATCH --output=pca.out
#SBATCH --error=pca.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load PLINK/2.0.0-a.6.20-gfbf-2024a

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling


# Generate allele frequencies

plink2 \
    --bfile sweetgum_final \
    --freq \
    --out sweetgum_freq

# Run PCA using frequency file


plink2 \
    --bfile sweetgum_final \
    --read-freq sweetgum_freq.afreq \
    --pca approx 10 \
    --out sweetgum_pca
