# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# K Nearest Neighbours script

library(class)

# set the seed
set.seed(1)

# predict
knn.pred = knn(Xtrain, Xtst, ztrain[,1], k = 1)
sink("./txt/knn_pred_table.txt")
print("KNN Prediction Table")
print("Using knn.pred = knn(Xtrain, Xtst, ztrain[,1], k = 1)")
print("then table(knn.pred, ztst[,1])")
table(knn.pred, ztst[,1])
sink()
