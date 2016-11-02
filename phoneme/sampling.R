# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Sampling file
library(caTools)

# >>> Splitting into train / text samples
splitting = sample.split(z[,1], SplitRatio=2/3)
# length(splitting[which(splitting)]) / length(splitting) 
# (if u want to check this is 2/3)
Xtrain = X[splitting, ]
Xtst = X[!splitting, ]
SXtrain = SX[splitting,]
SXtst = SX[!splitting,]
ztrain = z[splitting,]
ztst = z[!splitting,]