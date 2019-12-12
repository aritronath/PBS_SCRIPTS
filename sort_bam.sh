#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem=128G
#SBATCH --time=12:00:00
#SBATCH --output=merge_bam.log
#SBATCH -p fast,all,abild

module load samtools

cd /net/isi-dcnl/ifs/user_data/abild/Megatron_data/COH022/IGC-PC-12627.iCell8/104847_SubRead/alignment.bam

samtools sort -o COH022_sorted.bam  COH022_merged.bam

echo "Done sorting"

samtools index COH022_sorted.bam

echo "Done indexing"


