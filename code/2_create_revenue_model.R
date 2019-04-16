###############################################################################
##### PROJECT: ROSE-ROYCE
##### PURPOSE: CREATES MODEL AND PROJECTS ONTO DAYS THE FIRM CLOSED
###############################################################################

##split into test adn training data
sales_train = open %>%
  filter(date < mdy("1/1/2012"))

sales_test= open %>%
  filter(date >= mdy("1/1/2012"))

##define model
lin_mod = lm(revenue ~ wday + is_season + year + t_max + t_min + rain + csi_index,
             data = sales_train)

##check out of sample validity
pred = predict(lin_mod, newdata = sales_test)
SSE = sum((pred-sales_test$revenue)^2, na.rm=TRUE)
trainMean = mean(sales_train$revenue)
SST = sum((trainMean -sales_test$revenue)^2, na.rm=TRUE)
OSR2 = 1 -SSE/SST
OSR2

##predict revenue for days carwash was closed
closed$revenue_pred = predict(lin_mod, newdata = closed)
