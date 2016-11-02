# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis

# >>> Initialisation
# Initial loading and studies of the dataset
# TO DO : other data visualisation methods

# load data
source("./data_loading.R")

# missmap
source("./missmap.R")

# studying correlation
source("./correlation_studying.R")

# Sampling 
source("./sampling.R")

# >>> Testing first assumptions on models

# === Multiclass classification problems

# ... Naturally permits multiclass classification
# KNN
source("./knn.R")
# TODO : Studying the k parameter

# ... One vs All strategy
# multinomial model (based on maximum likelihood)
source("./multinomialreg.R")



# ... One vs One strategy

# ... Hierarchical Classification

# ... Extensions from binary
# Multi-Layer perceptron
# ELM ?
# KNN
# Naive Bayes
# Decision trees 
# SVM






# Logistic Regression
# source("logreg.R")
# TO DO : Extend to the multiclass case (SY09)

# QDA
# Idem (SY09)

# LDA
# Idem (SY09)


# Decision Tree
source("./tree.R")


# SVM

# >>> Data refactoring, subseting etc...



# >>> Second assumptions on models



# >>> Models selections and conclusions





# >>> QUESTIONS
# Unsupervised to try too ?
# Variabilité inter-locuteur ? Variabilité inter-locuteur du même ordre que variabilité inter-phonème ?
# Variabilité entre deux fois la même syllabe chez le même locuteur






