# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Correlation studying file

# >>> DATA LOADING
# load data & split it
source("./data_loading.R")
source("./ten_fold.R")
source("./sampling.R")

# Studying correlation between variables and plotting it into a heatmap
corr = cor(SX)
pdf("./plots/phonm_comp_cor.pdf")
image(x=1:ncol(corr), y=1:nrow(corr), z=t(as.matrix(1-corr)), axes=F, xlab="", ylab="", main="Phoneme dataset components correlation")
axis(2, at=1:nrow(corr), labels=colnames(corr), col="white", las=1, cex.axis=0.8)
axis(1, at=1:ncol(corr), labels=colnames(corr), col="white", las=2, cex.axis=0.8)
dev.off()

