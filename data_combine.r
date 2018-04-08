#combine headlines into one file
files1 <- list.files(path = "./data/scores")
files2 <- list.files(path = "./data/scores", pattern = "score")
files3 <- list.files(path = "./data/scores", pattern = "DJ")
#get the list of only headline file
files <- setdiff(setdiff(files1,files2), files3)

setwd("./data/scores")

data <- NULL

library(xlsx)

for (file in files){
        temp_data <- read.xlsx(file, header=F)
        data <- rbind(data, temp_data)
        rm(temp_data)
}
