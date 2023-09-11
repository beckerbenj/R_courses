#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions II
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::





# Input
#===========================================================
#...........................
set.seed(524)
observations <- rnorm(10)
predictions <- rnorm(10)

# with a function
get_RMSE <- function(predictions, observations){
  diff <- observations - predictions
  sq_diff <- diff^2
  m_sq_diff <- mean(sq_diff)
  RMSE <- sqrt(m_sq_diff)
  return(RMSE)
}

# compare
RMSE <- get_RMSE(predictions, observations)

# without a function
diff <- observations - predictions
sq_diff <- diff^2
m_sq_diff <- mean(sq_diff)
RMSE <- sqrt(m_sq_diff)




## For a second model
set.seed(925)
obs <- rnorm(10)
preds <- rnorm(10)


# without function
diff2 <- obs - preds
sq_diff2 <- diff2^2
m_sq_diff2 <- mean(sq_diff)
RMSE2 <- sqrt(m_sq_diff2)


# with function
RMSE2 <- get_RMSE(preds, obs)


# remember the get_info() function
get_info <- function(x){
  mean_x <- mean(x)
  median_x <- median(x)
  n_obs_x <- length(x)
  range_x <- range(x)
  return(list(mean = mean_x, median = median_x, 
              n_obs = n_obs_x, range = range_x))
}

get_info(airquality$Wind)



# Side effects
#...........................
print_info <- function(x){
  info <- get_info(x)
  cat("There are ", info$n_obs, 
      " observed values. \nThe mean is ", 
      round(info$mean, 2), ". \nThe median is ", 
      round(info$median, 2), ". \n", sep = "")
# invisible(info)  
}

print_info(airquality$Wind)
test <- print_info(airquality$Wind)
test



# plot
hist2 <- function(x, title){
  info <- get_info(x)
  mean_median <- as.numeric(info[c("mean", "median")])
  hist(x, 
       main = paste0(title, " (n = ", info$n_obs, ")"),
       col = "skyblue", 
       freq = FALSE)
  abline(v = mean_median, 
         col = c("darkred", "darkblue"), 
         lwd = 2)
  text(mean_median, 
       y = c(.1, .09),
       labels = paste(c("Mean", "Median"), 
                      round(mean_median, 2), 
                      sep = " = "),
       col = c("darkred", "darkblue"),
       pos = 4)
}

hist2(airquality$Wind, "Wind")





# Errors, warnings etc.
# ..........................
# Errors
?stop
get_log_xtox <- function(x) {
  if(!is.numeric(x)) stop("This does not work!")
  x_x <- x^x
  return(log(x_x))
}
get_log_xtox(2)
get_log_xtox("a")



# stopifnot()
?stopifnot
get_log_xtox <- function(x) {
  stopifnot(is.numeric(x)) 
  x_x <- x^x
  return(log(x_x))
}
get_log_xtox("a")



# message
?message
get_log_xtox <- function(x) {
  x_x <- x^x
  message("Thank you for using this function!")
  return(log(x_x))
}
get_log_xtox(2)


# Warning
?warning
get_log_xtox <- function(x) {
  if(x < 0 && (x %% 2 == 0)) 
    warning("Not sure you can trust the result.", 
            call. = FALSE)
  x_x <- x^x
  return(log(x_x))
}
get_log_xtox(-2)



# Scoping rules in R; Where does R find stuff
# ...........................................
a <- 55
add_a <- function(x){
  return(x + a)
}
add_a(5)
# BAD IDEA!



# name masking
a <- 55
add_a <- function(x){
  a <- 5
  return(x + a)
}
add_a(5)



# GOOD IDEA!
add_a <- function(x, a = 55){
  return(x + a)
}
add_a(5)


a <- b <- c <- d <- "fourth"
find_object <- function(a, b = "third", c = "third"){
  a <- "first"
  return(c(a = a, b = b, c = c, d = d))
}
find_object(b = "second")



# dot-dot-dot
# ...........
# Unknown number of arguments
# using a for loop
is_character <- function(...){
  input <- list(...)
  out <- logical(length(input))
  for(ell_nr in seq_along(input)){
    out[ell_nr] <- is.character(input[[ell_nr]])
  }
  names(out) <- names(input)
  out
}
is_character(a = "Awesome", b = 5, new = "YES")



# passing arguments to other function
# apply example
?apply
get_quantiles <- function(x, ...){
  if(is.null(dim(x))) return(quantile(x, ...))
  apply(x, 2, quantile, ...)
}
get_quantiles(airquality, na.rm = TRUE, 
              probs = c(.2, .8))


# spelling mistakes!
get_quantiles(airquality, na.rm = TRUE, 
              prosb = c(.2, .8))




# Exercises
#===========================================================


# 1. Write a function that computes the following statistics for a numeric 
#    vector: (1) the sum of NAs, (2) the median, (3) the number of unique values.
#    include a second argument na.rm with default TRUE, to make sure that 
#    the median is computed (without NA values).
#    test your function using the mtcars data.
#    TIP: you can use unique() and length().
?unique
?length

data("mtcars")
computeDescriptives(mtcars$mpg)


# 2. Consider the drop_NA()-function from the previous exercises.
#    Add a side-effect to the function: inform the user of
#    how many NA values were dropped. 
#    Add a "message" argument with default FALSE, so that 
#    users can also choose whether to get the information.
Ozone_noNA <- drop_NA(airquality$Ozone) 
Ozone_noNA <- drop_NA(airquality$Ozone, message = FALSE) 



# 3. Consider the get_info()-function from above. Include
#    a "na.rm" argument with a sensible default. 
#    when na.rm = TRUE, the function should:
#       - remove NA values before computing the statistics
#       - inform the user how many NA values were removed
#       - make sure users can choose not to get this information
#    TIP: make use of the function you wrote for exercise 2.

# original get_info() function
get_info <- function(x){
  mean_x <- mean(x)
  median_x <- median(x)
  n_obs_x <- length(x)
  range_x <- range(x)
  return(list(mean = mean_x, median = median_x, 
              n_obs = n_obs_x, range = range_x))
}

get_info(airquality$Ozone)
get_info(airquality$Ozone, verbose = TRUE)
get_info(airquality$Ozone, na.rm = FALSE)




# 4. Write a function that takes a numeric variable as input and creates a 
#    boxplot as output. How does R provide default values for the main 
#    title and axis labels. Would you choose the same?
#    Give sensible default values to the main title and axis labels.
create_boxplot(mtcars$mpg)



# 5. Implement 'input checks' for your boxplot function. The function should throw
#    an error, if the input is not a single numeric vector.
#    If the vector contains missing values, the function should throw a warning.
create_boxplot2(mtcars$mpg)
create_boxplot2(mtcars)
create_boxplot2(c(mtcars$mpg, NA))



# 6. Write a function that creates either a histogram or a bar chart for a 
#    variable, depending on the input:
#      + character/factor -> bar chart using table()
#      + numeric -> histogram
create_graph(1:5)
create_graph(c("a", "b", "c"))
create_graph(mtcars$mpg)
create_graph(iris$Species)
