# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Multinomial regression

library(glmnet)

# NOTE : glmnet package doing the same ?

# reassemble data
train_d = as.data.frame(cbind(Xtrain, ztrain[,1]))
sc_train_d = as.data.frame(cbind(SXtrain, ztrain[,1]))
colnames(train_d)[257] = "g"
colnames(sc_train_d)[257] = "g"

sc_reg = glmnet(SXtrain, ztrain[,1], family="multinomial")
test = as.data.frame(predict(sc_reg, SXtst, type="class"))
