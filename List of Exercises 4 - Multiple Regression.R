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
# instructors’ workload, and number of clients. The managers want to answer this: are those variables 
# affecting the academy total expenditure? The data can be downloaded at:







# 3) Anna is a real state broker who has collected data about the prices of apartments in a large
# city in Brazil. She believes that variables such as area, age, number of rooms, and number of
# bathrooms directly affect those prices. Based on the data Anna has collected, could you affirm
# that she is right?

# The link to download the dataset is: 
# https://github.com/QuadriviumAcademic/Quantitative-Analysis/blob/5320449d1a37b7207e07c90ce90a03b8f68f90df/List%20of%20Exercises%20%204%20-%20Q3.xlsx


####################################################
# ANSWERS - Remember that you have many alternatives
# in R Studio to answer the questions
####################################################

# 1) An investor is interested in verifying to which extent the share prices of companies B 
# and C inversely affect the share price of company A. The investor collected the following data
# in the past 25 business days...

# Step 1: define a theoretical model that takes causality into account.

# The investor's assumption is that the share prices of companies B and C inversely affect the share
# price of company A. Therefore, the theoretical model can be defined as:

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

# Step 3: check the theoretical assumption that the independent variables have linear association 
# with the dependent variable.

# To test this assumption we will create a scatterplot with every possible pair of variables:

pairs(data_q1, pch = 18, col = "red")


# We can access the correlations by computing the Pearson's r.

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

# However, we will verify what would happen if we insisted on proceed with multiple regression. 
# Remeber this is profoundly wrong! We will do that just for learning purposes.


# Step 4: Estimate the empirical model

model_q1 <- lm(price_A ~ price_B + price_C, data = data_q1) # Stores the output in the object "model_q1".

# IMPORTANT: even though our theoretical model states an inverse relationship among the variables,
# R Studio demands we use the plus sign (+) in the function lm(). If we use the minus sign (-)
# just like in the theoretical model, R Studio will consider we are removing price_C
# from the analysis.

summary(model_q1) # Exhibits the full output.

# Step 5: Checking the empirical assumptions of the multiple regression

# Empirical assumption 1: the distribution of model residuals should be approximately normal.

hist(residuals(model_q1), col = "darkblue") # Plots the histogram of the residuals.

# We can notice that, despite some skewness to the right, the residuals might come from 
# an approximately normal distribution.

# Empirical assumption 2: the residuals are randomly distributed.

# To check that assumption we will use the fitted value vs. residual plot:

plot(fitted(model_q1), residuals(model_q1)) + abline(h = 0, lty = 2) # Creates the fitted value vs residual plot.

# The plot indicates that the residuals do not have any identifiable pattern of distribution. Therefore,
# we can assume they are randomly distributed.

# Step 6: interpreting the output

# 6.1) Interpret the p-value for the independent variables

# Variable price_B is statistically significant at the <0.00. However, price_C
# statistically significant. Therefore, we do not have empirical evidence
# about its effect on the dependent variable.


# 6.2) Interpret the F-test

# The F-test output is in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 

# 6.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.9344. This would mean that 93.4% of the variation in price_A (the dependent
# variable) could be explained by the variations of the independent variables.


# 6.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 0.1127 on 22 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed values of the independent variables fall only 0.1127 
# points away from the score predicted by the regression line.

# Conclusion

# We analysed the estimated multiple regression model just for learning purposes. As we could notice,
# there was nothing to say about that model because it was compromised. Variable price_C clearly was
# not associated with variables price_A and price_B. Therefore the only alternative we had was to 
# redefine this model excluding price_C from the analysis. In this case, we would have to work with
# a simple linear regression model.

# This question is helpful to illustrate that multiple regression might be the wrong choice in some
# cases. Theoretically speaking, it allows us to deal with n-dimensional models that are generally
# closer to the real-world phenomena. However, multiple regression is useless when we have data that
# do not meet its assumptions. When we face situations like that we must be open to reevaluate our
# plans and change the method of analysis. 


# 2) John is a business manager who has been investing in cryptocurrencies. He has created Portfolio A
# that comprises a basket of eight cryptocurrencies. However, he believes that the average monthly prices
# of Bitcoin and Ethereum affect the return of that portfolio directly. Use the appropriate method
# to analyze the following data and answer this question: is John right?

# Step 1: define a theoretical model that takes causality into account.

# We will analyse the mtcars dataset again. This time, we will consider that the average montly price
# of Bitcoin and Ethereum affect the return of the portfolio directly. 

# Therefore, the theoretical model is:

# return = b0 + b1(bitcoin) + b2(ethereum) or: 
#  y     = b0 + b1(x1)      + b2(x2) 


# Step 2: prepare the data

# Let us create the objects to store the data:

return <- c(9.29,  12.67, 12.42, 0.38, 20.77,  9.52,  2.38,  7.46)
return
str(return)

bitcoin <- c(1.00, 2.00, 3.00, 4.00, 5.00, 6.00, 7.00, 8.00)
bitcoin
str(bitcoin)

ethereum <- c(4.00, 12.00, 16.00, 8.00, 32.00, 24.00, 20.00, 28.00)
ethereum
str(ethereum)

# Let us store the objects into a data frame:

data_q2 <- data.frame(return, bitcoin, ethereum)
data_q2
str(data_q2)


# Step 3: check the theoretical assumption that the independent variables have linear association 
# with the dependent variable.

# To test this assumption we will create a scatterplot with every possible pair of variables:

pairs(data_q2, pch = 18, col = "darkred")

# We can access the correlations by computing the Pearson's r.

if(!require(PerformanceAnalytics)) install.packages("PerformanceAnalytics") # Installs the package, if necessary
library(PerformanceAnalytics) # Loads the "PerformanceAnalytics" package.

chart.Correlation(data_q2, histogram = TRUE, method = c("pearson")) # Creates the correlation chart.

# Step 4: Estimate the empirical model

model <- lm(mpg ~ disp + hp + drat, data = data) # Stores the output in the object "model".
summary(model) # Exhibits the full output.

# Step 5: Checking the empirical assumptions of the multiple regression

# Empirical assumption 1: the distribution of model residuals should be approximately normal.

hist(residuals(model), col = "darkgreen") # Plots the histogram of the residuals.

# We can notice that, despite some skewness to the right, the residuals might come from 
# an approximately normal distribution.

# Empirical assumption 2: the residuals are randomly distributed.

# To check that assumption we will use the fitted value vs. residual plot:

plot(fitted(model), residuals(model)) + abline(h = 0, lty = 2) # Creates the fitted value vs residual plot.

# The plot indicates that the residuals do not have any identifiable pattern of distribution. Therefore,
# we can assume they are randomly distributed.

# Step 6: interpreting the output

summary(model) # Exhibits the full output.

# 6.1) Interpret the p-value for the independent variables

# Variables disp and hp are statistically significant at the 0.01 level and drat is statistically significant
# at the 0.05 level. These results indicate the following:

# One unit increase in disp will reduce mpg in 0.019232 units, assuming that the other independent
# variables are held constant. Remember that our theoretical model established that there was a
# direct relationship between disp and mpg. Therefore, we can affirm that the empirical evidence
# do not support that theoretical model concerning that especific relationship.

# One unit increase in hp will reduce mpg in 0.031220 units, assuming that the other independent
# variables are held constant. Once again, our empirical evidence contraries the theoretical model.

# One unit increase in drat will increase mpg in 2.714975 units, assuming that the other independent
# variables are held constant. This time, our empirical evidence is supporting the theoretical model.

# 6.2) Interpret the F-test

# The F-test output is in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
# Since the p-value is lower than 0.05, the model is statistically significant and the 
# independent variables are deemed to be useful for explaining the variation in mpg.

# 6.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.7509. This means that 75.9% of the variation in mpg (the dependent
# variable) can be explained by the variations of the independent variables.

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# 6.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 3.008 on 28 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed values of the independent variables fall only 3.008 
#points away from the score predicted by the regression line.

# Conclusion

# The estimated model meets the requirements of a solid multiple regression analysis. However,
# it contraries the theoretical model concerning to the relationships between the independent 
# variables disp and hp and the dependent variable. The theoretical model assumed that those
# relationships were direct but the estimated model indicated that they were, in fact, inverse.
# Therefore, the empirical evidence indicated the following association among the variables:

# mpg = 19.344293 - 0.019232(disp) - 0.031229(hp) + 2.714975(drat)


