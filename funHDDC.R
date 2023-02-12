# Perform FunHDDC on the data

# Load packages
library(fda)
library(funHDDC)
library(mclust)
library(tidyverse)

# Load data
argvals <- seq(0, 1, length.out = 30)
values <- t(as.matrix(read.csv('~/ProjectDocs/Project_code/simuations/Data/DataStore.csv', header = FALSE))) # nolint
labels <- unname(as_vector(read.csv('~/ProjectDocs/Project_code/simuations/Data/LabelStore.csv', header = FALSE))) # nolint

# Print the length of argvals and values
print(length(argvals))
print(length(values))

# FunHDDC
basis <- create.bspline.basis(rangeval = c(min(argvals), max(argvals)), nbasis = 25, norder = 3) # nolint
data_fd <- smooth.basis(argvals = argvals, y = values, fdParobj = basis)$fd
print(data_fd)
res_clust <- funHDDC(data_fd, K = 2, threshold = 0.3, model = 'ABQkDk',
itermax = 2000, eps = 1e-3, init = 'kmeans') # nolint
pred_labels <- res_clust$class

print(pred_labels)

# Write the pred_labels to a file
write.csv(pred_labels, file = '~/ProjectDocs/Project_code/simuations/Data/PredictedLabelsStore.csv') # nolint



