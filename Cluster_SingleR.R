library(SingleR)

setwd("/home/anath/anath.grp/COH056/")

load("counts.RData")
load("Annot.df.RData")

coh056.singler = CreateSinglerSeuratObject(counts, annot=t(Annot.df), project.name = "Suerat coh056",
                                           variable.genes='de', regress.out='nUMI', fine.tune=F,
                                           technology='10x', species='Human', numCores=16,
                                           citation='', reduce.file.size = F,
                                           normalize.gene.length = F,
                                           do.main.types = T)

save(coh056.singler, file="coh056.singler.RData")