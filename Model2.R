train[,1] = as.factor(train[,1]) # convert digit labels to factor for classification
train_h2o = as.h2o(train)


test_h2o = as.h2o(test)

## set timer
s <- proc.time()

## train model
model2 =
  h2o.deeplearning(x = 2:785,  # column numbers for predictors
                   y = 1,   # column number for label
                   training_frame = train_h2o, # data in H2O format
                   activation = "RectifierWithDropout", # algorithm
                   input_dropout_ratio = 0.05, # % of inputs dropout
                   hidden_dropout_ratios = c(0.05,0.05,0.05,0.05,0.05), # % for nodes dropout
                   balance_classes = TRUE, 
                   hidden = c(500,500,500,500,500), # two layers of 100 nodes
                   momentum_stable = 0.99,
                   nesterov_accelerated_gradient = T, # use it for speed
                   epochs = 1000) # no. of epochs

## print confusion matrix
mconf2<-h2o.confusionMatrix(model2)
s - proc.time()
## classify test set
h2o_y_test2 <- h2o.predict(model2, test_h2o)
## convert H2O format into data frame and  save as csv
df_y_test2 = as.data.frame(h2o_y_test2)
df_y_test2 = data.frame(ImageId = seq(1,length(df_y_test2$predict)), Label = df_y_test2$predict)
write.csv(df_y_test2, file = "submission3-r-h2o.csv", row.names=F)
#.94386