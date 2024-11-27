# data_preprocessing.R

# Função para carregar e explorar dados
load_and_explore <- function(filepath) {
  data <- read.csv(filepath)
  print(head(data))
  print(summary(data))
  return(data)
}

# Função para escalar variáveis numéricas
scale_features <- function(data, numeric_cols) {
  library(caret)
  preproc <- preProcess(data[, numeric_cols], method = c("center", "scale"))
  scaled_data <- predict(preproc, data[, numeric_cols])
  return(cbind(scaled_data, data[setdiff(names(data), numeric_cols)]))
}

source("data_preprocessing.R")
scaled_data <- scale_features(data, c("Sepal.Length", "Sepal.Width"))
head(scaled_data)

source("model_training.R")
model <- train_decision_tree(scaled_data, "Species")
summary(model)

library(ggplot2)
ggplot(data, aes(Sepal.Length, Sepal.Width, color = Species)) +
  geom_point()




