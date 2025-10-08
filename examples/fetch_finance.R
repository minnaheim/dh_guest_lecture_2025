# fetch the "human way"
library(readr)
library(utils)

# Read all lines as a single column
raw_data <- readLines("img/lisn-sw.txt")

# The first 7 lines are headers
headers <- raw_data[1:7]
print(headers)

data_lines <- raw_data[-(1:7)]

# set the column and row lengths
n_cols <- length(headers)
n_rows <- length(data_lines) / n_cols

# Create matrix and convert to data frame
data_matrix <- matrix(data_lines, nrow = n_rows, ncol = n_cols, byrow = TRUE)
data <- as.data.frame(data_matrix)
colnames(data) <- headers

# utils::View(data)

# fetch the "computer way"


###### 1. as close to the source as possible

# put into browser:
# https://query1.finance.yahoo.com/v8/finance/chart/LISN.SW?period1=1756052365&period2=1758730765&interval=1d&events=history
# period1 = 1756052365 (24.08.2025)
# period2 = 1758730765 (24.09.2025)

