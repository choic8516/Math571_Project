library(class)
library(caret)
library(jsonlite)
library(plumber)
load("Deployment/KNN_Model.RData")

#* @post /predict
predict_knn <- function(very_neg, neg, neutral, pos, very_pos) {
        data <- list(very_neg, neg, neutral, pos, very_pos)
        prediction <- knn(train = k_train_xVars, test = data, cl = k_train_label, k = opt_k)
        return(numeric(prediction))
}

# return(list(default.probability=unbox(prediction[1, 2])))

#* @get /mean
normalMean <- function(samples=10){
        data <- rnorm(samples)
        mean(data)
}

#paste0("Predicted Dow Jones Index Movement: ", ifelse(prediction == 1, "UP", "DOWN" ))

# predict_knn()
