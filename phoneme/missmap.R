# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Missmap

library(Amelia)
pdf("./plots/initial_missmap.R")
missmap(raw_data, main = "Missing values vs observed")
dev.off()


