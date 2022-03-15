#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions III
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Input
#===========================================================

# Scoping rules in R; Where does R find stuff
# ...........................................
a <- 55
add_a <- function(x){
  return(x + a)
}
add_a(5)


# name masking
a <- 55
add_a <- function(x){
  a <- 5
  return(x + a)
}
add_a(5)


# where does R find stuff
a <- b <- c <- d <- "fourth"
find_object <- function(a, b = "third", c = "third"){
  a <- "first"
  return(c(a = a, b = b, c = c, d = d))
}
find_object(b = "second")


# BAD IDEA!
a <- 55
add_a <- function(x){
  return(x + a)
}
add_a(5)


# GOOD IDEA!
add_a <- function(x, a = 55){
  return(x + a)
}
add_a(5)


# BAD IDEA
a <- 55
change_a <- function(new_a){
  a <<- new_a
  return(invisible(NULL))
}
change_a(5)
a
?'<<-'



# dot-dot-dot
# ...........

# plot example
hist3 <- function(x, ...){
  hist(x, ...)
  abline(v = mean(x, ...), 
         col = "darkred", 
         lwd = 2)
}
hist3(airquality$Wind, col = "pink", 
      main = "Wind (mph)")

hist3(airquality$Wind, main = "Wind (mph)", freq = FALSE, 
      col = "skyblue", breaks = 30)


# apply example
get_quantiles <- function(x, ...){
  out <- lapply(x, quantile, ...)
  return(do.call(rbind, out))
}
get_quantiles(airquality, na.rm = TRUE, 
              probs = c(.25, .5, .27))

# spelling mistakes!
get_quantiles <- function(x, ...){
  out <- lapply(x, quantile, ...)
  return(do.call(rbind, out))
}
get_quantiles(airquality, na.rm = TRUE, 
              prosb = c(.25, .5, .27))


# on. exit
# ........
add_ten_on_exit <- function(x) {
  on.exit(cat("Finished 'add_ten_on_exit', with input '", 
              x, "'. \n", sep = ""))
  return(x + 10)
}
add_ten_on_exit(1)
add_ten_on_exit("one")


# useful to correct side effects
hist3(airquality$Ozone, main = "Wind (ppb)", freq = FALSE, 
      col = "pink", na.rm = TRUE)

hist3 <- function(x, ...){
  old_options <- getOption("warn")
  on.exit(options(warn = old_options))
  options(warn = -1)
  hist(x, ...)
  abline(v = mean(x, ...), 
         col = "darkred", lwd = 2)
  
}
hist3(airquality$Ozone, main = "Wind (ppb)", freq = FALSE, 
      col = "pink", na.rm = TRUE)
warnings()



# Functions are objects
# .....................
do_this_that <- function(function1, function2, x){
  function2(function1(x))
}
do_this_that(sum, log, 0:3)


# anonymous function
do_this_that(function(x) x^2, 
             function2 = function(y) sum(y) / (length(y - 1)), 
             -1:5)


# return a function
combine_2fun <- function(function_1, function_2){
  out_function <- function(x, ...) {
    function_2(function_1(x), ...)
  }
  return(out_function)
}

standardized_hist <- combine_2fun(scale, hist)
standardized_hist(airquality$Wind, 
                  col = "skyblue", 
                  main = "Standardized hist")


mean_abs_deviation <- combine_2fun(abs, mean)
mean_abs_deviation(airquality$Ozone, na.rm = TRUE)


normalize <- combine_2fun(
  function(x) {x - min(x, na.rm = TRUE)},
  function(x) {x / max(x, na.rm = TRUE)})
normalize(airquality$Ozone)[1:4]



# Exercises
#===========================================================
# 1. Consider the hist2() function from the previous solutions. Make use of 
#    the ... function to create a lot of flexibility. 
#    TIP: Some of the functions used in hist2 will also need to be changed.

# hist2(airquality$Ozone, col = "pink", 
#       main = "Ozone", lwd = 2, text_pos = 0.012)  should work




# 2. Write a function that plots a histogram for all variables in a data frame.
# TIP: use iteration.




# 3. Write a "center_by" function to center a variable by a specific value.
#    There should be two arguments: 
#    - variable = the variable to center
#    - by = either a numeric value to center by, or function that is applied 
#           to the variable to compute the numeric value to center by
#    Choose a sensible default for the by argument.

# center_by(1:3, by = 1) should result in 0  1  2
# center_by(1:3, by = mean) should result in -1  0  1 




# 4. Adjust the center_by function, so that it can ignore missing values
#    when the mean is computed
#    TIP: use ... and keep it simple

# center_by(airquality$Ozone, mean, na.rm = TRUE) should work




# 5. The center_by function does not behave as it should with the following code
#    Of course, the user made a mistake, but it would be nice to make sure this
#    error can avoided. Create a check so that the function can notify the
#    user.

# center_by(1:10, quantile, probs = c(.2, .8)) should notify the user of a 
#    potential problem




# 6. Adjust the function you wrote for exercise 2. Make sure that all histograms
#    are plot in one figure. You will have to change the par() settings 
#    using mfrow. Yet make sure that the par() settings are only changed 
#    when the function is used (i.e., that the settings are reset to what they)
#    were.
?par

#  hist_all(airquality, col = "pink", xlab = NULL) should result in a plot
#    with sex panels





# 7. Make a create_center_by function that returns a function which you can use
#    to center by. The create_center_by should have only a "by" argument, which
#    can be either a numerical value, or a function.

# center_by_min <- create_center_by(min) should create a function that centers 
#    using the minimum




