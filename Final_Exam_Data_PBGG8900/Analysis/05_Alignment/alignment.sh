#!/bin/bash
#SBATCH --job-name=align
#SBATCH --partition=batch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --mem=32G
#SBATCH --time=24:00:00
#SBATCH --output=align.out
#SBATCH --error=align.err
#SBATCH --mail-user=ss70339@uga.edu
#SBATCH --mail-type=ALL

module purge
module load BWA/0.7.18-GCCcore-13.3.0
module load SAMtools/1.18-GCC-12.3.0

cd /scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/05_Alignment

mkdir -p bam

REF=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/04_index_genome/Lst.genome.fasta
READS=/scratch/ss70339/Final_Exam_Data_PBGG8900/Analysis/02_Trimming/trimmed_reads

for file in ${READS}/*.fq.gz
do
    base=$(basename "$file" _trimmed.fq.gz)

    bwa mem -t 6 "$REF" "$file" | samtools view -bSh -o bam/${base}.bam

    samtools sort -@ 4 -o bam/${base}_sorted.bam bam/${base}.bam
    samtools index bam/${base}_sorted.bam

done
