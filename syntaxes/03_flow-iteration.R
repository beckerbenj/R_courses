# Advanced R
# Spring Academy FDZ, March 2021

# R flow & iteration
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
# 1. Create an object and add some attributes. Write some code that checks whether the object has and attribute called "date". If no, the code should automatically add a "date" attribute to the object with today's date as its value (?Sys.Date). If the object already has a "date" attribute, than make sure the attribute is of "Date".

my_object <- structure(list(string = c("these", "are", "some", "words"), 
                            numbers = c(-10:10)), 
                       first_attribute = "irrelevant for this exercise", 
                       date = "1992-09-14")

if(is.null(attr(my_object, "date"))) {
  attr(my_object, "date") <- Sys.Date()
} 

if(!inherits(attr(my_object, "date"), "Date")) {
  attr(my_object, "date") <- as.Date(attr(my_object, "date"))
}


# 2. switch




# 3. rewrite the following for loop using 
#  a) while
#  b) repeat
#  c) a functional

pisaPlus_CF$new <- NA
for (rowNr in seq_len(dim(pisaPlus_CF)[1])){
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
}

# using while
pisaPlus_CF$new <- NA
rowNr <- 0
while (rowNr < dim(pisaPlus_CF)[1]){
  rowNr <- rowNr + 1
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
}

# using repeat
pisaPlus_CF$new <- NA
rowNr <- 0
repeat {
  rowNr <- rowNr + 1
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
  if(rowNr == dim(pisaPlus_CF)[1]) break
}

# using sapply
pisaPlus_CF$new <- sapply(seq_len(dim(pisaPlus_CF)[1]), function(rowNr){
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
})

# using vapply
pisaPlus_CF$new <- vapply(seq_len(dim(pisaPlus_CF)[1]), function(rowNr){
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
}, FUN.VALUE = double(1))

# using lapply
pisaPlus_CF$new <- do.call(c, lapply(seq_len(dim(pisaPlus_CF)[1]), function(rowNr){
  if(pisaPlus_CF$age[rowNr] > 15) {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] - pisaPlus_CF$pared[rowNr]/10
  } else {
    pisaPlus_CF$new[rowNr] <- pisaPlus_CF$hisei[rowNr] + pisaPlus_CF$pared[rowNr]/5
  }
}))

# 4. Write a function based on the code from exercise 1. Use todays date as the default, but let users have the option to specify the date. Don't forget to return the object.

my_object <- structure(list(string = c("these", "are", "some", "words"), 
                            numbers = c(-10:10)), 
                       first_attribute = "irrelevant for this exercise", 
                       date = "1992-09-14")

add_date <- function(object, date = Sys.Date()){
  if(is.null(attr(object, "date"))) {
    attr(object, "date") <- date
  } 
  
  if(!inherits(attr(object, "date"), "Date")) {
    attr(object, "date") <- as.Date(attr(object, "date"))
  }
  object
}

add_date(5)
add_date(my_object)











