# List of Exercises 3 - Simple Linear Regression

# 1) An investor wants to know if the number of financial assets positively affects the return of his 
# portfolio. The data are:

# Number of assets:  10 20 30 40 50 60 70 80 90 
# Return of the portfolio (in USD) 420 365 285 220 176 117 69 34 5

# Considering those data, what this investor should do?


# 2) Estimate the effect of the price of Asset B on the price of Asset A. 
# Consider the following data an analyst collected along ten business days:

# Asset A:  1.02 2.08 2.89 4.01 5.32 5.83 7.26 7.96 9.11 9.99 
# Asset B:  1.15 0.85 1.56 1.72 4.32 5.07 5.00 5.31 6.17 7.04


# 3) A marketing professional collected weekly data about sales revenues and ad clicks in
# 2019 and 2020. Those data are in the Excel spreadsheet "List of Exercises 3 - Dataset". The
# link for downloading this material is: 
# https://github.com/QuadriviumAcademic/Quantitative-Analysis/blob/082aca8c820179fb9056d0a4d81b6c39b4ba78b9/List%20of%20Exercises%203%20-%20Dataset.xlsx

# Based on this dataset, what could you deduce about the relationship between sales revenues and
# ad clicks?


####################################################
# ANSWERS - Remember that you have many alternatives
# in R Studio to answer the questions
####################################################

# 1) An investor wants to know if the number of financial assets positively affects the return of his 
# portfolio. The data are:

# Number of assets:  10 20 30 40 50 60 70 80 90 
# Return of the portfolio (in USD) 420 365 285 220 176 117 69 34 5

# Considering those data, what this investor should do?

# We will use the simple linear regression to answer this question. Let us follow the steps we have
# studied in this course.

# Step 1: define a theoretical model that takes causality into account.

# The investor wants to know if the number of assets positively affects the return of the portfolio. 
# Hence, he or she is supposing that the first is the independent variable and the second, 
# the dependent one. The theoretical model is:

# return = b0 + b1(number) or: y = b0 + b1(x1)


# Step 2: prepare the dataset

# Let us create two objects for our variables.

return <- c(420, 365, 285, 220, 176, 117, 69, 34, 5)
return
str(return)
plot(return)

number = c(10, 20, 30, 40, 50, 60, 70, 80, 90)
str(number)
plot(number)

# Let us check if we have outliers in those objects. Remember that simple linear regression is based
# on the mean. Therefore, the presence of outliers might bias the output.

boxplot(return, number) # Create paired boxplots for the objects.

# The boxplots indicate there are no outliers in both objects. That is great for us!


# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

question_1 <- lm(return ~ number) # The dependent variable (y) must come first.
summary(question_1) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for number is 1.51e-07 that is significantly less than 0.05. Therefore, it seems
# there is a statistically significant association between the number of assets and the return of the
# portfolio. 


# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant and the number of assets 
# is deemed to be useful for explaining the variation in the return of the portfolio.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.9818. This means that 98.2% of the variation in the return of
# the portfolio (the dependent variable) can be explained by the variation in the number of
# assets (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# 4.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 19.81 on 7 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed exam score falls 19.81 points away from the score 
# predicted by the regression line. This result implies that we should be careful about the estimated
# model since it indicates a relatively weak fit between the observed values and the regression line.


# 4.5) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed.We can check that by using a 
# residuals vs. fitted values plot:


res_q1 <- resid(question_1) # Stores the residuals in the object res_q1.
res_q1 # Call the object.

plot(fitted(question_1), res_q1) + abline(0,0) # Create a plot with a line at 0.

# The plot indicates there is no recognizable pattern in the residuals. Then we can conclude
# that they are randomly distributed.


# 4.6) Verify if the residuals follow a normal distribution

# The last assumption in the simple linear regression is that the residuals follow a normal
# distribution. We can verify this with a Q-Q plot:


qqnorm(res_q1) + qqline(res_q1) # Creates the Q-Q plot with a 45-degree line.

# In this plot the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this example, we
# can notice that there are some relatively mild deviations from this line. Therefore,
# we can assume that the residuals follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the variables:

# return of the portfolio = 453.5556 - 5.3133(number of assets)

# Analysis:

# The estimated model indicates that each asset decreases 5.3133 USD to the return of the
# portfolio. This result contraries the theoretical model because there is no empirical evidence
# of a positive (i.e. direct) relationship between the variables. However, those conclusions
# must be carefully considered since the residual standard error indicated a relatively weak 
# fit between the observed values and the regression line.


# 2) Estimate the effect of the price of Asset B on the price of Asset A. 
# Consider the following data an analyst collected along ten business days:

# Asset A:  1.02 2.08 2.89 4.01 5.32 5.83 7.26 7.96 9.11 9.99 
# Asset B:  1.15 0.85 1.56 1.72 4.32 5.07 5.00 5.31 6.17 7.04


# We will use the simple linear regression to answer this question. Let us follow the steps we have
# studied in this course.

# Step 1: define a theoretical model that takes causality into account.

# We want to estimate the effect of the price of Asset B on the price of Asset A. 
# Therefore, Asset B is the independent variable and Asset A, the dependent one.
#The theoretical model is:

# Price of Asset A = b0 - b1(price of Asset B) or: y = b0 - b1(x1)

# This time we will use a minus sign to represent the relationship between the variables. The question
# does not inform us if this relationship is positive (direct) or negative (inverse). Therefore, we
# do not have enough information for specifying our theoretical model. Let us arbitrarily consider the
# variables are inversely associated.


# Step 2: prepare the dataset

# Let us create two objects for our variables.

asset_a <- c(1.02, 2.08, 2.89, 4.01, 5.32, 5.83, 7.26, 7.96, 9.11, 9.99)
asset_a
str(asset_a)
plot(asset_a)

asset_b = c(1.15, 0.85, 1.56, 1.72, 4.32, 5.07, 5.00, 5.31, 6.17, 7.04)
str(asset_b)
plot(asset_b)

# Let us check if we have outliers in those objects. Remember that simple linear regression is based
# on the mean. Therefore, the presence of outliers might bias the output.

boxplot(asset_a, asset_b) # Create paired boxplots for the objects.

# The boxplots indicate there are no outliers in both objects. That is great for us!


# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

question_2 <- lm(asset_a ~ asset_b) # The dependent variable (y) must come first.
summary(question_2) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for asset_b is 7.18e-06 that is significantly less than 0.05. Therefore, it seems
# there is a statistically significant association between the prices of the assets.


# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant and useful 
# for explaining the dynamics between the prices of the assets.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.9201. This means that 92% of the variation in the price of
# Asset A (the dependent variable) can be explained by the variation in the price of
# Asset B (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# 4.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 0.8599 on 8 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average asset prices fall only 0.8599 points away from the score 
# predicted by the regression line.


# 4.5) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed.We can check that by using a 
# residuals vs. fitted values plot:


res_q2 <- resid(question_2) # Stores the residuals in the object res_q2.
res_q2 # Call the object.

plot(fitted(question_2), res_q2) + abline(0,0) # Create a plot with a line at 0.

# The plot indicates there is no recognizable pattern in the residuals. Then we can conclude
# that they are randomly distributed.


# 4.6) Verify if the residuals follow a normal distribution

# The last assumption in the simple linear regression is that the residuals follow a normal
# distribution. We can verify this with a Q-Q plot:


qqnorm(res_q2) + qqline(res_q2) # Creates the Q-Q plot with a 45-degree line.

# In this plot the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this example, we
# can notice that there are some relatively mild deviations from this line. Therefore,
# we can assume that the residuals follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the variables:

# Price of Asset A = 0.6366 + 1.2858(Price of Asset B)

# Analysis:

# The estimated model indicates that each dolar added to the price of Asset B increases the price
# of Asset A by US$1.2858. 


# 3) A marketing professional collected weekly data about sales revenues and ad clicks in
# 2019 and 2020. Those data are in the Excel spreadsheet "List of Exercises 3 - Dataset". The
# link for downloading this material is: 
# https://github.com/QuadriviumAcademic/Quantitative-Analysis/blob/082aca8c820179fb9056d0a4d81b6c39b4ba78b9/List%20of%20Exercises%203%20-%20Dataset.xlsx

# Based on this dataset, what could you deduce about the relationship between sales revenues and
# ad clicks?

# Step 1: define a theoretical model that takes causality into account.

# The marketing professional wants to know if there is an association between the variables. The
# logical reasoning in this case is that the ad clicks positively affect the sales revenues. 
# Therefore, the first is the independent variable and the second, the dependent one. The model is:

# Sales revenues = b0 + b1(ad clicks) or: y = b0 + b1(x1)


# Step 2: prepare the dataset

# This time we have a dataset on a Excel spreadsheet. We have to click on the link provided previously,
# download the file to our device, and click on the "Import Dataset" button on the Environment panel.


# Now we have imported the dataset, Let us check if we have outliers. 
# Remember that simple linear regression is based on the mean. 
# Therefore, the presence of outliers might bias the output.

boxplot(List_of_Exercises_3_Dataset$Sales, List_of_Exercises_3_Dataset$AdClicks) # Create paired boxplots.

# The boxplots indicate there are 5 outliers in sales and 1 in ad clicks. We have 106 observations
# for each variable. We could have up to 5 outliers (5% of 106) in each without having 
# to adopt procedures to deal with those extreme values. Therefore, we do not need to do anything
# since the number of outliers is within the acceptable limits. 


# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

question_3 <- lm(List_of_Exercises_3_Dataset$Sales ~ List_of_Exercises_3_Dataset$AdClicks) 
summary(question_3) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for ad clicks is < 2e-16 that is significantly less than 0.05. Therefore, it seems
# there is a statistically significant association between the variables.


# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant and the number of ad clicks 
# is deemed to be useful for explaining the variation in the sales revenues.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.8421. This means that 84.2% of the variation in the return of
# the sales revenues (the dependent variable) can be explained by the variation in the number of
# ad clicks (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# 4.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 199800 on 104 degrees of freedom.

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed exam score falls 199800 points away from the score 
# predicted by the regression line. This result implies that we should be careful about the estimated
# model since it indicates a weak fit between the observed values and the regression line.


# 4.5) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed.We can check that by using a 
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

# In this plot the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this example, we
# can notice that there are very mild deviations from this line. Therefore,
# we can assume that the residuals follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the variables:

# Sales revenues = 149,221.84 + 1,325.20(ad clicks)

# Analysis:

# The estimated model indicates that each ad click increases US$1,325.20  to the sales revenues.
# This result is in accordance with the theoretical model because there is empirical evidence
# of a positive (i.e. direct) relationship between the variables. However, those conclusions
# must be carefully considered since the residual standard error indicated a weak 
# fit between the observed values and the regression line.


# 2) Estimate the effect of the price of Asset B on the price of Asset A. 
# Consider the following data an analyst collected along ten business days:

# Asset A:  1.02 2.08 2.89 4.01 5.32 5.83 7.26 7.96 9.11 9.99 
# Asset B:  1.15 0.85 1.56 1.72 4.32 5.07 5.00 5.31 6.17 7.04


# We will use the simple linear regression to answer this question. Let us follow the steps we have
# studied in this course.

# Step 1: define a theoretical model that takes causality into account.

# We want to estimate the effect of the price of Asset B on the price of Asset A. 
# Therefore, Asset B is the independent variable and Asset A, the dependent one.
#The theoretical model is:

# Price of Asset A = b0 - b1(price of Asset B) or: y = b0 + b1(x1)

# This time we will use a minus sign to represent the relationship between the variables. The question
# does not inform us if this relationship is positive (direct) or negative (inverse). Therefore, we
# do not have enough information for specifying our theoretical model. Let us arbitrarily consider the
# variables are invesely associated.


# Step 2: prepare the dataset

# Let us create two objects for our variables.

asset_a <- c(1.02, 2.08, 2.89, 4.01, 5.32, 5.83, 7.26, 7.96, 9.11, 9.99)
asset_a
str(asset_a)
plot(asset_a)

asset_b = c(1.15, 0.85, 1.56, 1.72, 4.32, 5.07, 5.00, 5.31, 6.17, 7.04)
str(asset_b)
plot(asset_b)

# Let us check if we have outliers in those objects. Remember that simple linear regression is based
# on the mean. Therefore, the presence of outliers might bias the output.

boxplot(asset_a, asset_b) # Create paired boxplots for the objects.

# The boxplots indicate there are no outliers in both objects. That is great for us!


# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

question_2 <- lm(asset_a ~ asset_b) # The dependent variable (y) must come first.
summary(question_2) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for number is 7.18e-06 that is significantly less than 0.05. Therefore, it seems
# there is a statistically significant association between the prices of the assets.


# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant and the number of assets 
# is deemed to be useful for explaining the variation in the return of the portfolio.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.9201. This means that 92% of the variation in the price of
# Asset A (the dependent variable) can be explained by the variation in the price of
# Asset B (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 0.8599 on 8 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed exam score falls only 0.8599 points away from the score 
# predicted by the regression line.


# 4.4) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed.We can check that by using a 
# residuals vs. fitted values plot:


res_q2 <- resid(question_2) # Stores the residuals in the object res_q2.
res_q2 # Call the object.

plot(fitted(question_2), res_q2) + abline(0,0) # Create a plot with a line at 0.

# The plot indicates there is no recognizable pattern in the residuals. Then we can conclude
# that they are randomly distributed.


# 4.5) Verify if the residuals follow a normal distribution

# The last assumption in the simple linear regression is that the residuals follow a normal
# distribution. We can verify this with a Q-Q plot:


qqnorm(res_q2) + qqline(res_q2) # Creates the Q-Q plot with a 45-degree line.

# In this plot the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this example, we
# can notice that there are some relatively mild deviations from this line. Therefore,
# we can assume that the residuals follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the variables:

# Price of Asset A = 0.6366 + 1.2858(Price of Asset B)

# Analysis:

# The estimated model indicates that each dolar added to the price of Asset B increases the price
# of Asset A by US$1.2858.
