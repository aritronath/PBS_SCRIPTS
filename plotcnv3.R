library(infercnv)

setwd("/home/anath/anath.grp/COH056/output_dir_NP4396_v2")

##
infercnv_obj = readRDS("run.final.infercnv_obj")

plot_cnv(infercnv_obj, output_filename='InferCNV_NP4396_Final', color_safe_pal = FALSE,
          write_expr_matrix = TRUE, title = "InferCNV Final", output_format=NA)
