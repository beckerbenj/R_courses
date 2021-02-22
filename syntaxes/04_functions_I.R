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
environment(add_things)
library(lavaan)
environment(sem)

# help pages
?mean


#...........................

# Formals/Arguments
#...........................
### Usual arguments (R as a tool for data science)
# a) Data input (vector, data.frame etc.)
# b) Options
?mean
?lavaan::sem

# default arguments
add_things_def <- function(x = 1) {
  x + 10
}
add_things_def()


#...........................

# Environments
#...........................
environment()
simple_fun <- function(){
  environment()
}
simple_fun()

# functions create their own environments!

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
  if(length(x) == 0) stop("'x' is way too short to calculate a mean!")
  if(length(x) == 1) warning("'x' is too short to calculate a mean!")
  sum(x)/length(x)
}

mean3(numeric())
mean3(2)


# Early returns
mean4 <- function(x, na.rm = FALSE) {
  if(na.rm){
    x <- x[!is.na(x)]
  } 
  if(length(x) == 0) return(NA)
  sum(x)/length(x)
}

mean4(numeric())
mean(numeric())

## Alternatives
?stopifnot



# Exercises
#===========================================================
# 1. Write a function that computes the sum of two numeric values

# 2. Implement input checks/validation for your function











