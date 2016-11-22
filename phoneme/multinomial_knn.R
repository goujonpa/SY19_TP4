# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# K Nearest Neighbours script

# >>> DATA LOADING
# load data & split it
source("./data_loading.R")
source("./ten_fold.R")
source("./sampling.R")


library(class)

# set the seed
set.seed(1)

error_rates = matrix(nrow=50, ncol=10)
# multinomial knn error rate in function of the k parameter
for (k in 1:50) {
    # using 10-folds cross-validation
    for (i in 1:10) {
        # make the folds
        train_df = as.data.frame(cbind(SX[-folds[[i]],], z[-folds[[i]],1]))
        test_df = as.data.frame(cbind(SX[folds[[i]],], z[folds[[i]],1]))
        colnames(train_df)[257] = "y"
        colnames(test_df)[257] = "y"
        
        # knn prediction
        knn.pred = knn(train_df[,-257], test_df[,-257], train_df$y, k=k)
        
        error_rates[k, i] = (length(which(
            as.vector(knn.pred) != as.vector(test_df$y))
            )/length(test_df$y)*100)
    }
}
# last prediction confusion table
sink("./txt/last_multknn_confusion.txt")
table(knn.pred, test_df$y)
sink()

mean_error_rates = apply(error_rates, 1, mean)

pdf("./plots/multknn_error.pdf")
plot(1:50, mean_error_rates, main="Mean Error Rate for knn in function of K parameter", xlab="K Value", ylab="Mean Error Rate")
dev.off()

write.csv(mean_error_rates, file="./csv/knn_mean_err.csv")
