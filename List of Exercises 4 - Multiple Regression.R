# List of Exercises 4 - Multiple regression analysis

# 1) An investor is interested in verifying to which extent share prices of companies B 
# and C inversely affect the share price of company A. The investor collected the following data
# in the past 25 business days:

# Day:         1   2    3    4    5    6    7   8     9    10   11   12   13   14   15   16  17    18   19   20  21   22   23   24    25        

# Company A: 1.45 1.93 0.81 0.61 1.55 0.95 0.45 1.14 0.74 0.98 1.41 0.81 0.89 0.68 1.39 1.53 0.91 1.49 1.38 1.73 1.11 1.68 0.66 0.69 1.98

# Company B: 0.58 0.86 0.29 0.20 0.56 0.28 0.08 0.41 0.22 0.35 0.59 0.22 0.26 0.12 0.65 0.70 0.30 0.70 0.39 0.72 0.45 0.81 0.04 0.20 0.95

# Company C: 0.71 0.13 0.79 0.20 0.56 0.92 0.01 0.60 0.70 0.73 0.13 0.96 0.27 0.21 0.88 0.30 0.15 0.09 0.17 0.25 0.30 0.32 0.82 0.98 0.15

# Use the appropriate method to analyze the data e give the investor a solid recommendation.


# 2) The Extreme Fit Workout Academy has collected data about its energy consumption, 
# instructors’ workload, and the number of clients. The managers want to answer this: are those variables 
# increasing the academy total expenditure? The data can be downloaded at:

# https://github.com/QuadriviumAcademic/Quantitative-Analysis/blob/c20fce4754858e678a8fb91301e6f19c2c905106/List%20of%20Exercises%20%204.xlsx

# 3) Anna is a real state broker who has collected data about the prices of apartments in a large
# city in Brazil. She believes that area, age, number of rooms, and number of
# bathrooms directly affect those prices. Based on the data Anna has collected, could you affirm
# that she is right?

# The link to download the dataset is: 

# https://github.com/QuadriviumAcademic/Quantitative-Analysis/blob/c20fce4754858e678a8fb91301e6f19c2c905106/List%20of%20Exercises%20%204.xlsx

####################################################
# ANSWERS - Remember that you have many alternatives
# in R Studio to answer the questions
####################################################

# 1) An investor is interested in verifying to which extent the share prices of companies B 
# and C inversely affect the share price of company A. The investor collected the following data
# in the past 25 business days...

# Step 1: define a theoretical model that takes causality into account.

# The investor assumes that companies B and C share prices inversely affect the share
# price of company A. Therefore, we can define as the theoretical model:

# price_A = b0 - b1(price_B) - b2(price_C) or: 
#  y      = b0 - b1(x1)      - b2(x2)


# Step 2: prepare the data

# We will create a dataset comprising the data we will need in the analysis:

price_A <- c(1.45, 1.93, 0.81, 0.61, 1.55, 0.95, 0.45, 1.14, 0.74, 0.98, 1.41, 0.81, 0.89, 0.68,
             1.39, 1.53, 0.91, 1.49, 1.38, 1.73, 1.11, 1.68, 0.66, 0.69, 1.98)
price_A
str(price_A)

price_B <- c(0.58, 0.86, 0.29, 0.20, 0.56, 0.28, 0.08, 0.41, 0.22, 0.35, 0.59, 0.22, 0.26, 0.12,
            0.65, 0.70, 0.30, 0.70, 0.39, 0.72, 0.45, 0.81, 0.04, 0.20, 0.95)
price_B
str(price_B)

price_C <- c(0.71, 0.13, 0.79, 0.20, 0.56, 0.92, 0.01, 0.60, 0.70, 0.73, 0.13, 0.96, 0.27, 0.21, 0.88,
            0.30, 0.15, 0.09, 0.17, 0.25, 0.30, 0.32, 0.82, 0.98, 0.15)
price_C
str(price_C)

# Let us store the objects into a data frame:

data_q1 <- data.frame(price_A, price_B, price_C)
data_q1
str(data_q1)

# Step 3: check the theoretical assumption that the independent variables have a linear association 
# with the dependent variable.

# To test this assumption, we will create a scatterplot with every possible pair of variables:

pairs(data_q1, pch = 18, col = "red")


# We can access the correlations by computing Pearson's r.

if(!require(PerformanceAnalytics)) install.packages("PerformanceAnalytics") # Installs the package, if necessary
library(PerformanceAnalytics) # Loads the "PerformanceAnalytics" package.

chart.Correlation(data_q1, histogram = TRUE, method = c("pearson")) # Creates the correlation chart.

# CAUTION!!!! 
# The correlation chart indicates that price_C is not statistically correlated with price_A and
# price_B (the p-value is not statically significant in both cases). Therefore, the theoretical
# model is already compromised. The right procedure to follow in this case is to delete price_C
# from the dataset and resume the analysis using a simple linear regression model with price_A
# (dependent variable) and price_B (independent variable). You can perform that analysis and
# check the results.

# However, we will verify what would happen if we insisted on multiple regression. 
# Remember this is profoundly wrong! We will do that just for learning purposes.


# Step 4: Estimate the empirical model

model_q1 <- lm(price_A ~ price_B + price_C, data = data_q1) # Stores the output in the object "model_q1".

# IMPORTANT: even though our theoretical model states an inverse relationship among the variables,
# R Studio demands we use the plus sign (+) in the function lm(). If we use the minus sign (-)
# just like in the theoretical model, R Studio will consider removing price_C from the analysis.

summary(model_q1) # Exhibits the full output.

# Step 5: Checking the empirical assumptions of the multiple regression

# Empirical assumption 1: the distribution of model residuals should be approximately normal.

hist(residuals(model_q1), col = "darkblue") # Plots the histogram of the residuals.

# We can notice that, despite some skewness to the right, the residuals might come from 
# an approximately normal distribution.

# Empirical assumption 2: the residuals are randomly distributed.

# To check that assumption, we will use the fitted value vs. residual plot:

plot(fitted(model_q1), residuals(model_q1)) + abline(h = 0, lty = 2) # Creates the fitted value vs residual plot.

# The plot indicates that the residuals do not have any identifiable distribution pattern. Therefore,
# we can assume they are randomly distributed.

# Step 6: interpreting the output

# 6.1) Interpret the p-value for the independent variables

# Variable price_B is statistically significant at <0.00. However, price_C
# is not statistically significant. Therefore, we do not have empirical evidence
# about its effect on the dependent variable.


# 6.2) Interpret the F-test

# It shows us the overall significance of the regression model, that is, if the independent 
# variables help explain the variation in the dependent variable. The null hypothesis (H0) 
# is that at least one of the coefficients associated with the independent variable differs 
# from 0 (zero). 

# 6.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.9344. This would mean that 93.4% of the variation in price_A (the dependent
# variable) could be explained by the variations of the independent variables.


# 6.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 0.1127 on 22 degrees of freedom

# This is the average distance the observed values fall from the regression line. 
# The lower this value, the more closely a regression line can match the observed data. 
# In this example, the average observed values of the independent variables fall only 0.1127 
# points away from the score predicted by the regression line.

# Conclusion

# We analyzed the estimated multiple regression model for learning purposes only. As we could notice,
# there was nothing to say about that model because it was compromised. Variable price_C  was
# not associated with variables price_A and price_B. Therefore the only alternative we had was to 
# redefine this model excluding price_C from the analysis. We would have to work with
# a simple linear regression model in this case.

# This question is helpful to illustrate that multiple regression might be the wrong choice in some
# cases. Theoretically speaking, it allows us to deal with n-dimensional models that are generally
# closer to the real-world phenomena. However, multiple regression is useless when we have data that
# does not meet its assumptions. When we face situations like that, we must be open to reevaluating our
# plans and changing the analysis method.


# 2) The Extreme Fit Workout Academy has collected data about its energy consumption, 
# instructors’ workload, and the number of clients. The managers want to answer this: are those variables 
# increasing the academy total expenditure? The data can be downloaded at...

# Step 1: define a theoretical model that takes causality into account.

# The managers believe that the variables affect the total expenditure directly. Therefore, the 
# the theoretical model is:

# expenditure = b0 + b1(energy) + b2(workload) + b3(clients) or: 
#  y          = b0 + b1(x1)      + b2(x2)      + b3(x3) 


# Step 2: prepare the data

# We need to download the Excel file that comprises the dataset and save it in our device.
# Then, we have to import it to R Studio.

# However, before doing this, we must check if this file is suitable for R Studio.

# Now, let us store the data we need into the object data_q2

data_q2 <- data.frame(List_of_Exercises_4)
data_q2
str(data_q2)

# We do not need the variable "Month". Therefore, let us delete it from our dataset:

data_q2 <- data_q2[, -1] # Deletes the first variable in the dataset and stores the new data into the same object.
data_q2

# Step 3: check the theoretical assumption that the independent variables have a linear association 
# with the dependent variable.

# To test this assumption, we will create a scatterplot with every possible pair of variables:

pairs(data_q2, pch = 18, col = "darkred")

# We can access the correlations by computing Pearson's r.

if(!require(PerformanceAnalytics)) install.packages("PerformanceAnalytics") # Installs the package, if necessary
library(PerformanceAnalytics) # Loads the "PerformanceAnalytics" package.

chart.Correlation(data_q2, histogram = TRUE, method = c("pearson")) # Creates the correlation chart.

# Step 4: Estimate the empirical model

model <- lm(expenditure ~ energy + workload + clients, data = data_q2) # Stores the output in the object "model".
summary(model) # Exhibits the full output.

# Step 5: Checking the empirical assumptions of the multiple regression

# Empirical assumption 1: the distribution of model residuals should be approximately normal.

hist(residuals(model), col = "darkgreen") # Plots the histogram of the residuals.

# We can notice that, despite some skewness to the left, the residuals might come from 
# an approximately normal distribution.

# Empirical assumption 2: the residuals are randomly distributed.

# To check that assumption, we will use the fitted value vs. residual plot:

plot(fitted(model), residuals(model)) + abline(h = 0, lty = 2) # Creates the fitted value vs residual plot.

# The plot indicates that the residuals do not have any identifiable distribution pattern. Therefore,
# we can assume they are randomly distributed.

# Step 6: interpreting the output

summary(model) # Exhibits the full output.

# 6.1) Interpret the p-value for the independent variables

# The independent variables were statistically significant at the <0.00 (workload) and
# 0.01 (energy and clients) levels. These results indicate the following:

# The one kW increase in energy will add US$10.92 to the total expenditure, assuming that the other independent
# variables are held constant.

# The one average hour increase in the instructors' workload will add US$11.47 to the total expenditure, 
# assuming that the other independent variables are held constant.

# The one unit increase in the number of clients will add US$1.76 to the total expenditure, 
# assuming that the other independent variables are held constant.

# 6.2) Interpret the F-test

# The F-test output is in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable differs from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables help explain the variation in the dependent variable. 
# Since the p-value is lower than 0.05, the model is statistically significant and the 
# independent variables are deemed helpful for explaining the variation in the dependent
# variable.

# 6.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals 0.9114.This means that 91.1% of the variation in total expenditure
# (the dependent variable) can be explained by the variations of the independent variables.

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1, the better. However, an R2 equals 1 indicates overfitting in the model. That
# is not a good situation because the variables might be redundant.

# 6.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 29.93 on 11 degrees of freedom

# This is the average distance the observed values fall from the regression line. 
# The lower this value, the more closely a regression line can match the observed data. 
# In this example, the average observed values of the independent variables fall 29.93
# points away from the score predicted by the regression line. This result implies that we
# should be careful about the estimated model since the data do not seem to be adequately
# fit to the regression line.

# Conclusion

# The estimated model meets the requirements of a solid multiple regression analysis. However,
# it has to be considered carefully since the residual standard error indicates a relatively
# poor fit between the observed data and the regression line. That said, the model can be
# represented by the following equation:

# expenditure = -28.4224 + 10.9197(energy) + 11.4666(workload) + 1.7577(clients)

# Notice that we have a negative intercept. What does it mean?

# It means that if the academy had no clients, no instructors, and no energy consumption, 
# it would expect a loss of US$28.42.


# 3) Anna is a real state broker who has collected data about the prices of apartments in a large
# city in Brazil. She believes that area, age, number of rooms, and the number of
# bathrooms directly affect those prices. Based on the data Anna has collected, could you affirm
# that she is right?

# Step 1: define a theoretical model that takes causality into account.

# Anna believes that the price of an apartment is directly influenced by its area, age, number 
# of rooms, and number of bathrooms. Therefore, the theoretical model could be represented by the
# following equation:

# price = b0 + b1(area) + b2(age) + b3(rooms) + b4(bathrooms) or: 
#  y    = b0 + b1(x1)   + b2(x2)  + b3(x3)    + b4(x4) 


# Step 2: prepare the data

# We need to download the Excel file that comprises the dataset and save it in our device.
# Then, we have to import it to R Studio.

# However, before doing this, we must check if this file is suitable for R Studio.

# Now, let us store the data we need into the object data_q3

data_q3 <- data.frame(List_of_Exercises_4)
data_q3
str(data_q3)


# Step 3: check the theoretical assumption that the independent variables have a linear association 
# with the dependent variable.

# To test this assumption we will create a scatterplot with every possible pair of variables:

pairs(data_q3, pch = 18, col = "darkgreen")

# We can access the correlations by computing Pearson's r.

if(!require(PerformanceAnalytics)) install.packages("PerformanceAnalytics") # Installs the package, if necessary
library(PerformanceAnalytics) # Loads the "PerformanceAnalytics" package.

chart.Correlation(data_q3, histogram = TRUE, method = c("pearson")) # Creates the correlation chart.

# Step 4: Estimate the empirical model

model <- lm(price ~ area + age + rooms + bathrooms, data = data_q3) # Stores the output in the object "model".
summary(model) # Exhibits the full output.

# Once again, we have variables that are not statistically significant. The estimated model
# indicates that only the area affects the price of the apartments. This time we will do the right
# thing: we will exclude all the non-significant variables from our analysis. This means we will drop
# variables age, rooms, and bathrooms. Since we will keep the area only, the new theoretical model 
# will be:

# price = b0 + b1(area)

# Now, we are back to simple linear regression. Let us follow the same procedures we have studied
# previously:

# Let us check if we have outliers in those objects. Remember that simple linear regression is based
# on the mean. Therefore, the presence of outliers might bias the output.

boxplot(data_q3$price, data_q3$area) # Create paired boxplots for the objects.

# The boxplots indicate there is one outlier in each object. We have 39 observations, and this means we can have
# up to 1.95 (5%) outliers in each object. Therefore, we can keep them in the dataset.


# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

question_3 <- lm(price ~ area, data = data_q3) # The dependent variable (y) must come first.
summary(question_3) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for area is 2.65e-10, and it is significant at the level of <0.0. Therefore, 
# it seems there is a statistically significant association between the area and the price
# of the apartments. 


# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable differs from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpful for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant, and area
# is deemed useful for explain the variation in the prices of the apartments.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals 0.6555. This means that 65.55% of the variation in the prices of the
# apartments (the dependent variable) can be explained by the variation in their area
# (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1, the better. However, an R2 equals 1 indicates overfitting in the model. That
# is not a good situation because the variables might be redundant.

# 4.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 48740 on 37 degrees of freedom

# This is the average distance the observed values fall from the regression line. 
# The lower this value, the more closely a regression line can match the observed data. 
# In this example, the average observed exam score falls 48740 points away from the score 
# predicted by the regression line. This result implies that we should be cautious 
# about the estimated model since it indicates a relatively weak fit between the observed 
# values and the regression line.


# 4.5) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed. We can check that by using a 
# residuals vs. fitted values plot:


res_q3 <- resid(question_3) # Stores the residuals in the object res_q1.
res_q3 # Call the object.

plot(fitted(question_3), res_q3) + abline(0,0) # Create a plot with a line at 0.

# The plot indicates there is no recognizable pattern in the residuals. Then we can conclude
# that they are randomly distributed.


# 4.6) Verify if the residuals follow a normal distribution

# The last assumption in the simple linear regression is that the residuals follow a normal
# distribution. We can verify this with a Q-Q plot:


qqnorm(res_q3) + qqline(res_q3) # Creates the Q-Q plot with a 45-degree line.

# In this plot, the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this case, we
# can notice that the plot extremes present some relatively strong deviations from this line. 
# However, the sample quantiles are well adjusted to this line considering the range from -1
# to 1. Therefore, we can assume that the residuals might follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the variables:

# price = 137682.80 + 728.23(area)

# Analysis:

# The estimated model indicates that each squared meter increases R$728.23 to the prices of the
# apartments. This result is coherent with the theoretical model because it evidences the 
# variables' positive (i.e., direct) relationship. However, those conclusions
# must be carefully considered. The residual standard error indicated a relatively weak 
# fit between the observed values and the regression line. Besides, the quantiles presented mild fit
# to the normal Q-Q plot line.

