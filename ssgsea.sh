#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --mem=32G
#SBATCH --time=12:00:00
#SBATCH --output=log
#SBATCH --workdir=/net/isi-dcnl/ifs/user_data/abild/aritro
#SBATCH -p fast,all,abild
 
export R_LIBS=/home/jichen/software/BETSY/install/envs/ssGSEA/lib/R/library/
export PATH=$PATH:/home/jichen/software/Python_lib64/lib64/python2.7/site-packages/genomicode/bin
export PYTHONPATH=$PYTHONPATH:/home/jichen/software/Python_lib64/lib64/python2.7/site-packages:/home/jichen/software/Python_lib/lib/python2.7/site-packages/:/home/jichen/software/BETSY/install/envs/ssGSEA/lib/python2.7/site-packages

Database=/home/jichen/Projects/Database/MSigDB
count_path=/net/isi-dcnl/ifs/user_data/abild/aritro/COH051

betsy_run.py --environment coh_slurm --receipt betsy_scRNA_ssGSEA_receipt.txt --num_cores 16 \
    --network_json betsy_scRNA_ssGSEA_network_json.txt --network_png betsy_scRNA_ssGSEA_network.pdf \
    --input SignalFile --input_file $count_path/X965X9.noaggr.counts.txt \
    --dattr SignalFile.preprocess=counts\
    --dattr SignalFile.has_human_gene_info=no\
    --output ssGSEAResults --output_file COH051\.ssGSEA \
    --mattr geneset_file=$Database/c2.all.v6.2.symbols.gmt \
    --mattr geneset_file2=$Database/h.all.v6.2.symbols.gmt \
    --mattr gsva_min_geneset_size=10 \
    --run
