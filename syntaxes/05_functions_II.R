# Advanced R
# Spring Academy FDZ, March 2021

# Functions II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

# What is a good function?
#...........................
# pure functions!

# no sideeffects

# no dependency on global environment

# easier understanding, easier transfer!

#...........................

# debugging
#...........................
# browser()
pretty_table_dev <- function(x, x_label, useNA = "ifany"){
  browser()
  stopifnot(length(x) > 1)
  tab <- table(x, useNA = useNA)
  out <- as.data.frame(tab)
  names(out) <- c(x_label, "Frequency")
  out
}
pretty_table_dev(mtcars$cyl, x_label = "Cyl")

ls()


pretty_table <- function(x, x_label, useNA = "ifany"){
  stopifnot(length(x) > 1)
  tab <- table(x, useNA = useNA)
  out <- as.data.frame(tab)
  names(out) <- c(x_label, "Frequency")
  out
}
pretty_table(mtcars$cyl, x_label = "Cyl")

pretty_statistics <- function(x, x_label) {
  m <- mean(x, na.rm = TRUE)
  t <- pretty_table(x, x_label = x_label)
  list(mean = m, table = t)
}

pretty_statistics(mtcars$cyl, x_label = "Cyl")

by(mtcars, mtcars$carb, function(sub_dat) {
  pretty_statistics(sub_dat$cyl, x_label = "Cyl")
})

# traceback
traceback()


# option(error = recover) and option(error = NULL)
# option(warn = 2) 


#...........................

# Lazy Evaluation
#...........................
add_things3 <- function(x, y) {
  x + 10
}
add_things3(2)


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










