# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Logistic regression script

train_d = as.data.frame(cbind(Xtrain, ztrain[,1]))
sc_train_d = as.data.frame(cbind(SXtrain, ztrain[,1]))
colnames(train_d)[257] = "g"
colnames(sc_train_d)[257] = "g"

# logreg fitting
glm.fit = glm(g ~. , data=train_d)
