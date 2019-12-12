library(infercnv)

setwd("/home/anath/anath.grp/COH056")

load("UR1113.counts.RData")
counts <- as.matrix(UR1113.counts)

infercnv_obj = CreateInfercnvObject(raw_counts_matrix=counts, annotations_file="UR1113.cnv.annot.txt", delim="\t", 
                                    gene_order_file="hg19.RefSeq.NM_pos_unique_sort.txt",
				    ref_group_names=NULL)

infercnv_obj = infercnv::run(infercnv_obj, num_threads=16,
                             cutoff=0,  # use 1 for smart-seq, 0.1 for 10x-genomics
                             out_dir="output_dir_UR1113_null",
			     window_length=501,  
                             analysis_mode='subclusters', no_plot=TRUE,
                             denoise=TRUE, sd_amplifier=3, 
			     HMM=TRUE, HMM_type="i6", plot_steps=FALSE)

