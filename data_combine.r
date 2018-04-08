#combine headlines into one file
library(xlsx)

files1 <- list.files(path = "./data/scores", recursive = T)
files2 <- list.files(path = "./data/scores", pattern = "score", recursive = T)
files3 <- list.files(path = "./data/scores", pattern = "DJ", recursive = T)
#get the list of only headline file
files <- setdiff(setdiff(files1,files2), files3)

setwd("./data/scores")

data <- data.frame()

file1 <- "nyt_headlines_1989.xls"
file1_data <- read.xlsx(file = file1, header = T, sheetIndex = 1, stringsAsFactors=FALSE)
head(file1_data)
names(file1_data)
file1_data[,1] <- as.Date(file1_data[,1])
str(file1_data)

data <- rbind(data, file1_data)
str(data)

files <- setdiff(files, file1)

for (file in files){
        temp_data <- read.xlsx(file, header = F, sheetIndex = 1, stringsAsFactors = F )
        data <- rbind(data, temp_data)
        rm(temp_data)
}


file2 <- "nyt_headlines_2000.xls"
file2_data <- read.xlsx(file = file2, header = T, sheetIndex = 1, stringsAsFactors=FALSE)
head(file2_data)
names(file2_data)
file2_data[,1] <- as.Date(file2_data[,1])


str(file2_data)
file2_data[,1]
data <- rbind(data, file1_data)
str(data)



file3 <- "headlines_combined.xlsx"
file3_data <- read.xlsx(file = file3, header = T, sheetIndex = 1, stringsAsFactors = F)
file3_data[,1] <- as.Date(file3_data[,1])



file4 <- "nyt_headlines_2008.xls"
file4_data <- read.xlsx(file = file4, header = T, sheetIndex = 1, stringsAsFactors = F)
