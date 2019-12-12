#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem=100G
#SBATCH --time=40:00:00
#SBATCH --output=vartrix.%A_%a.stdout
#SBATCH -p all,abild
#SBATCH --workdir=./

start=`date +%s`

CPU=$SLURM_NTASKS
if [ ! $CPU ]; then
   CPU=2
fi

N=$SLURM_ARRAY_TASK_ID
if [ ! $N ]; then
    N=1
fi

echo "CPU: $CPU"
echo "N: $N"

export R_LIBS=/home/jichen/software/BETSY/install/envs/scRNA/lib/R/library
module load singularity/3.1.0
unset PYTHONPATH

#Common files 
soaporcell=/home/jichen//software/Variants_calling/souporcell/souporcell.sif
reference=/net/isi-dcnl/ifs/user_data/abild/Genomes/refdata-cellranger-hg19-3.0.0/fasta/genome.fa

#Somatic mutation VCF
somatic_snp=/net/isi-dcnl/ifs/user_data/abild/aritro/Ovarian/VAF_Free/15335/P1335.isVariant.change.sort.vcf

#Input BAM and barcode file location 
input_dir=/net/isi-dcnl/ifs/user_data/abild/Megatron_data/COH022/IGC-PC-12627.iCell8
bam=$input_dir/104847_SubRead/alignment.bam/COH022_sorted.bam
barcode=$input_dir/sample_seq_info/Barcodes.txt

output_dir=vartrix_out_COH022
mkdir $output_dir

#In the default consensus mode, the matrix will have a 1 if all reads at the position support the ref allele, a 2 if one or more reads support the alt allele, and a 3 if one or more reads support both the alt and the ref allele.
#In the coverage mode, two matrices are produced. The matrix sent to --out-matrix is the number of alt reads seen, and the matrix sent to --ref-matrix is the number of ref reads seen.

#singularity exec $soaporcell vartrix --umi --mapq 30 -b $bam -c $barcode --scoring-method coverage --threads 16 --ref-matrix ./$output_dir/ref.mtx --out-matrix ./$output_dir/alt.mtx -v $somatic_snp --fasta $reference --out-variants ./$output_dir/snp.variants
singularity exec $soaporcell vartrix --umi --mapq 30 -b $bam -c $barcode --scoring-method consensus --threads 16 --out-matrix ./$output_dir/out.mtx -v $somatic_snp --fasta $reference

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"

