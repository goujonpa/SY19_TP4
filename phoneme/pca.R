# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Principal Components Analysis

# SX should already be scaled but just in case
pca = prcomp(SX, scale=T)

# plotting the two principal component
pdf("./plots/pca.pdf")
biplot(pca, scale=0)
dev.off()

# plotting the proportion of variance explained by each component
prv = pca$sdev^2
pve = prv/sum(prv)

pdf("./plots/pve.pdf")
plot(pve, xlab="Principal Component", ylab="Proportion of Variance Explained", ylim=c(0,1), type="b")
dev.off()
pdf("./plots/cumpve.pdf")
plot(cumsum(pve), xlab="Principal Component", ylab="Cumulative Proportion of Variance Explained", ylim=c(0,1), type="b")
dev.off()


