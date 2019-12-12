library(infercnv)

setwd("/home/anath/anath.grp/COH056/output_dir_NP4396_v2")

##
#infercnv_obj = readRDS("14_HMM_pred.Bayes_NetHMMi6.qnorm.hmm_mode-subclusters.Pnorm_0.5.infercnv_obj")
infercnv_obj = readRDS("14_HMM_pred.repr_intensitiesHMMi6.qnorm.hmm_mode-subclusters.Pnorm_0.5.infercnv_obj")

plot_cnv(infercnv_obj, output_filename='InferCNV_NP4396_HMM', color_safe_pal = FALSE, 
          write_expr_matrix = TRUE, title = "InferCNV HMM", output_format=NA)
