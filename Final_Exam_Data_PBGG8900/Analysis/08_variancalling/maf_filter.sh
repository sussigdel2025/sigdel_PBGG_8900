#!/bin/bash
#SBATCH --job-name=maf_filter
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=10G
#SBATCH --time=02:00:00
#SBATCH --output=maf.out
#SBATCH --error=maf.err

module purge
module load BCFtools

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/08_variancalling

bcftools view \
    -i 'F_MISSING<=0.5 && MAF>=0.05' \
    All_sample_final_SNP_PASS.vcf.gz \
    -Oz -o All_sample_50_MAF_filtered.vcf.gz

bcftools index All_sample_50_MAF_filtered.vcf.gz

echo "MAF + missing data filtering complete!"
