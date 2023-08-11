#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions I
# 
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




# function components (formals, body, environment)
add_ten <- function(x) {
  x + 10
}
add_ten(2)
formals(add_ten)
body(add_ten)

# help pages
?mean



# arguments have to be of a specific object type
sum(c("a", "b", "c")) # gives an error



# Default arguments
#...........................

# no defaults
countNA <- function(x, percent) {
  out <- sum(is.na(x))
  if(percent) out <- out/length(x)
  out
}
x <- c(1, 5, NA, 3)
countNA(x = x)           # percent argument is missing



# with default
countNA <- function(x, percent = FALSE) {
  out <- sum(is.na(x))
  if(percent) out <- out/length(x)
  out
}
x <- c(1, 5, NA, 3)
countNA(x = x)           # percent argument is missing



# Return object
#...........................

# return stops the computation within the function
return_early <- function(x, early) {
  x2 <- x*2
  if(early) (return(x2))
  out <- x + x2 # not executed
  out
}
return_early(2, early = TRUE)
return_early(2, early = FALSE)


# multiple objects can be combined in a list
get_info <- function(x){
  mean_x <- mean(x)
  median_x <- median(x)
  n_obs_x <- length(x)
  range_x <- range(x)
  return(list(mean = mean_x, median = median_x, 
              n_obs = n_obs_x, range = range_x))
}

get_info(airquality$Wind)

get_info(airquality$Wind)






# Exercises
#===========================================================
# 1. Write a function with one argument that returns the input times 3 + 1 
#    (3x + 1).





# 2. Write a function with two arguments that returns the sum of the two 
#    arguments divided by 10 as the following character string: 
#    "A tenth of the sum of <first argument> and <second argument> 
#    equals <value>."
#    TIP: use the paste() or paste0() function
?paste()





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
#    Test your function with the iris data.
data(iris)
?prop.table






