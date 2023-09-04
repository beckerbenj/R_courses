#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions II - Solutions
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




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

computeDescriptives <- function(x, na.rm = TRUE) {
  c(sumNAs = sum(is.na(x)),
    median = median(x, na.rm = na.rm),
    uniqueValues = length(unique(x)))
}

computeDescriptives(mtcars$mpg)


# 2. Consider the drop_NA()-function from the previous exercises.
#    Add a side-effect to the function: inform the user of
#    how many NA values were dropped. 
#    Add a "verbose" argument with default FALSE, so that 
#    users can also choose whether to get the information.
drop_NA <- function(x, verbose = TRUE){
  is_NA <- is.na(x)
  if(verbose) message(sum(is_NA), " NA-values were dropped.")
  out <- structure(x[!is_NA], 
                   original_length = length(x),
                   which_NA = which(is_NA))
}

Ozone_noNA <- drop_NA(airquality$Ozone) 
Ozone_noNA
Ozone_noNA <- drop_NA(airquality$Ozone, verbose = FALSE) 
Ozone_noNA


# 3. Consider the get_info()-function from above. Include
#    a "na.rm" argument with a sensible default. 
#    when na.rm = TRUE, the function should:
#       - remove NA values before computing the statistics
#       - inform the user how many NA values were removed
#       - make sure users can choose not to get this information
#    TIP: make use of the function you wrote for exercise 2.
get_info <- function(x, na.rm = TRUE, verbose = FALSE){
  if(na.rm) x <- drop_NA(x, verbose = verbose)
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
create_boxplot <- function(x, main = "Boxplot", xlab = NULL, ylab = "Values") {
  boxplot(x, main = main, xlab = xlab, ylab = ylab)
}
create_boxplot(mtcars$mpg)
boxplot(mtcars$mpg)



# 5. Implement 'input checks' for your boxplot function. The function should throw
#    an error, if the input is not a single numeric vector.
# If the vector contains missing values, the function should throw a warning.
create_boxplot2 <- function(x, main = "Boxplot", xlab = NULL, ylab = "Values") {
  if(!is.numeric(x)) stop("'x' must be a numeric vector.")
  if(any(is.na(x))) warning("'x' contains missing values.")
  boxplot(x, main = main, xlab = xlab, ylab = ylab)
}
create_boxplot2(mtcars$mpg)
create_boxplot2(mtcars)
create_boxplot2(c(mtcars$mpg, NA))


# 6. Write a function that creates either a histogram or a bar chart for a 
#    variable, depending on the input:
#      + character/factor -> bar chart using table()
#      + numeric -> histogram
create_graph <- function(x) {
  if(is.character(x) || is.factor(x)) return(barplot(table(x)))
  else if(is.numeric(x)) return(hist(x))
  else stop("No suitable input supplied.")
}

create_graph(1:5)
create_graph(c("a", "b", "c"))
create_graph(mtcars$mpg)
create_graph(iris$Species)

