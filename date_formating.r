#Date formating
#Use this file if your date in data is not formatted
library(xlsx)
file <- "nyt_headlines_2005_2008_2016_2017.xlsx"
data <- read.xlsx(file = file, sheetIndex = 1, stringsAsFactors=FALSE)
need_format <- is.na(as.Date(data[,1]))
date <- data[,1]
data[,1] <- as.Date(data[,1])

data[need_format,1][1] <- as.Date(as.POSIXct((39630-25569)*86400, tz="EST", origin="1970-01-01"))

for (i in 1:length(need_format)){
        if(need_format[i]){
                data[i,1] <- as.Date(as.POSIXct((as.numeric(date[i])-25569)*86400, 
                                                tz="EST", origin="1970-01-01"))
        }
}

write.xlsx(data, "nyt_headlines_formated.xlsx", row.names = F)