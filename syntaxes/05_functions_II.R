# Advanced R
# Spring Academy FDZ, March 2021

# Functions II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# ... (dot dot dot)
#...........................
add_all_things <- function(...) {
  list(...)
}
add_all_things(2, 3)

add_all_things2 <- function(...) {
  l <- list(...)
  do.call(sum, l)
}
add_all_things2(2, 3, 5, 10)


#...........................

# Environments
#...........................


#...........................

# Pure functions
#...........................
# no sideeffects

# no dependency on global environment


#...........................

# Anonymous functions
#...........................
# use case: functionals


#...........................

# Packages, Namespaces, ...
#...........................
haven::read_spss
haven:::add_text


#...........................

# on.exit
#...........................
add_things <- function(x, y) {
  on.exit(cat("Sum of", x, "and", y))
  x <- x + 20
  x+y
}
out <- add_things(1, 2)
out


# Exercises
#===========================================================
# 1. 










