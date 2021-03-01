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
# 1. Write a simple function that computes the sum of two numeric values.
compute_sum <- function(x, y) {
  x + y
}

# 2. Implement input checks/validation for your function.
compute_sum <- function(x, y) {
  if(!is.numeric(x) || length(x) != 1) stop("'x' must be a numeric vector of length 1.")
  if(!is.numeric(y) || length(y) != 1) stop("'y' must be a numeric vector of length 1.")
  x + y
}


# 3. Write a function that outputs three distributional graphs for two metric variables:
# a univariate boxplot for each of the variables and a bivariate scatterplot. Apply it to the following
# variables in the PISA data set: hisei, pared.
pisa <- readRDS("C:/Users/benjb/Documents/Repositories/R_courses/data/pisaPlus_CF.RDS")
pisa <- readRDS("C:/Benjamin_Becker/02_Repositories/workshops//R_courses/data/pisaPlus_CF.RDS")

par(mfrow = c(1, 3))
boxplot(pisa$hisei)
boxplot(pisa$pared)
plot(pisa$hisei, pisa$pared)

plot_2vars <- function(x, y) {
  par(mfrow = c(1, 3))
  boxplot(x)
  boxplot(y)
  plot(x, y)
  NULL
}
plot_2vars(pisa$hisei, pisa$pared)

# 4. Enable the user to label and title the plots via arguments.
plot_2vars2 <- function(x, y, x_name, y_name) {
  par(mfrow = c(1, 3))
  boxplot(x, main = x_name)
  boxplot(y, main = y_name)
  plot(x, y, xlab = x_name, ylab = y_name, main = "Scatterplot")
  NULL
}
plot_2vars2(pisa$hisei, pisa$pared, x_name = "HISEI", y_name = "PARED")

<<<<<<< HEAD

=======
>>>>>>> 7d53acbcdc6c069ae6e9ed80e2dd6e1584e96f73
# 5. If one of the variables is dichotomous, the function should return a single bivariate boxplot (instead of three plots). 
# Modify it.
plot_2vars3 <- function(x, y, x_name, y_name) {
  par(mfrow = c(1, 1))
  if(length(unique(x)) == 2) {
    boxplot(y ~ x, xlab = x_name, ylab = y_name)
    return()
  }
  if(length(unique(y)) == 2) {
    boxplot(x ~ y, xlab = y_name, ylab = x_name)
    return()
  }
  par(mfrow = c(1, 3))
  boxplot(x, main = x_name)
  boxplot(y, main = y_name)
  plot(x, y, xlab = x_name, ylab = y_name)
  NULL
}
plot_2vars3(pisa$hisei, pisa$pared, x_name = "HISEI", y_name = "PARED")
plot_2vars3(pisa$hisei, pisa$gender, x_name = "HISEI", y_name = "Gender")
plot_2vars3(pisa$gender, pisa$hisei, x_name = "Gender", y_name = "HISEI")






