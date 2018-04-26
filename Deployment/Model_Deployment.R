library(plumber)

pr <- plumb("Deployment/plumber.R")
pr$run(port=8000)

#curl --data "very_neg=1&neg=1&neutral=1&pos=1&very_pos=1" "http://localhost:8000/predict"

