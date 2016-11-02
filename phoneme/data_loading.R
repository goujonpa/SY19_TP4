# Jo COLINA & Paul GOUJON
# UTC - SY19 - TP4

# Phoneme data analysis
# dataloading file


# clear workspace
rm(list=ls())

# get data and cleaned data
raw_data = read.csv("./data/phoneme.data", header=T)
X = raw_data[,2:257] 
SX = scale(X)
z = raw_data[,258:259]

