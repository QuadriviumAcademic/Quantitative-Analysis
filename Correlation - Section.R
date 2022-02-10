# Correlation analysis in R

###############################################
# Example 1: all variables are quantitative
###############################################

# In this case, we have to compute Pearson's r.
# To do that, we will use the online dataset "mtcars". 
# The data were extracted from the 1974 Motor Trend US magazine, 
# and comprise fuel consumption and 10 aspects of automobile design 
# and performance for 32 automobiles (1973-1974 models).


# How to display the data on "mtcars"

head(mtcars, 6) # The number 6 means that R Studio will display the six first lines only
?datasets::mtcars # This command will show you information about the dataset


# You can store "mtcars" on an object that works just like a box to put everything you want in.

my_data <- mtcars
my_data # This command displays everything you have stored in the object "my_data"
head(my_data, 10) # You can restrain data visualization by defining the number of lines
summary(my_data) # This function displays basic statistics about the dataset


# Suppose you want to check if the fuel consumption (mpg) and the horsepower (hp) are correlated.

# First, display both variables to decide if they are quantitative or qualitative.

str(my_data) # The str function displays the data type of each variable into a dataset


# Since mpg and hp are quantitative variables, you have to use Pearson's r to measure their correlation - if any

cor.test(my_data$mpg, my_data$hp, method = "pearson")


# You can also plot the output:

if(!require(ggpubr)) install.packages("ggpubr") # Installs the "ggpubr" package, if necessary
library(ggpubr) # Loads the "ggpubr" package

ggscatter(my_data, x = "mpg", y = "hp", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Miles/(US) gallon", ylab = "Horsepower (Gross horsepower)")


# Now suppose you want to test if the weight (wt) is correlated to fuel consumption (mpg)

# First, check the types of the variables

str(my_data$wt) # In this case, the str function displays the type of the selected variables only
str(my_data$mpg)


# Both variables are quantitative. Therefore you have to use Pearson's r.

cor.test(my_data$wt, my_data$mpg, method = "pearson")


# You can also plot the output:

if(!require(ggpubr)) install.packages("ggpubr") # Installs the "ggpubr" package, if necessary
library(ggpubr) # Loads the "ggpubr" package

ggscatter(my_data, x = "wt", y = "mpg", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Weight (1000 lbs)", ylab = "Miles/(US) gallon")


# What if you wanted to check if all variables in the dataset are correlated?
# In this case, you can compute a correlation matrix.

if(!require(Hmisc)) install.packages("Hmisc") # Installs the "Hmisc" package, if necessary
library(Hmisc) # Loads the "Hmisc" package

res <- cor(my_data) # Stores my_data correlation into a new object: res.
round(res, 2) # Fixes two decimals for all values in the dataset


# You can also create a correlogram to visualize the correlations:

if(!require(corrplot)) install.packages("corrplot") # Installs the "corrplot" package, if necessary
library(corrplot) # Loads the "corrplot" package

corrplot(res, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)


###############################################
# Example 2: all variables are qualitative
###############################################

# In this case, you should use Spearman's rho since the variables do not come
# from a normal distribution (they are qualitative).

# Creating a dataset with ordinal variables

satisfaction <- c(0, 3, 5, 6, 6, 6, 5, 5, 3, 2, 7, 8, 7, 8, 5) # Likert-type scale with 
# 0 = "Very unsatisfied" and 10 = "Very satisfied"
var_1

education <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4) # Level of education:
# 1 = Bachelor’s Degree; 2 = Master’s Degree, 3 = Doctorate Degree; 4 = Post Doctorate
var_2

data_rho = data.frame(satisfaction, education)
data_rho

# Computing the Spearman's rank correlation (rho)

cor.test(data_rho$var_1, data_rho$var_2, method = "spearman")
cor(data_rho$var_1, data_rho$var_2, method = "spearman") # Double-checks if rho was computed correctly


# Plots the output

ggscatter(data_rho, x = "satisfaction", y = "education", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "spearman",
          xlab = "Satisfaction (0 = Very Unsatisfied/ 10 = Very Satisfied)",
          ylab = "Level of Education (1 = Bachelor’s; 2 = Master’s, 3 = Doctorate; 4 = Post Doc)")


# Creates a correlation matrix

spearman_cor <- cor(data_rho) # Stores data_rho correlation into a new object: res.
round(spearman_cor, 2) # Fixes two decimals for all values in the dataset


# Since the correlation matrix for two variables is not very impressive, 
# the correlogram would have little to add to this output.

