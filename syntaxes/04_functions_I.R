# Advanced R
# Spring Academy FDZ, March 2021

# Functions I
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# Basics
#...........................

# functions are objects too!
mean(1:10)
my_own_mean_fun <- mean
my_own_mean_fun(1:10)

# existing functions
ncol
dim # Primitive functions

# function components (formals, body, environment)
add_things <- function(x) {
  x + 10
}
add_things(2)

# help pages
?mean

# default arguments
add_things_def <- function(x = 1) {
  x + 10
}
add_things_def()

#...........................

# Scoping
#...........................

# where does R find things?

add_things2 <- function(x) {
  x + 10 + y
}

add_things2(2)
y <- 100

add_things2(2)


#...........................

# Lazy Evaluation
#...........................
add_things3 <- function(x, y) {
  x + 10
}
add_things3(2)


#...........................

# If statements
#...........................

mean2 <- function(x, na.rm = FALSE) {
  if (na.rm){
    x <- x[!is.na(x)]
  } 
  sum(x)/length(x)
}

# Errors, warnings etc.
mean3 <- function(x, na.rm = FALSE) {
  if(na.rm){
    x <- x[!is.na(x)]
  } 
  if(length(x) == 1) stop("'x' is too short to calculate a mean!")
  sum(x)/length(x)
}

mean3(2)


# Errors, warnings etc.
mean4 <- function(x, na.rm = FALSE) {
  if(na.rm){
    x <- x[!is.na(x)]
  } 
  if(length(x) == 1) stop("'x' is too short to calculate a mean!")
  if(length(x) == 0) return(0)
  sum(x)/length(x)
}

mean4(2)

## Alternatives
?stopifnot


#...........................

# Writing your own function
#...........................
## Before
# What should my function do?
# Input, output

## Process
# Write function
# Test it
# Add input validation
# Document it


# Exercises
#===========================================================
# 1. Write a function that computes the sum of two numeric values

# 2. Implement input checks/validation for your function











