# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Stepwise selection

# >>> Changing colnames to easier
cols = vector(length=256)

for (i in 1:256) {
    cols[i] = paste("X", as.character(i), sep="")
}
SX2 = SX
colnames(SX2) = cols

source("./sampling.R")

colnames(SXtrain) = cols
colnames(SXtst) = cols
lda_df = as.data.frame(cbind(SXtrain, ztrain[,1]))
tst_df = as.data.frame(cbind(SXtst, ztst[,1]))
colnames(lda_df)[257]="y"
colnames(tst_df)[257]="y"

# >>> Forward Stepwise Selection
predictors = vector(length = 256)
current_formula = "y~"
stwsel_mat = matrix(nrow=256, ncol=2)
colnames(stwsel_mat) = c("formula", "err")
for (i in 1:40) {
    print("IT")
    print(i)
    # left predictors
    left = setdiff(cols, predictors)
    print(length(left))
    
    # min err reset (percent)
    min_err = 200
    min_pred = left[1]
    
    # for j in left predictors
    for (j in 1:length(left)) {
        # try the different formulas
        f = paste(current_formula, left[j], sep="")
        #print(f)
        m = lda(as.formula(f), data=lda_df)
        
        # calculate the error rate
        lda.pred = predict(m, newdata=as.data.frame(tst_df))
        err = length(which(
            as.vector(lda.pred$class) != as.vector(tst_df$y)
        ))/length(as.vector(tst_df$y))*100
        
        # if min error rate keep predictor in memory
        if (err < min_err) {
            min_err = err
            min_pred = left[j]
        }
    }
    
    # add the best predictor to the predictors vector
    predictors[i] = as.character(min_pred)
    
    # update the current formula string
    current_formula = paste(current_formula, as.character(min_pred), sep="")
    print(current_formula)
    
    # cross validate to get the error rate for that predictor
    error_rates = matrix(nrow=10, ncol=1)
    # using 10-folds cross-validation
    for (k in 1:10) {
        # make the folds
        train_df = as.data.frame(cbind(SX2[-folds[[k]],], z[-folds[[k]],1]))
        test_df = as.data.frame(cbind(SX2[folds[[k]],], z[folds[[k]],1]))
        colnames(train_df)[257] = "y"
        colnames(test_df)[257] = "y"
        
        # training
        model = lda(as.formula(current_formula) , data=train_df)
        
        # predict
        lda.pred.cv = predict(model, newdata = test_df)
        
        # error rate
        error_rates[k,] = length(which(
            as.vector(lda.pred.cv$class) != as.vector(test_df$y)
        ))/length(as.vector(test_df$y))*100
    }
    mean_err = mean(as.vector(error_rates))
    
    # save the error rate
    stwsel_mat[i, 1] = as.character(current_formula)
    print(stwsel_mat[i,1])
    stwsel_mat[i, 2] = mean_err
    print(stwsel_mat[i,2])
    
    # add the "+" for the next new pred test
    current_formula = paste(current_formula, as.character("+"), sep="")
}
# plot
pdf("./plots/stwsel.pdf")
plot(1:40, stwsel_mat[1:40, 2], main="Mean Error Rate for LDA in function of number of selected predictors", xlab="Selected Predictors Number", ylab="Mean Error Rate")
dev.off()

write.csv(stwsel_mat, file="./csv/stwsel.csv")
