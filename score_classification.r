#Score classification
library(xlsx)
file <- "nyt_headlines_score_2005.xlsx"
data <- read.xlsx(file = file, sheetIndex = 1, stringsAsFactors=FALSE)

#generate a table to classify scores
intervals <- seq(-1, 1, 1/3)
result <- as.data.frame(matrix(0, ncol = length(intervals) - 1, nrow = nrow(data)))
result <- cbind(result, data[,1])
names(result) <- c(seq(1, ncol(result) - 1), "pub_date")

####test
result1 <- findInterval(data[1,-1], intervals)
t1 <- table(result1)
df1 <- as.data.frame(table(result1))
result2 <- findInterval(data[2,-1], intervals) 
t2 <- table(result2)
df2 <- as.data.frame(t2)
###

for(i in c(1:nrow(df1))){
        result[1,as.numeric(df1[i,1])] <- df1[i,2]
}

#classificaiton function
score_classify <- function(df, result, intervals){
        temp <- findInterval(df, intervals)
        temp_table <- table(temp)
        temp_df <- as.data.frame(temp_table)
        for(i in c(1:nrow(temp_df))){
                result[, as.numeric(temp_df[i, 1])] <- temp_df[i, 2]
        }
        # class_df[class_df$`lower bound`==-1,]$levels
}

data_classify <- lapply(data[,-1], score_classify(data, result, intervals))
