# Introduction to Programming in R
# Zurich R Courses, October 2021

# Loops and Iteration
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


## Useful functions -----
## __________________________________________________________________________

?`for`       # creates a for loop
?`while`     # creates a while loop
?`repeat`    # creates a reap loop
?`break`     # breaks out of a loop
?`next`      # jumps to the next iteration

?apply       # applies a function over the margins of an array/matrix
?lapply      # applies a function over a list/vector

# other functions in the same family
?tapply
?mapply
?Reduce
?aggregate
?by


## Exercises -----
##===========================================================
# 1. Consider the following list ("attendance_list"). Write a for loop in which 
#      (a) the name "Benny" is replaced by "bob"
#      (b) the Attendees are put in alphabetical order
#    Tip: You can use the index of the elements, or the names of the elements
#         to iterate over.

attendance_list <- list(
  may_02 = c("Benny", "Anna", "Freddy", "Casey"), 
  may_09 = c("Freddy", "Casey", "Donny", "Anna"), 
  may_16 = c("Eddy", "Anna", "Freddy", "Casey", "Benny"), 
  may_23 = c("Donny", "Freddy", "Anna"),
  may_30 = c("Casey", "Freddy", "Donny", "Anna", "Benny", "Eddy")
)


# Possible Solutions

for(index in seq_along(attendance_list)){
  attendees <- attendance_list[[index]]
  which_benny <- which(attendees == "Benny")
  attendees[which_benny] <- "Bob"
  attendance_list[[index]]  <- sort(attendees)
}
attendance_list 


for(date in names(attendance_list)){
  attendees <- attendance_list[[date]]
  which_benny <- which(attendees == "Benny")
  attendees[which_benny] <- "Bob"
  attendance_list[[date]]  <- sort(attendees)
}
attendance_list


# 2. Consider the zero matrix "A". 
#    (a) Using a for loop, turn the matrix into a diagonal matrix with these 
#        values on the diagonal c(1, 2, 3, 5, 7, 11, 13). 
#    Tip 1: iterate over rows and columns together
#    Tip 2: iterate over a vector with the values
#
#    (b) Using nested loops, fill the upper triangle with ones, leaving the
#        values on the diagonal unchanged
#    Tip 1: use a double iteration, and let the inner loop depend on the outer 
#           loop
#    Tip 2: use a if() and next, to skip cells that should not be changed


A <- matrix(0, ncol = 7, nrow = 7)

# Possible solution
values <- c(1, 2, 3, 5, 7, 11, 13)

for (i in seq_len(ncol(A))){
  A[i, i] <- values[i]
}

for(rowNr in seq_len(nrow(A))){
  for(colNr in seq(rowNr, ncol(A))){
    if(rowNr == colNr) next
    A[rowNr, colNr] <- 1
  }
}


# 3. Using the formula (1 + 1 / x)^x, you can approximate Euler's number.
#    Write a loop in which x increases with 1 each iteration and find the
#    first x for which the difference between the formula and exp(1) is 
#    less than 0.00001

x <- 1
repeat{
  approx_e <- (1 + 1 / x)^x
  if(abs(approx_e - exp(1)) < 0.00001) break
  x <- x + 1
}
approx_e
x


# 4. Use the lapply function to sort the attendees alphabetically in 
#    attendance_list 
attendance_list <- list(
  may_02 = c("Benny", "Anna", "Freddy", "Casey"), 
  may_09 = c("Freddy", "Casey", "Donny", "Anna"), 
  may_16 = c("Eddy", "Anna", "Freddy", "Casey", "Benny"), 
  may_23 = c("Donny", "Freddy", "Anna"),
  may_30 = c("Casey", "Freddy", "Donny", "Anna", "Benny", "Eddy")
)


# Possible solution
lapply(attendance_list, sort)


# 5. Load the "airquality"-data using data("airquality"). 
#    (a) Using lapply, plot a pink histogram of each variable (?hist)
#    (b) Using vapply, compute the first and third quartile (quantile .25 
#    and .75)for each variable
#     Tip: ignore missing values using na.rm = TRUE
data("airquality")
?hist
?quantile


lapply(airquality, hist, col = "pink")
t(vapply(airquality, quantile, FUN.VALUE = double(2), probs = c(.25, .75), na.rm = TRUE))

