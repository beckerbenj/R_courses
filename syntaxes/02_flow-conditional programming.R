# Advanced R
# Spring Academy FDZ, March 2021

# R flow & iteration
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

pisa <- readRDS("data//pisaPlus_CF.RDS")

# Conditional programming
#...........................
# implement checks in your analysis/function
subset1 <- pisa[1:10, 1:2]
subset2 <- pisa[1:10, 1]

check_data_frame <- function(object){
  if(!is.data.frame(object)) stop("The object is not a 'data.frame'.")
}

check_data_frame(subset1)
check_data_frame(subset2)


# change behavior depending on the "test"
my_plot1 <- function(x, y, ...) {
  if(is.character(x)) x <- factor(x)
  if(is.character(y)) x <- factor(y)
  plot(x, y, ...)
}

with(pisa, plot(age, hisei))
with(pisa, my_plot1(age, hisei))

with(pisa, plot(books, hisei))
with(pisa, my_plot1(books, hisei))

with(pisa, plot(books, pared))
with(pisa, my_plot1(books, pared))
my_plot1(pisa$books, pisa$pared, xlab = "Books", ylab = "Education Years Parents")



# Set defaults
my_plot2 <- function(x, y, xlab = NULL, ylab = NULL, ...) {
  if(is.character(x)) x <- factor(x)
  if(is.character(y)) x <- factor(y)
  if(is.null(xlab)) xlab <- deparse(match.call()$x)
  if(is.null(ylab)) ylab <- deparse(match.call()$y)
  plot(x, y, xlab = xlab, ylab = ylab, ...)
}

with(pisa, my_plot2(books, pared))
my_plot2(pisa$books, pisa$pared)
my_plot2(pisa$books, pisa$pared, xlab = "Books", ylab = "Education Years Parents")



# switch
compute_stat <- function(vector, statistic, ...) {
  if(is.function(statistic)) return(statistic(vector, ...))
  if(is.character(statistic)){
    switch(statistic, 
           "mean" = mean(vector, ...),
           "median" = median(vector, ...), 
           "sd" = sd(vector, ...),
           "var" = var(vector, ...),
           "min" = min(vector, ...),
           "max" = max(vector, ...),
           stop(paste0("'", statistic, "' does not work. Maybe it works without the quotation marks." )))
  }
}

compute_stat(pisa$hisei, "min", na.rm = TRUE)
compute_stat(pisa$hisei, mean, na.rm = TRUE)
compute_stat(pisa$hisei, "quantile", na.rm = TRUE, prob = c(.2, .5, .8))
compute_stat(pisa$hisei, quantile, na.rm = TRUE, prob = c(.2, .5, .8))



# documentation
#...........................
?`if`
?ifelse
?switch




# Exercises
#===========================================================
# 1. Create an object and add some attributes. Write some code that checks whether the object has and attribute called "date". If not, the code should automatically add a "date" attribute to the object with today's date as its value (?Sys.Date). If the object already has a "date" attribute, than make sure the attribute is of "Date".



# 2. consider the pisa data-set. The students should be split into six groups based on how many books they have at home, and the years of parent education. Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 <= pared       and  books >= 26 => group 2
# pared < 12        and  books >= 26 => group 3
# 12 <= pared       and  books >= 26 => group 4

pisa <- readRDS("data//pisaPlus_CF.RDS")

#  a) use a loop an if statements
#  b) use ifelse



# 3. Write a function based on the code from exercise 1. Use todays date as the default, but let users have the option to specify the date. Don't forget to return the object.



# 4. Apply the split-apply paradigm to the pisa data. Create a summary for the hisei column, for each group created in exercise 2.









