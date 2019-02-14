library(funModeling)
source("lib.R")

#####################################
## Test 1: heart disease dataset
## binary target variable
#####################################
input=heart_disease$oldpeak
target=heart_disease$has_heart_disease

heart_disease$new_input=discretize_rgr(input, target)

describe(new_input)

fit_model_1=create_binary_model(data_tr_sample = heart_disease,
																target = as.factor(heart_disease$has_heart_disease),
																best_vars = "oldpeak"); fit_model_1

fit_model_2=create_binary_model(data_tr_sample =  heart_disease,
																target = as.factor(heart_disease$has_heart_disease),
																best_vars = "new_input"); fit_model_2


resamp=resamples(list(fit_oldpeak = fit_model_1, fit_oldpeak_cat=fit_model_2))
bwplot(resamp, layout = c(3, 1))



#####################################
## Test 2: diamonds dataset
## multinomial target variable
#####################################
input=diamonds$price
target=diamonds$cut

diamonds$new_input=discretize_rgr(input,
												 target,
												 min_perc_bins =0.05,
												 max_n_bins = 15)

table(diamonds$new_input, diamonds$cut)

fit_model_1=create_multinom_model(data_tr_sample = diamonds,
																target = make.names(diamonds$cut),
																best_vars = "price"); fit_model_1

fit_model_2=create_multinom_model(data_tr_sample = diamonds,
																	target = make.names(diamonds$cut),
																	best_vars = "new_input"); fit_model_2


resamp=resamples(list(fit_price = fit_model_1, fit_price_cat=fit_model_2))
bwplot(resamp, layout = c(3, 1))



#####################################
## Test 3: breast cancer dataset
## binary target variable
#####################################
data_br=read_delim("data_breast_cancer2.csv", delim = ",")

input=data_br$texture_mean
target=data_br$diagnosis

data_br$new_input=discretize_rgr(input,
																	target)


fit_model_1=create_binary_model(data_tr_sample = data_br,
																	target = as.factor(data_br$diagnosis),
																	best_vars = "texture_mean"); fit_model_1

fit_model_2=create_binary_model(data_tr_sample =  data_br,
																	target = as.factor(data_br$diagnosis),
																	best_vars = "new_input"); fit_model_2


resamp=resamples(list(fit_original = fit_texture, fit_disc=fit_texture_cat))
bwplot(resamp, layout = c(3, 1))


#####################################
## Test 4: breast cancer dataset
## numeric target variable
#####################################
# First, we need to convert the numeric target into categorical due to the
# nature of the algorithm
diamonds$price_cat=equal_freq(diamonds$price, 7)


##
input=diamonds$carat
target=diamonds$price_cat

diamonds$carat_2=discretize_rgr(input,
																 target)

fit_model_1=create_multinom_model(data_tr_sample = diamonds,
																	target = make.names(diamonds$cut),
																	best_vars = "carat"); fit_model_1

fit_model_2=create_multinom_model(data_tr_sample = diamonds,
																	target = make.names(diamonds$cut),
																	best_vars = "carat_2"); fit_model_2




resamp=resamples(list(fit_carat = fit_model_1, fit_carat_cat=fit_model_2))
bwplot(resamp, layout = c(3, 1))


