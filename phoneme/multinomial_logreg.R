# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Multinomial logistic regression

library(nnet)

# >>> First test
df = as.data.frame(cbind(SX, z[,1]))
colnames(df)[257] = "y"

sink("./txt/multreg_fit.txt")
model = multinom(y~. , data = df, maxit=2000, MaxNWts=2000)
print("SUMMARY:")
summary(model)
sink()

sink("./txt/multreg_predict.txt")
print("ERROR RATE:")
(length(which(as.vector(predict(model, newdata = df)) != as.vector(df$y))) / length(as.vector(df$y)))*100
sink()

# Then using the 10-folds cross validation to compute the mean error rate
error_rates = matrix(nrow=10, ncol=1)
for (i in 1:10) {
    # make the folds
    train_df = as.data.frame(cbind(SX[-folds[[i]],], z[-folds[[i]],1]))
    test_df = as.data.frame(cbind(SX[folds[[i]],], z[folds[[i]],1]))
    colnames(train_df)[257] = "y"
    colnames(test_df)[257] = "y"
    
    # train
    model = multinom(y~. , data = train_df, maxit=2000, MaxNWts=2000)
    
    # compute test error rate
    error_rates[i,] = length(
        which(as.vector(predict(model, newdata=test_df)) != as.vector(test_df$y))
        )/length(as.vector(test_df$y))*100
}

sink("./txt/mean_multreg_errorrate.txt")
mean(as.vector(error_rates))
sink()

write.csv(error_rates, file="./csv/multreg_errorrates.csv")

