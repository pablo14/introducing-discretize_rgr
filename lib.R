library(caret)
library(tidyverse)

create_binary_model <- function(data_tr_sample, target, best_vars) 
{
  # data_tr_sample=heart_diseaes_cat
  # target = heart_disease$has_heart_disease
  # best_vars=c("thal", "exter_angina")
  
  fitControl <- trainControl(method = "repeatedcv", 
                             number = 3, 
                             repeats = 2,
                             summaryFunction = twoClassSummary,
                             classProbs = TRUE)
  
  
  #params_grid <- expand.grid(mtry=c(13)) # rf 13
  #params_grid <- expand.grid(interaction.depth = c(5,13), n.trees = c(5,13)*100, shrinkage = c(.03, .1), n.minobsinnode=20)
  
  library(doParallel)
  registerDoParallel(6)
  
  data_model=select(data_tr_sample, one_of(best_vars)) #%>% mutate_if(is.character, as.factor)
  
  #a=make.names(target)
  fit_model_1 <- train(x=data_model, 
                       y= target, 
                       method = "rf", 
                       trControl = fitControl,
                       metric = "ROC")
  #tuneGrid = params_grid)
  
  return(fit_model_1)
}

create_multinom_model <- function(data_tr_sample, target, best_vars) 
{
  # data_tr_sample=heart_diseaes_cat
  # target = heart_disease$has_heart_disease
  # best_vars=c("thal", "exter_angina")
  
  fitControl <- trainControl(method = "repeatedcv", 
                             number = 3, 
                             repeats = 2,
                             classProbs = TRUE)
  
  
  #params_grid <- expand.grid(mtry=c(13)) # rf 13
  #params_grid <- expand.grid(interaction.depth = c(5,13), n.trees = c(5,13)*100, shrinkage = c(.03, .1), n.minobsinnode=20)
  
  library(doParallel)
  registerDoParallel(6)
  
  data_model=select(data_tr_sample, one_of(best_vars)) #%>% mutate_if(is.character, as.factor)
  
  #a=make.names(target)
  fit_model_1 <- train(x=data_model, 
                       y= target, 
                       method = "rf", 
                       trControl = fitControl,
                       metric = "Kappa")
  #tuneGrid = params_grid)
  
  return(fit_model_1)
}
