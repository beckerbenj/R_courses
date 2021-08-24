# Advanced R
# Spring Academy FDZ, March 2021

# Functions II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
pisa_file <- file.path(dirname(getwd()), "data/pisaPlus_CF.RDS")
pisa <- readRDS(pisa_file)

# Input
#===========================================================

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
# 1. 



