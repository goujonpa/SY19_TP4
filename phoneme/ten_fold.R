# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# Splitting data to ten folds

library(caret)

# Split data into ten folds
folds = createFolds(z$g, k=10, list=T, returnTrain=F)
