#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem=100G
#SBATCH --time=40:00:00
#SBATCH --output=scRNA_SNP_soaporcell_pipeline.sh.%A_%a.stdout
#SBATCH -p all,abild
#SBATCH --workdir=./

#sbatch --array 1 run_speedseq_qsub.sh


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

#singularity exec souporcell.sif souporcell_pipeline.py -i A.merged.bam -b GSM2560245_barcodes.tsv -f ~/Projects/Database/Reference/refdata-cellranger-hg19-3.0.0/fasta/genome.fa -t 16 -o demux_data_test -k 4

#common
soaporcell=~/software/Variants_calling/souporcell/souporcell.sif
#somatic_snp=FEL024_rand2000.gatk.svm.keep_vars_found_in_n_samples_5.matrix.txt.pos.txt.vcf.gz
reference=~/Projects/Database/Reference/refdata-cellranger-hg19-3.0.0/fasta/genome.fa

#sample
sample=`cat sample.list | head -n $N | tail -n 1`
input_dir=/net/isi-dcnl/ifs/user_data/abild/Megatron_data/COH047/feline_p2324_premrna.10x.counts
bam=$input_dir/$sample/outs/possorted_genome_bam.bam
barcode=$input_dir/$sample/outs/filtered_feature_bc_matrix/barcodes.tsv
output_dir=souporcell_out_$sample
mkdir $output_dir

singularity exec $soaporcell souporcell_pipeline.py -i $bam -b $barcode -f $reference -t $CPU -o $output_dir -k 4

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"

