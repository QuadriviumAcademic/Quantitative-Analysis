# Multiple regression in R

# Step 1: define a theoretical model that takes causality into account.

# We will analyse the mtcars dataset again. This time, we will consider that the fuel consumption
# (mpg) of the car models depends on the displacement (disp), the gross horsepower (hp), and
# the rear axle ratio (drat).

# Therefore, the theoretical model is:

# mpg = b0 + b1(disp) + b2(hp) + b3(drat) or: 
#  y  = b0 + b1(x1)   + b2(x2) + b3(x3)

# Please remember that the plus sign (+) means that we are considering the independent variables
# have direct relationship with the dependent variable.In other words, the higher the values of X1, 
#X2 or X3, the higher the value of y. The opposite is also true: the lower the value of an independent 
# variable, the lower the value of y. To represent that situation we were supposed to use the minus
# sign (-).

# A last note on that subject matter: you do not need to consider all the independent variables have
# the same type of relationship with the dependent variable. Therefore, you are free to have a 
# theoretical model like this:

# y = b0 - b1(x1) + b2(x2) - b3(x3) - b4(x4) + b5(x5)

# Let us get back to our theoretical model:

# mpg = b0 + b1(disp) + b2(hp) + b3(drat)

# We will test it empirically with the mtcars dataset.


# Step 2: prepare the data

head(mtcars) # Exhibits the first six lines of the dataset.

# We will prepare the data, creating an object to store only the variables we need:

data <- mtcars[ , c("mpg", "disp", "hp", "drat")]
data
str(data) # Exhibits the structure of the variables in the object.

# Step 3: check the theoretical assumption that the independent variables have linear association 
# with the dependent variable.

# To test this assumption we will create a scatterplot with every possible pair of variables:

pairs(data, pch = 18, col = "steelblue")

# The scatterplot allows us to conclude that: 

# 1) mpg and disp apparently have a strong negative linear correlation;
# 2) mpg and hp apparently have a strong positive linear correlation;
# 3) mpg and drat apparently have a mild negative linear correlation.

# We can access the correlations by computing the Pearson's r.

if(!require(PerformanceAnalytics)) install.packages("PerformanceAnalytics") # Installs the package, if necessary
library(PerformanceAnalytics) # Loads the "PerformanceAnalytics" package.

chart.Correlation(data, histogram = TRUE, method = c("pearson")) # Creates the correlation chart.

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
