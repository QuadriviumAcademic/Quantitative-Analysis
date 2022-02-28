##############################################
# LIST OF EXERCISES 1
##############################################

#1) Multiply the odd numbers between 0 and 10.

#2) Raise the sum of 4 and 345 to the third power. Divide the output by 8.345.

#3) Calculate the ratio between 290 and 132 and add 34 to it. Then, 
# subtract from it the result of the multiplication between 123 and 67, 
# elevated to the fifth power.

#4) Raise this expression to the 0.5 power: (36 + 234) x (823 + 34).

#5) Calculate the square root of this expression: (123,45 - 3,971) / (32,546 x 0,00237).

#6) Compute the natural logarithm of this expression: (3,7789/0.05) - 1,4722.

#7) Calculate the logarithm to the base 10 of the expression in Question 6.

#8) Calculate the square root of the logarithm to the base 2 
# of this expression from Question 6:  (3,7789/0.05) - 1,4722.

#9) Calculate the square root of this expression: (78,904/0,001). Raise the result to the 10th power.

#10) Calculate the natural logarithm of this expression: (3.456/0.05). 
# Then, divide the output by the logarithm to the base 2 of 45.678.


#######################################################
#ANSWERS
#######################################################

#Question 1: Multiply the odd numbers between 0 and 10.

1 * 3 * 5 * 7 * 9


#Question 2: Raise the sum of 4 and 345 to the third power. Divide the output by 8.345.

((4 + 345) ^ 3) / 8.345 # or: ((4 + 345) ** 3) / 8.345


#Question 3: Calculate the ratio between 290 and 132 and add 34 to it. Then, 
# subtract from it the result of the multiplication between 123 and 67, 
# elevated to the fifth power.

((290 / 132) + 34) - ((123 * 67) ^ 5) # or: ((290 / 132) + 34) - ((123 * 67) ** 5)


# Question 4: Raise this expression to the 0.5 power: (36 + 234) x (823 + 34).

# x raised to the 0.5 power == x ^ 0.5 ==  x^ 1/2 = sqrt(x) 

sqrt((36 + 234) * (823 + 34))


#Question 5: Calculate the square root of this expression: (123,45 - 3,971) / (32,546 x 0,00237).

sqrt((123.45 - 3.971) / (32.546 * 0.00237))


#Question6: Compute the natural logarithm of this expression: (3,7789/0.05) - 1,4722.

log((3.7789 / 0.05) - 1.4722)


#Question7: Calculate the logarithm to the base 10 of the expression in Question 6.

log10((3.7789 / 0.05) - 1.4722)


#Question 8: Calculate the square root of the logarithm to the base 2 
# of this expression from Question 6:  (3,7789/0.05) - 1,4722.

sqrt(log2(((3.7789/0.05) - 1.4722)))


#Question 9: Calculate the square root of this expression: (78,904/0,001). 
# Raise the output to the 10th power. 

sqrt(78.904 / 0.001) ^ 10 

# or

sqrt(78.904 / 0.001) ** 10


# Question 10: Calculate the the natural logarithm of this expression: (3.456/0.05). 
# Then, divide the output by the logarithm to the base 2 of 45.678.

log(3.456 / 0.05) / log2(45.678)


