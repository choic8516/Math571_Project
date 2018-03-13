install.packages('jsonlite')
library(jsonlite)
library(magrittr)

mykey <- "612f84f8008e44b59e4feab59360faee" # API key

# queries for articles from may 14,1995 - may 15, 1995. no 'q' parameter
art <- fromJSON("http://api.nytimes.com/svc/search/v2/articlesearch.json?begin_date=19950514&end_date=19950515&api-key=612f84f8008e44b59e4feab59360faee", 
              flatten = TRUE) %>% data.frame()

headlines <- art$response.docs.headline.main # only the headlines
headlines