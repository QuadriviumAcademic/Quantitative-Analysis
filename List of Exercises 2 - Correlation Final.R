# List of Exercises 2 - Correlation analysis


# 1) The general manager of a business firm wants to know if the number of employees 
# affects the productivity rate. He has collected the following data recently:

# Month          # Number of employees           # Productivity rate
# Jan                   17                              1.75
# Feb                   19                              1.78
# Mar                   25                              1.93
# Apr                   26                              1.99
# May                   26                              1.99
# Jun                   27                              2.04
# Jul                   29                              2.06
# Aug                   29                              2.07
# Sep                   32                              2.12
# Oct                   35                              2.14

# Answer this question using the appropriate correlation measure and interpreting the output.


#2) An investor wants to know if the prices of four assets are somehow related. To answer that,
# he collected the following data in the last 15 days:

# Day   # Price - Asset A     # Price - Asset B     Price - Asset C     Price - Asset D
# 1             3.95                    1.24            1.56                    1.76
# 2             3.12                    1.65            1.50                    1.32
# 3             3.01                    1.61            1.52                    1.46
# 4             3.23                    1.28            1.09                    1.19
# 5             2.91                    0.98            0.87                    0.71
# 6             3.03                    1.34            0.76                    0.56
# 7             2.99                    1.55            1.34                    0.50
# 8             2.83                    1.21            1.13                    0.74
# 9             2.85                    1.72            1.66                    1.03
# 10            2.88                    1.89            1.99                    1.33
# 11            2.76                    1.91            2.04                    1.41
# 12            2.80                    2.02            2.05                    1.61
# 13            2.87                    2.09            2.14                    1.86
# 14            2.91                    2.08            2.16                    1.94
# 15            2.93                    2.11            2.13                    1.92

# Compute the matrix of correlation and analyze the output.


# 3) The American Consumer Satisfaction Index (ACSI) is a relevant tool for measuring consumers'
# satisfaction with goods and services. It is a composite scale comprising six dimensions.
# Two of them are perceived quality and loyalty. The theory behind the ACSI states that the 
# higher the quality the consumer attributes to a product, the higher his or her loyalty to that product.

# The following fictional data represent the perceived quality and loyalty of a small sample of
# consumers. Use the correct correlation measure to analyze if the theoretical assumptions of the
# ACSI are empirically solid in this case. Both of the variables are measured with Likert-type
# scales with 11 categories ranging from 0 to 10.

# Consumer      # Perceived Quality     # Loyalty
#  1                    1                   4
#  2                    0                   4
#  3                    3                   6
#  4                    5                   5
#  5                    6                   6
#  6                    4                   7
#  7                    6                   3
#  8                    7                   4
#  9                    5                   6
# 10                    5                   5

# Based on those data, answer this question: could we affirm that the variables support the 
# theoretical assumption of the ACSI model?

####################################################
# ANSWERS - Remember that you have many alternatives
# in R Studio to answer the questions
####################################################

# 1) The general manager of a business firm wants to know if the number of employees 
# affects the productivity rate. He has collected the following data recently...

# Notice that we need to check if the employment rate and productivity are correlated.
# Therefore, we don't need to consider the variable "Month" in our analysis.

# Let's create an object to store the data on employment.

employment <- c(17, 19, 25, 26, 26, 27, 29, 29, 32, 35) # The function "c()" stores the data on the object.
employment # This command displays the data stored in the object.

# You can plot the data if you want:

plot(employment)

# Let's repeat the previous steps to create an object for productivity:

productivity <- c(1.75, 1.78, 1.93, 1.99, 1.99, 2.04, 2.06, 2.07, 2.12, 2.14)
productivity
plot(productivity)

# We have created the objects, and we are ready to test the correlation between the variables.
# The two variables are quantitative. Let's suppose they come from a normal distribution.
# Therefore, we can use Pearson's r to analyze the correlation. 

cor.test(employment, productivity, method = "pearson")

# We can plot this output.

# To do that, Let us first create the data frame "question_1" with the two variables.

question_1 <- data.frame(employment, productivity)
question_1

if(!require(ggpubr)) install.packages("ggpubr") # Installs the "ggpubr" package, if necessary
library(ggpubr) # Loads the "ggpubr" package

ggscatter(question_1, x = "employment", y = "productivity", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Number of Employees", ylab = "Productivity")


# Analysis:

# We have a Pearson's r of 0.978, indicating that the variables are strongly
# correlated since this value is closer to 1. Besides, that correlation is
# direct, meaning that the higher the number of employees, the higher the productivity.

# The Pearson's r is statistically significant. The p-value is lower than the
# significance level of 5% (0.05), and this rejects the null hypothesis that
# the true correlation is equal to 0. 

# Finally, the 95% confidence interval ranges from 0.909 to 0.995. The interpretation
# for that is: if repeated samples of the same size were extracted from the same
# population, in 95% of the cases, the true Pearson's r would be in the interval
# from 0.909 to 0.995.

# Please, if you are not confident with interpreting the hypothesis tests, I recommend you
# study this subject matter in a book of introductory statistics. Since this is a course
# for master's students, I am considering they have already studied this subject matter
# during their undergraduate course.

########################################################################

#2) An investor wants to know if the prices of four assets are somehow related. To answer that,
# he collected the following data in the last 15 days...

# We will create objects to store the data. Please notice that we do not need to input the data
# displayed in the column "Days". However, this time we will do that to show you how to use the
# helpful function "seq()".

days <- seq(1, 15) # We could input the data with the function "c()", as we did previously.
# But the column "Days" comprises an ascending sequence of numbers ranging from 1 to 15.
# In this case, the function seq() is more helpful for our purposes.

days # Let's check if we have inputted the data correctly.

asset_a <- c(3.95, 3.12, 3.01, 3.23, 2.91, 3.03, 2.99, 2.83, 2.85, 2.88, 2.76, 2.80,
             2.87, 2.91, 2.93) # Stores the data in the object.
asset_a # Displays the data inputted in the object.
str(asset_a) # Displays the structure of the object.
plot(asset_a) # Plots the data.

asset_b <- c(1.24, 1.65, 1.61, 1.28, 0.98, 1.34, 1.55, 1.21, 1.72, 1.89, 1.91, 2.02,
             2.09, 2.08, 2.11)
asset_b
str(asset_b)
plot(asset_b)

asset_c <- c(1.56, 1.50, 1.52, 1.09, 0.87, 0.76, 1.34, 1.13, 1.66, 1.99, 2.04, 2.05,
             2.14, 2.16, 2.13)
asset_c
str(asset_c)
plot(asset_c)

asset_d <- c(1.76, 1.32, 1.46, 1.19, 0.71, 0.56, 0.50, 0.74, 1.03, 1.33, 1.41, 1.61,
             1.86, 1.94, 1.92)
asset_d
str(asset_d)
plot(asset_d)


# Creating the matrix of correlations

if(!require(Hmisc)) install.packages("Hmisc") # Installs the "Hmisc" package, if necessary
library(Hmisc) # Loads the "Hmisc" package

# Joining the variables we want to analyze into a data frame.

assets <- data.frame(asset_a, asset_b, asset_c, asset_d)
assets
str(assets)

assets_cor <- cor(assets) # Stores assets correlation into a new object.
round(assets_cor, 2) # Fixes two decimals for all values in the dataset

# What about the p-values? They are relevant for identifying statistically significant measures.
# You can add p-values to a matrix of correlations by typing the commands:

assets_values <- rcorr(as.matrix(assets))
assets_values

# You can also create a correlogram to visualize the correlations:

if(!require(corrplot)) install.packages("corrplot") # Installs the "corrplot" package, if necessary
library(corrplot) # Loads the "corrplot" package

corrplot(assets_cor, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)

# Analysis:

# The p-values associated with each Pearson's r indicate that Asset B is positively correlated with
# assets C (strong) and D (not so strong). Asset C is also positively and strongly correlated with
# Asset D.

# The other paired correlations were not statistically significant. The p-values were higher than 0.05
# that represents a level of significance of 5%. In those cases, we do not reject the null hypothesis 
# that the true correlation is equal to 0 (zero). Therefore, we do not have empirical evidence to accept
# those correlations.

###################################################################

# 3) The American Consumer Satisfaction Index (ACSI) is a relevant tool for measuring consumers'
# satisfaction with goods and services...

# The first step is to input data into objects.

quality <- c(1, 0, 3, 5, 6, 4, 6, 7, 5, 5)
quality

loyalty <- c(4, 4, 6, 5, 6, 7, 3 , 4, 6, 5)
loyalty

# Let us check how R Studio is treating our data:

str(quality)
str(loyalty)

# Notice that we have a tricky situation here: the str function tells us that the objects store 
# numerical data. An inexperienced data analyst might conclude that we are dealing with quantitative
# variables and, therefore, we could use Pearson's r - since the data came from a normal distribution.
# However, the question states that the variables were measured by Likert-type scales. We have learned
# that those scales are ordinal and, therefore, consistent with qualitative variables only. In short,
# although the str function informs us that we have numerical data on the objects - and this is correct
# in a strict sense - we must consider that those numbers represent codes, not mathematical relations
# among the values. Hence, we can not use Pearson's r in this case. The computation must use the
# Spearman's rho instead.

# To compute the Spearman's rho we need to type the following sequence of commands:

cor.test(quality, loyalty, method = "spearman")

# At first sight, the output indicates we have an inverse and weak relationship between the perceived
# quality and loyalty. Then, we should conclude that our empirical data do not support the ACSI assumption
# that those variables are positively correlated.

# However, we need to consider the t test to be sure about that. The p-value is 0.754, higher than
# the significance level of 0.05 (5%). Hence, we can not reject the null hypothesis that the true rho
# is different from 0 (zero). In this case, we do not have empirical evidence to support our prior 
# interpretation of Spearman's rho. Then, we must conclude that we can not affirm that the 
# perceived quality and loyalty are correlated considering our empirical data.

# This conclusion points out two essential aspects. First, we must not affirm that the ACSI model
# does not have empirical support. Remember we have used our empirical data only, and this is too litlle
# to sustain such a strong statement. 

# Second, many students feel insecure when they do not confirm theoretical statements empirically. 
# However, remember that the primary purpose of good research is to verify if those statements could
# be sustained by empirical data. Therefore, even if your output indicates that our data have not
# behaved the way you expected, you might be dealing with relevant results for advancing the knowledge
# on a subject matter.

# Please, always consider that researchers are not trying to prove they are right. Instead, they
# are committed to seeking the truth. (Yes, do not get fooled by those who affirm that the truth
# does not exist because everything is relative. If you think a bit of that, you will conclude
# this statement is flawed because it contradicts itself.)