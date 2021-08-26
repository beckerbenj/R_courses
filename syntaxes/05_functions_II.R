# Advanced R
# Spring Academy FDZ, March 2021

# Functions II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
pisa_file <- file.path(dirname(getwd()), "data/pisaPlus_CF.RDS")
pisa <- readRDS(pisa_file)

# Input
#===========================================================
#...........................

# Default arguments
#...........................
add_things_def <- function(x = 10) {
  x + 10
}

add_things_def()
add_things_def(1)

mean2 <- function(x, na.rm = TRUE, ...) {
  mean(x, na.rm = na.rm, ...)
}

a <- c(5, 3, NA, 6)
mean(a)
mean2(a)
?mean


#...........................

# Non standard output
#...........................
# Early returns
mean_alt <- function(x, na.rm = FALSE) {
  if(!na.rm & any(is.na(x))){
    return(NA)
  } 
  sum(x, na.rm = TRUE)/length(x)
}
mean_alt(a)
mean_alt(1:5)

mean_alt(a, na.rm = TRUE)

##
mean4 <- function(x, na.rm = FALSE) {
  if(na.rm){
    x <- x[!is.na(x)]
  } 
  if(length(x) == 0) return(NA)
  sum(x)/length(x)
}

mean4(numeric())
mean(numeric())


### Errors, warnings etc.
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


## Alternatives
?stopifnot



# Exercises
#===========================================================
# 1. Write a function the takes a numeric variable as input and creates a boxplot as output. 
# How does R provide default values for the main title and axis labels. Would you choose the same?
# Give sensible default values to assign main title and axis labels.

create_boxplot <- function(x, main = "Boxplot", xlab = NULL, ylab = "Values") {
  boxplot(x, main = main, xlab = xlab, ylab = ylab)
}
create_boxplot(mtcars$mpg)
boxplot(mtcars$mpg)

# 2. Implement 'input checks' for your boxplot function. The function should throw an error, if the input is not a single numeric vector.
# If the vector contains missing values, the function should throw a warning.

# 3. Write a function that creates either a histogram or a bar chart for a variable, depending on the input 
# (chracater/factor -> bar chart; numeric -> histogram)

