library(infercnv)

setwd("/home/anath/anath.grp/COH056")

load("NP4396.counts.RData")

counts <- as.matrix(NP4396.counts)

infercnv_obj = CreateInfercnvObject(raw_counts_matrix=counts, annotations_file="NP4396.cnv.annot.txt", delim="\t", 
                                    gene_order_file="hg19.RefSeq.NM_pos_unique_sort.txt", ref_group_names=c("Normal"))

infercnv_obj = infercnv::run(infercnv_obj, num_threads=16,
                             cutoff=0,  # use 1 for smart-seq, 0.1 for 10x-genomics
                             window_length=101,
			     out_dir="output_dir_NP4396_v2",
                             cluster_references = FALSE, no_plot=TRUE,plot_steps=FALSE,
			     analysis_mode="subclusters", tumor_subcluster_partition_method="qnorm",
			     HMM=TRUE, denoise=TRUE)






