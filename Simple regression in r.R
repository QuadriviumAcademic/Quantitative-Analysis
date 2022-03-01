# How to perform simple linear regression in R Studio

# Step 1: define a theoretical model that takes causality into account.

# As we have seen in this course, simple linear regression considers that the independent variable x
# affects - to some degree - the dependent variable y. Therefore, causality is a mandatory assumption
# in that method. 

# In this tutorial, we will analyze the relationship between the total hours studied for the final
# exam and the student's score in it.

# The theoretical relationship between those variables is: the higher the total hours, the higher
# the score. In this case, causality implies that the total hours positively affect the score.
# We can express this relationship mathematically as follows:

# y = b0 + b1x1

# Where:

# y = final exam score (dependent variable)
# b0 = the intercept
# b1 = the coefficient that measures the effect of the independent variable on the dependent one.
# x1 = total hours studied

# This is our theoretical model. By performing a simple linear regression analysis, we want to verify
# if our empirical data - i.e., data we have collected - support that model.


# Step 2: prepare the dataset

# We will use fictional data in this example. Let us create two objects for that.

hours <- c(1, 2, 4, 5, 5, 6, 6, 7, 8, 10, 11, 11, 12, 12, 14)
hours
str(hours)
plot(hours)

score <- c(64, 66, 76, 73, 74, 81, 83, 82, 80, 88, 84, 82, 91, 93, 89)
score
str(score)
plot(score)


# Simple linear regression is a method based on the arithmetic mean. The mean value is substantially
# affected by extreme values on a dataset. For example, the mean of the dataset
# A = {1, 2, 3, 4} is 2.5. If this dataset was A* = {1, 2, 3, 4000} the mean would equal to 1,001.50.
# One single value has changed the mean substantially. 

# Because of that property of the mean we have to be careful about
# the values in our dataset. Extreme values - that is, values far higher than or far lower than - 
# the other might lead to biased output in the simple linear regression analysis. 

# We can check if we have extreme values - also called "outliers" - in our dataset with a visual
# resource: the boxplot.

boxplot(hours) # Create a boxplot for the object "hours"

# Boxplots are helpful because they display crucial information for us. The whiskers show the highest
# and the lowest values in the dataset. They also give you the range, that is, the distance between
# those values. 

#The main section of the boxplot is the shaded box. The bottom line represents the first
# quartile of the dataset. It means that 25% of the values in the dataset are lower than it. For 
# example, if the first quartile was 4.5, we could affirm that 25% of the values were up to 4.5.

# The upper line of the box displays the third quartile, the measure that indicates that 75% of 
# the values are lower than it. Then, if this quartile is equaled to 4.5, we could say that 75% of 
# the values on our dataset are below it. 

# The thick red line in the shaded box is the median or the second quartile. It divides the ordered
# values (ascending or descending) of the dataset in the middle. A median of 4.5 means that 50% of
# the values are above it and the other 50% are below it. 

# Finally, the boxplot gives us information about outliers. The function boxplot() identifies them
# displaying empty circles above the higher whisker or below the lower whisker. As we can notice, in this
# example we do not have outliers in the object "hours".

# Let us repeat this procedure for the object "score".

boxplot(score) # Create a boxplot for the object "score"

# Once again, we do not have outliers.

# What if we had? The literature on data analysis indicates some alternatives for dealing with outliers:

# a) delete them if they do not represent more than 5% of the data into an object. For example, if
# we had an object with 100 cases, we could have up to 5 cases identified as outliers. In this situation,
# we could delete them. This alternative is usually known as "rule of thumb".

# b) run analyses with and without outliers and compare them. If you identify substantial discrepancies
# between the results, the outliers are biasing them. Try to follow the rule of thumb or make clear your
# analysis is based on biased data.

# c) change the method of analysis. There are many quantitative methods for dealing with outliers without
# deleting them from the dataset. This is an advanced topic that is beyond the scope of this course. But
# if you want to know something about it, you can download the paper I published on one of those methods:
# https://www.researchgate.net/publication/343556044_Cluster_Analysis_in_Practice_Dealing_With_Outliers_in_Managerial_Research 

# Step 3: run the model

# We have everything we need to run the regression model. We will use the function lm() for that:

model <- lm(score ~ hours) # The dependent variable (y) must come first.
summary(model) # This function displays the complete output.


# Step 4: interpret the output.

# 4.1) Interpret the p-value for the independent variable

# The p-value for hours is 2.25e-06 *** that is significantly less than 0.05. Therefore, it seems
# there is a statistically significant association between hours of study and scores. Notice that
# R Studio is displaying a triple * to the right. If we look at the line "Signif. codes", 
# we will see that this corresponds to <0.0 level of significance. This is a more
# powerful test than the one made with a 0.05 level.

# 4.2) Interpret the F-test

# The F-test results are in the bottom line. The null hypothesis (H0) is that at least one of the
# coefficients associated with the independent variable is different from 0 (zero).
# It shows us the overall significance of the regression model, that is, if the independent 
# variables are helpul for explaining the variation in the dependent variable. 
#Since the p-value is lower than 0.05, the model is statistically significant and hours 
# is deemed to be useful for explaining the variation in score.

# 4.3) Interpret the adjusted R squared

# The adjusted R squared is interpreted similarly to Pearson's r or Spearman's rho. In this
# example, R2 equals to 0.818. This means that 81,8% of the variation in scores (the dependent
# variable) can be explained by the variation in hours of study (the independent variable).

# The literature indicates there is no "ideal" value for R2. Generally, analysts consider the
# closer to 1 the better. However, a R2 equals to 1 indicates overfitting in the model. That
# is not a good situation because it means the variables might be redundant.

# 4.4) Interpret the residual standard error

# It is displayed in the line below the Signif. codes:
# Residual standard error: 3.641 on 13 degrees of freedom

# This is the average distance that the observed values fall from the regression line. 
# The lower this value, the more closely a regression line is able to match the observed data. 
# In this example, the average observed exam score falls only 3.641 points away from the score 
# predicted by the regression line.


# 4.5) Plot the residuals

# One of the assumptions of the simple linear regression is that the residuals (values not
# included in the estimated model) are randomly distributed.We can check that by using a 
# residuals vs. fitted values plot:


res <- resid(model) # Stores the residuals in the object res.
res # Call the object.

plot(fitted(model), res) + abline(0,0) # Create a plot with a line at 0.

# The plot indicates there is no recognizable pattern in the residuals. Then we can conclude
# that they are randomly distributed.


# 4.6.) Verify if the residuals follow a normal distribution

# The last assumption in the simple linear regression is that the residuals follow a normal
# distribution. We can verify this with a Q-Q plot:


qqnorm(res) + qqline(res) # Creates the Q-Q plot with a 45-degree line.

# In this plot the quantiles should be as close as possible to the 45-degree line. The ideal
# situation is to have all the quantiles positioned exactly in the line. In this example, we
# can notice that there are some relatively small deviations from this line. Therefore,
# we can assume that the residuals follow a normal distribution.

# Step 5: analyze the estimated model

# The estimated model met all the necessary assumptions in the simple linear regression analysis.
# Therefore, we can be confident in using it to understand the relationship between the hours of
# study for the final test and the scores:

# scores = 65.334 + 1.982(hours of study)

# Analysis:

# The estimated model indicates that each hour of study adds 1.982 points to the final exam scores.
# Besides, someone who have not studied for that exam would expect a score of 65.334.
