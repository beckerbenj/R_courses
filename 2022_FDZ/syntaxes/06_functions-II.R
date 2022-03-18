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
  m_sq_diff <- mean(diff)
  RMSE <- sqrt(m_sq_diff)
  return(RMSE)
}

# compare
RMSE <- get_RMSE(predictions, observations)

# without a function
diff <- observations - predictions
sq_diff <- diff^2
m_sq_diff <- mean(diff)
RMSE <- sqrt(m_sq_diff)



# with a function
summary(mtcars$mpg)

# without a function
round(c("Min." = min(mtcars$mpg),
        "1st Qu." = as.numeric(quantile(mtcars$mpg)[2]),
        "Median" = median(mtcars$mpg),
        "Mean" = mean(mtcars$mpg),
        "3rd Qu." = as.numeric(quantile(mtcars$mpg)[4]),
        "Max." = max(mtcars$mpg)), 2)




# return object is list
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

# pipable histogram
hist_pipe <- function(x) {
  hist(x)
  invisible(x)
}
hist_pipe(airquality$Wind) |> get_info()




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




# dot-dot-dot
# ...........


# Unknon number of arguments
# using a for loop
is_character <- function(...){
  input <- list(...)
  out <- input
  for(ell_nr in seq_along(out)){
    out[[ell_nr]] <- is.character(out[[ell_nr]])
  }
  out
}
is_character(a = "Awesome", b = 5, "Yes")

# using lapply
is_character <- function(...){
  lapply(list(...), is.character)
}
is_character(a = "Awesome", b = 5, "Yes")



# passing arguments to other function
# apply example
?apply
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




# Exercises
#===========================================================


# 1. Write a function that computes the following statistics for a numeric 
#    vector: (1) the sum of NAs, (2) the median, (3) the number of unique values.
#    include a second argument na.rm with default TRUE, to make sure that 
#    the median is computed (without NA values).
#    test your function using the mtcars data.


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
get_info(airquality$Ozone, message = TRUE)
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
