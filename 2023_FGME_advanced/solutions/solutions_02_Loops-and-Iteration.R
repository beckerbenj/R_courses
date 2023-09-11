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

# 1. Consider the repeat-loop and for-loop below. Write a while-loop 
#    that gives the same results.

## repeat-loop
index <- 0
repeat {
  index <- index + 1
  if (index %in% c(3, 5)) next
  if (index > 6) break
  print(index)
}

## for-loop## repeat loop
for(index in 1:6) {
  if (index %in% c(3, 5)) next
  print(index)
}

## while-loop
index <- 0
while(index <= 5){
  index <- index + 1
  if (index %in% c(3, 5)) next
  print(index)
}



# 2. Consider the vector of values below. 
#    (a) Write a for loop in which you compute the square of each value and 
#        compare it with the raw value. When the raw values are smaller, 
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




# 3. Consider the iris data. Using a loop, compute the maximum value 
#    for each column in the iris data and print the results.
#    TIP: computing the maximum for a factor is impossible, make sure
#         to only include the first four columns.
?iris
iris

# Possible Solution
for(col in iris[-5]) {
  print(max(col))}
	
	
# Possible Solution
for(col_nr in seq_along(iris)) {
  if(is.numeric(iris[[col_nr]])) cat("The maximum of column '", 
	                                   names(iris)[col_nr], "' is ", 
																		 max(iris[[col_nr]]), ". \n", sep = "")
	else cat("Column '", names(iris)[col_nr], 
	         "' is not numeric, the maximum cannot meaningfully be computed. \n", 
					 sep = "")
	}
  

# 4. Consider the airquality data. 
#    (a) Using a for loop, check whether there are NA values for each column. 
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



# 5. Consider the zero matrix "A". 
#    (a) Using a for loop, turn the matrix into a diagonal matrix with these 
#        values on the diagonal c(1, 2, 3, 5, 7, 11, 13). 
#    Tip 1: iterate over rows and columns together
#    Tip 2: iterate over a vector with the values
#
#    (b) Using nested loops, fill the upper triangle with ones, leaving the
#        values on the diagonal unchanged
#    Tip 1: use a double iteration, and let the inner loop depend on the outer 
#           loop
#    Tip 2: use if() and next, to skip cells that should not be changed
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
A


# BONUS. Using the formula (1 + 1 / x)^x with x increasing, you can approximate 
#    Euler's number.
#    Write a loop in which x increases one (+1) with each iteration and find the
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





