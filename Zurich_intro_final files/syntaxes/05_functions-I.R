# Introduction to Programming in R
# Zurich R Courses, October 2021

# Functions I
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# Basics
#...........................
# Definition of a function:
countNA <- function(x) {    # Name = countNA, 1 Argument = x
  out <- sum(is.na(x))      # Body
  out                       # Output
}
b <- c(NA, 1, 4, NA, 3)
countNA(b)

# Inspecting the function ('source code')
countNA

# a function with one argument
get_log_xtox <- function(x) {
  x_x <- x^x
  out <- log(x_x)
  out
}
get_log_xtox(2)

# functions are objects too!
mean(1:10)
my_own_mean_fun <- mean
my_own_mean_fun(1:10)

# existing functions
ncol
dim # Primitive functions
mvtnorm::rmvnorm # from packages
haven:::add_text
mean # S3 methods

# anonymous functions

# function components (formals, body, environment)
add_ten <- function(x) {
  x + 10
}
add_ten(2)
formals(add_ten)
body(add_ten)

# help pages
?mean





# Exercises
#===========================================================
# 1. Write a function with one argument that returns the input times 3 + 1 
#    (3x + 1).





# 2. Write a function with two arguments that returns the sum of two 
#    arguments divided by 10 as the following character string: 
#    "A tenth of the sum of <first argument> and <second argument> 
#    equals <value>."





# 3. Write a function with one argument that returns a vector with NA values 
#    removed. TIP: use is.na()
?is.na




# 4. Write a function with two arguments that returns the first argument (a vector)
#    with the values in the second argument removed. 
#    Make sure the function works when the second argument contains multiple values
# TIP: use %in%
?`%in%`





# 5. Write a function that takes a vector and creates a relative frequency table 
#    (output in percentage!). TIP: the function prop.table() can help. 
#    Test you function with the iris data

data(iris)
?prop.table



# 6. Write a function with one argument that returns a vector with NA values 
#    removed. Add the following attributes to the return object:
#       - original_length = the length of the original vector
#       - which_NA = a vector with the indices of the NA values in the 
#                    original vector



# 7. Write a function that allows you to restore the original variable based on 
#    the return object form the function you wrote in exercise 6


