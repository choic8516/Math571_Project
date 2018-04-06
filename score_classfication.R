

library(xlsx)
library(tidyverse)

scores <- read.xlsx("data/scores/nyt_headlines_2001_scored.xls", sheetIndex = 1,stringsAsFactors=FALSE)
sub_scores <- scores

ll <- data.frame(t(sub_scores), stringsAsFactors = F)
dates <- ll[1,]
ll <- ll[-1,]
ll[] <- lapply(ll, as.numeric) 

classify_scores <- function(x) {
        list_scores <- c(0,0,0,0,0)
        names(list_scores) <- c("very_neg", "neg", "neut", "pos", "very_pos")
        
        for (i in (1:length(x))) {
        if (x[i] == 0 | is.na(x[i])) {
                list_scores["neut"] <- list_scores["neut"] + 1
        } else if (x[i] < 0 & x[i] > -0.5) {
                list_scores["neg"] <- list_scores["neg"] + 1
        } else if (x[i] <= -0.5) {
                list_scores["very_neg"] <- list_scores["very_neg"] + 1
        } else if (x[i] > 0 & x[i] < 0.5) {
                list_scores["pos"] <- list_scores["pos"] + 1
        } else {
                list_scores["very_pos"] <- list_scores["very_pos"] + 1
        }

        }
        
        list_scores
}

# kk <- lapply(ll,function(x) table(cut(t(x), breaks =  seq(-1, 1, by = .5))))

kk <- lapply(ll, classify_scores)

final <- data.frame(rbind(kk$X1,kk$X2))

for (i in (3 : length(kk))) {
        final <- rbind(final, kk[[i]]) 
}

final <- cbind(final, t(dates))

# we may change these col names
colnames(final) <- c("Very Negative", "Negative","Neutral", "Postive", "Very Positive", "Date")

View(final)

final[-6] %>%
        gather("Very Negative", "Negative","Neutral", "Postive", "Very Positive", key = "class", value =  "counts") %>%
        ggplot() +
        geom_bar(aes(x =counts)) +
        facet_wrap(~ class)
