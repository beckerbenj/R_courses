#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions III
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Exercises
#===========================================================
# 1. Consider the hist2() function from the previous solutions. Make use of 
#    the ... function to create a lot of flexibility. 
#    TIP: Some of the functions used in hist2 will also need to be changed.


# hist2(airquality$Ozone, col = "pink", 
#       main = "Ozone", lwd = 2, text_pos = 0.012)  should work


drop_NA <- function(x, message = TRUE){
  is_NA <- is.na(x)
  if(message) message(sum(is_NA), " NA-values were dropped.")
  out <- structure(x[!is_NA], 
                   original_length = length(x),
                   which_NA = which(is_NA))
}

get_info <- function(x, na.rm = TRUE, message = FALSE){
  if(na.rm) x <- drop_NA(x, message = message)
  mean_x <- mean(x)
  median_x <- median(x)
  n_obs_x <- length(x)
  range_x <- range(x)
  return(list(mean = mean_x, median = median_x, 
              n_obs = n_obs_x, range = range_x))
}

hist2 <- function(x, text_pos = .01, ...){
  info <- get_info(x)
  mean_median <- as.numeric(info[c("mean", "median")])
  hist(x, freq = FALSE, ...)
  abline(v = mean_median, 
         col = c("darkred", "darkblue"))
  text(mean_median, 
       y = c(text_pos, text_pos * 1.1),
       labels = paste(c("Mean", "Median"), 
                      round(mean_median, 2), 
                      sep = " = "),
       col = c("darkred", "darkblue"),
       pos = 4)
}

hist2(airquality$Ozone, col = "pink", 
      main = "Ozone", lwd = 2, text_pos = 0.012)



# 2. Write a function that plots a histogram for all variables in a data frame.
# TIP: use iteration.
hist_all <- function(data, ...){
  lapply(data, hist2, ...)
  return(invisible(data))
}

hist_all(airquality, col = "skyblue")


hist_all <- function(data, ...){
  for(colNr in seq_along(data)){
    hist2(data[[colNr]], main = names(data)[colNr], ...)
  }
  return(invisible(data))
}

hist_all(airquality, col = "skyblue")

# 3. Write a "center_by" function to center a variable by a specific value.
#    There should be two arguments: 
#    - variable = the variable to center
#    - by = either a numeric value to center by, or function that is applied 
#           to the variable to compute the numeric value to center by
#    Choose a sensible default for the by argument.

# center_by(1:3, by = 1) should result in 0  1  2
# center_by(1:3, by = mean) should result in -1  0  1 

center_by <- function(variable, by = mean){
  if(is.function(by)) by <- by(variable)
  out <- variable - by
  return(out)
}


# 4. Adjust the center_by function, so that it can ignore missing values
#    when the mean is computed
#    TIP: use ... and keep it simple

# center_by(airquality$Ozone, mean, na.rm = TRUE) should work


center_by <- function(variable, by = mean, ...){
  if(is.function(by)) by <- by(variable, ...)
  out <- variable - by
  return(out)
}

center_by(airquality$Ozone, mean, na.rm = TRUE)



# 5. The center_by function does not behave as it should with the following code
#    Of course, the user made a mistake, but it would be nice to make sure this
#    error can avoided. Create a check so that the function can notify the
#    user.

# center_by(1:10, quantile, probs = c(.2, .8)) should notify the user of a 
#    potential problem

center_by <- function(variable, by = mean, ...){
  if(is.function(by)) by <- by(variable, ...)
  if(length(by) > 1) warning("Centered using multiple values. Is this what you want?", call. = FALSE)
  out <- variable - by
  return(out)
}

center_by(1:10, quantile, probs = c(.2, .8))


# 6. Adjust the function you wrote for exercise 2. Make sure that all histograms
#    are plot in one figure. You will have to change the par() settings 
#    using mfrow. Yet make sure that the par() settings are only changed 
#    when the function is used (i.e., that the settings are reset to what they)
#    were.
?par

#  hist_all(airquality, col = "pink", xlab = NULL) should result in a plot
#    with sex panels

hist_all <- function(data, nrow = 2, ...){
  ncol = ceiling(length(data) / nrow)
  old_par <- par(mfrow = c(nrow, ncol))
  on.exit(par(old_par))
  for(col in seq_along(data)){
    hist2(data[[col]], main = names(data)[col], ...)
  }
  return(invisible(data))
}

hist_all(airquality, col = "pink", xlab = NULL)



# 7. Make a create_center_by function that returns a function which you can use
#    to center by. The create_center_by should have only a "by" argument, which
#    can be either a numerical value, or a function.

# center_by_min <- create_center_by(min) should create a function that centers 
#    using the minimum


create_center_by <- function(by){
  out <- function(variable, ...){
    if(is.function(by)) by <- by(variable, ...)
    if(length(by) > 1) warning("Centered using multiple values. Is this what you want?", call. = FALSE)
    return(variable - by)
  }
  return(out)
}

center_by_min <- create_center_by(by = min)
center_by_min(airquality$Ozone, na.rm = TRUE)

center_by_5 <- create_center_by(by = 5)
center_by_5(airquality$Ozone)

create_center_by(by = mean)(airquality$Ozone, na.rm = TRUE)



