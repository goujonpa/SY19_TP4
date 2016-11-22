# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# multinomial QDA

# >>> DATA LOADING
# load data & split it
source("./data_loading.R")
source("./ten_fold.R")
source("./sampling.R")


library(MASS)

error_rates = matrix(nrow=10, ncol=1)
# using 10-folds cross-validation
for (i in 1:10) {
    # make the folds
    train_df = as.data.frame(cbind(SX[-folds[[i]],], z[-folds[[i]],1]))
    test_df = as.data.frame(cbind(SX[folds[[i]],], z[folds[[i]],1]))
    colnames(train_df)[257] = "y"
    colnames(test_df)[257] = "y"
    
    # training
    model = qda(y~. , data=train_df)
    
    # predict
    qda.pred = predict(model, newdata = test_df)
    
    # error rate
    error_rates[i,] = length(which(
        as.vector(qda.pred$class) != as.vector(test_df$y)
    ))/length(as.vector(test_df$y))*100
}

sink("./txt/multqda_mean_err.txt")
mean(as.vector(error_rates))
sink()

write.csv(error_rates, file="./csv/multqda_err.csv")
