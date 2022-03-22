#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Loops & Iteration - Solutions
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::





## Useful functions -----
## __________________________________________________________________________

?`for`       # creates a for loop
?`while`     # creates a while loop
?`repeat`    # creates a reap loop
?`break`     # breaks out of a loop
?`next`      # jumps to the next iteration

?apply       # applies a function over the margins of an array/matrix


## Exercises -----
##===========================================================
# 1. Consider the vector of values. 
#    (a) Write a for loop in which you compute the square of each value and 
#        and compare it with the raw value. When the raw values are smaller, 
#        keep the raw values, else, keep the squared values. The result should
#        be a vector. 
#        Note that you do not know in advance how long the vector is, make 
#        sure your code works regardless of the length of the vector.
#    (b) Try to do this without a for loop.
values <- rnorm(sample(5:15))


# possible solution
results <- double(length(values))

for(index in seq_along(values)){
  square <- values[index]^2
  results[index] <- ifelse(values[index] < square, values[index], square)
}
results


# possible solution without loop
results <- ifelse(values < values^2, values, values^2)



# 2. Consider the following list ("attendance_list"). Write a for loop in which 
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



# 3. Consider the airquality data. 
#    (a) Using a for loop, check whether there are NA values each column. 
#        For instance using the anyNA() function. The result should be a logical
#        vector with a length that equals the number of columns.
#    (b) Repeat this, but now for each row.
#    (c) Repeat (a) and (b), but use the apply() function.
?airquality
data("airquality")

# possible solution (a)
n_col <- ncol(airquality)
NA_in_col <- logical(n_col)
names(NA_in_col) <- names(airquality)
for(col_nr in seq_len(n_col)){
  NA_in_col[col_nr] <- anyNA(airquality[, col_nr])
}

NA_in_col


# possible solution (b)
n_row <- nrow(airquality)
NA_in_row <- logical(n_row)
for(row_nr in seq_len(n_row)){
  NA_in_row[row_nr] <- anyNA(airquality[row_nr, ])
}

NA_in_row 


# possible solution (c)
apply(airquality, 2, anyNA)
apply(airquality, 1, anyNA)



# 4. Consider the zero matrix "A". 
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


# BONUS. Using the formula (1 + 1 / x)^x, you can approximate Euler's number.
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





