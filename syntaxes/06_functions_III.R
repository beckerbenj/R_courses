# Advanced R
# Spring Academy FDZ, March 2021

# Functions II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
pisa_file <- file.path(dirname(getwd()), "data/pisaPlus_CF.RDS")
pisa <- readRDS(pisa_file)

# Input
#===========================================================

pisa <- readRDS("data//pisaPlus_CF.RDS")

# if
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



# Exercises
#===========================================================
# 1. 




