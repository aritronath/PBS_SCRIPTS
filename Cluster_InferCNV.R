library(infercnv)

setwd("/home/anath/anath.grp/COH056")

load("counts.RData")
counts <- as.matrix(counts)

infercnv_obj = CreateInfercnvObject(raw_counts_matrix=counts, annotations_file="cnv.annot.txt", delim="\t", 
                                    gene_order_file="hg19.RefSeq.NM_pos_unique_sort.txt", ref_group_names=c("Normal"))

infercnv_obj = infercnv::run(infercnv_obj, num_threads=16, resume_mode=TRUE,
                                   cutoff=0.1,  # use 1 for smart-seq, 0.1 for 10x-genomics
                                   out_dir="output_dir_COH056", plot_probabalities=FALSE,
                                   cluster_by_groups=TRUE, no_plot=TRUE, no_prelim_plot=TRUE,
                                   denoise=TRUE, HMM=TRUE, plot_steps=FALSE)

save(infercnv_obj, file="InferCNV_obj_COH056.RData")



