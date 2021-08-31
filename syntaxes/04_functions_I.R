# Advanced R
# Spring Academy FDZ, March 2021

# Functions I
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# Basics
#...........................
# Definition of a function:
countNA <- function(x) {    # Name, Arguments
  out <- sum(is.na(x))      # Body
  out                       # Output
}
b <- c(NA, 1, 4, NA, 3)
countNA(b)

# Inspecting the function ('source code')
countNA

# functions are objects too!
mean(1:10)
my_own_mean_fun <- mean
my_own_mean_fun(1:10)

# existing functions
ncol
dim # Primitive functions
lavaan::sem # from packages
haven:::add_text
mean # S3 methods
lme4::getL # S4 methods
# anonymous functions

# function components (formals, body, environment)
add_things <- function(x) {
  x + 10
}
add_things(2)
formals(add_things)
body(add_things)

# help pages
?mean





# Exercises
#===========================================================
# 1. Write a simple function that computes the sum of two numeric values.
computeSum <- function(x, y) {
  x + y
}
computeSum(5, 2)


# 2. Write a function that computes the following statistics given a numeric vector: (1) sum of NAs, (2) median, (3) number of distinct unique values.
computeDescriptives <- function(x) {
  c(sumNAs = sum(is.na(x)),
    median = median(x, na.rm = TRUE),
    uniqueValues = length(unique(x)))
}
computeDescriptives(mtcars$mpg)

# 3. Write a function that takes a vector and creates a relative frequency table (output in percentage). Use the function prop.table() to achieve this.
computeRelFreq <- function(x) {
  prop.table(table(x)) * 100
}
computeRelFreq(iris$Species)
