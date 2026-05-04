#!/bin/bash
#SBATCH --job-name=genotype
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=08:00:00
#SBATCH --output=genotype.out
#SBATCH --error=genotype.err

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta

gatk GenotypeGVCFs \
    -R $REF \
    -V gendb://my_database \
    -O Final_All_samples.vcf.gz
