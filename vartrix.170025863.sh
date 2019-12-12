#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --mem=100G
#SBATCH --time=12:00:00
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
reference=/home/anath/anath.grp/refdata-cellranger-hg19-3.0.0/fasta/genome.fa

#Somatic mutation VCF
somatic_snp=/home/anath/abild.grp/lpflieger/Ovarian_iCell8/WGS/OB9YER/Freebayes/OUT.recode.vcf

#Input BAM and barcode file location 
input_dir=/net/isi-dcnl/ifs/user_data/abild/Megatron_data/COH044/OB9YER_170025863/outs
bam=$input_dir/possorted_genome_bam.bam
barcode=$input_dir/filtered_feature_bc_matrix/barcodes.tsv

output_dir=vartrix_out_170025863
mkdir $output_dir

#In the default consensus mode, the matrix will have a 1 if all reads at the position support the ref allele, a 2 if one or more reads support the alt allele, and a 3 if one or more reads support both the alt and the ref allele.
#In the coverage mode, two matrices are produced. The matrix sent to --out-matrix is the number of alt reads seen, and the matrix sent to --ref-matrix is the number of ref reads seen.

#singularity exec $soaporcell vartrix --umi --mapq 30 -b $bam -c $barcode --scoring-method coverage --threads 32 --ref-matrix ./$output_dir/ref.mtx --out-matrix ./$output_dir/alt.mtx -v $somatic_snp --fasta $reference --out-variants ./$output_dir/snp.variants
singularity exec $soaporcell vartrix --umi --mapq 30 -b $bam -c $barcode --scoring-method consensus --threads 32 --out-matrix ./$output_dir/out.mtx -v $somatic_snp --fasta $reference --out-variants ./$output_dir/snp.variants

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"

