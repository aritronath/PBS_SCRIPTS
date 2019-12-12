library(infercnv)

setwd("/home/anath/anath.grp/COH056")

load("NP4396.counts.RData")

counts <- as.matrix(NP4396.counts)

infercnv_obj = CreateInfercnvObject(raw_counts_matrix=counts, annotations_file="NP4396.cnv.annot.txt", delim="\t", 
                                    gene_order_file="hg19.RefSeq.NM_pos_unique_sort.txt",
			  	    ref_group_names=NULL)

infercnv_obj = infercnv::run(infercnv_obj, num_threads=16,
                             cutoff=0,  # use 1 for smart-seq, 0.1 for 10x-genomics
                             out_dir="output_dir_NP4396_null",
			     window_length=501, scale_data=TRUE,  
                             analysis_mode='subclusters', tumor_subcluster_partition_method='qnorm', 
			     no_plot=TRUE, cluster_references=FALSE,
                             denoise=TRUE, sd_amplifier=3, 
			     HMM=TRUE, HMM_type="i6", plot_steps=FALSE)




