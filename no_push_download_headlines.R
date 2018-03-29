library(jsonlite)
library(magrittr)
library(tidyverse)
library(lubridate)
library(xlsx)

Connor_key <- "5b15a6f528e7486cbd51dd2f47265d25" #use your key!


year <- 2006 #set year
start_month <- 1 #starting month
end_month <- 5 #ending month
count <- 0 # cnt variable use within for loop
num_samples <- 25 # set number of sample of articles to choose from all categories of new articels(i.e. sports, finance, business, etc.)

# In this for-loop, we get headlines from each month of particular year and merge those monthly datasets. Final product is excel file with headlines and dates belonging to those months. 
for (month in c(start_month:end_month)) {
        url.nyt.archive<-paste0("https://api.nytimes.com/svc/archive/v1/",year,"/",month,".json","?api-key=",Connor_key)
        df.json<-fromJSON(url.nyt.archive, flatten = T)
        
        if (count == 0) {
                temp <- df.json$response$docs[c('type_of_material','headline.main',"pub_date")]
                temp <- temp %>%
                        filter(type_of_material == "News")
                temp <- temp %>%
                        group_by(pub_date) %>%
                        filter(max(row_number()) > 10) %>%
                        nest()
                
                temp_1 <- data.frame(headline = t(sample(temp$data[[1]]$headline.main,size = num_samples)), stringsAsFactors = F)
                
                for (i in c(2:nrow(temp))) {
                        temp_1 <- rbind(temp_1, data.frame(headline = t(sample(temp$data[[i]]$headline.main,size = num_samples)), stringsAsFactors = F))        
                }
                
                temp <- cbind(temp,temp_1)
                
                
        }
        else {
                temp_df <- df.json$response$docs[c('type_of_material','headline.main',"pub_date")]
                temp_df <- temp_df %>%
                        filter(type_of_material == "News")
                temp_df <- temp_df %>%
                        group_by(pub_date) %>%
                        filter(max(row_number()) > 10) %>%
                        nest()
                
                
                
                temp_1 <- data.frame(headline = t(sample(temp_df$data[[1]]$headline.main,size = num_samples)), stringsAsFactors = F)
                
                for (i in c(2:nrow(temp_df))) {
                        temp_1 <- rbind(temp_1, data.frame(headline = t(sample(temp_df$data[[i]]$headline.main,size = num_samples))), stringsAsFactors = F)        
                }
                
                temp_df <- cbind(temp_df,temp_1)
                
                temp <- rbind(temp,temp_df)
        }
        count <- count + 1
}


View(temp)

write.xlsx(temp[,-2], "nyt_headlines_example.xls", row.names = F)

