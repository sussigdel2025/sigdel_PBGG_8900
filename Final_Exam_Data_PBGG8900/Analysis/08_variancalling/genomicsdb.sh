#!/bin/bash
#SBATCH --job-name=genomicsdb
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=60G
#SBATCH --time=12:00:00
#SBATCH --output=genomicsdb.out
#SBATCH --error=genomicsdb.err

module purge
module load GATK/4.6.0.0-GCCcore-13.2.0-Java-17

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Genome/Lst.genome.fasta

gatk GenomicsDBImport \
    --genomicsdb-workspace-path my_database \
    --sample-name-map sample_map.txt \
    --intervals intervals.list
