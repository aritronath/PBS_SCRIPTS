library(GSEABase)
library(GSVA)
library(parallel)
library(data.table)

setwd("/home/anath/anath.grp/COH056/")

load("counts.RData")

c2set <- getGmt("c2.all.v7.0.symbols.gmt")

gsvaData <- gsva(as.matrix(counts), c2set, min.sz=10, max.sz=500, verbose=TRUE, kcdf="Poisson", 
 method="ssgsea", parallel.sz=0)

save(gsvaData, "gsvaCOH056.RData")

fwrite(gsvaData, "ssGSEA_scores_COH056.txt", col.names=TRUE, sep="\t")
