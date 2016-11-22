# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Missmap
# >>> DATA LOADING
# load data & split it
source("./data_loading.R")
source("./ten_fold.R")
source("./sampling.R")


library(Amelia)
pdf("./plots/initial_missmap.R")
missmap(raw_data, main = "Missing values vs observed")
dev.off()


