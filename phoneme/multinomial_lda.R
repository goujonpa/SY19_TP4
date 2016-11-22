# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# multinomial LDA

library(MASS)

# >>> DATA LOADING
# load data & split it
source("./data_loading.R")
source("./ten_fold.R")
source("./sampling.R")


error_rates = matrix(nrow=10, ncol=1)
# using 10-folds cross-validation
for (i in 1:10) {
    # make the folds
    train_df = as.data.frame(cbind(SX[-folds[[i]],], z[-folds[[i]],1]))
    test_df = as.data.frame(cbind(SX[folds[[i]],], z[folds[[i]],1]))
    colnames(train_df)[257] = "y"
    colnames(test_df)[257] = "y"
    
    # training
    model = lda(y~. , data=train_df)
    
    # predict
    lda.pred = predict(model, newdata = test_df)
    
    # error rate
    error_rates[i,] = length(which(
        as.vector(lda.pred$class) != as.vector(test_df$y)
        ))/length(as.vector(test_df$y))*100
}

sink("./txt/multlda_mean_err.txt")
mean(as.vector(error_rates))
sink()

write.csv(error_rates, file="./csv/multlda_err.csv")
