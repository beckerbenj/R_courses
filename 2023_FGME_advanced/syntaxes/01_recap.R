#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Recap
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




## Useful functions -----
## __________________________________________________________________________

?c           # concatinate: creates a vactor
?list        # creates a list
?matrix      # creates a matrix
?data.frame  # creates a data frame
?length      # gives the length of a vector (i.e., the number of elements)
?dim         # gives the dimensions (for matrix, data.frame, array)
?names			 # gives the names of the elements of a vector/list





## Example Code
## __________________________________________________________________________

# a data.frame is a list of vectors (with equal length)
#    => columns can be of different types
iris_dat <- head(iris)
is.list(iris_dat)
dim(iris_dat)
length(iris_dat)
iris_dat[1:2,]



# a matrix is a vector with dimensions 
#    => all elements are of the same type
iris_mat <- as.matrix(iris_dat)
dim(iris_mat)
length(iris_mat)
iris_mat[1:2,]




# iterate over a character vector
for (name in c("Alice", "Bob", "Casey")){
  if(name == "Bob") cat(" This was Bob -")
  else cat(" Not Bob -")
}
name


## while loop
index <- 0
while (index <= 7){
  index <- index + 1
  cat(index, " ")
}
index



## while loop
max_abs <- 0
while (max_abs <= 3){
  cat("|")
  values <- rnorm(20)
  max_abs <- max(abs(values))
}
max_abs
round(values, 3)




## repeat loop
index <- 0
repeat {
  index <- index + 1
  if (index %in% c(3, 5)) next
  if (index > 6) break
  print(index)
}



## for loop - same result
for(index in 1:6) {
  if (index %in% c(3, 5)) next
  print(index)
}



## nested for loop
matrix <- matrix(NA, nrow = 2, ncol = 3)
for (rowNr in 1:2){
  for (colNr in 1:3){
    matrix[rowNr, colNr] <- rowNr * 10 + colNr
  }
}
matrix 




## use seq() and not :
x <- numeric()
x
for (index in 1:length(x)){
  print(index)
}


for (index in seq_along(x)){
  print(index)
}





## don't grow, but replace
x <- letters
result1 <- numeric() # grow
result2 <- numeric(length(x)) # replace
for (index in seq_along(x)){
  result1 <- c(result1, paste(index, x[index])) # grow
  result2[index] <- paste(index, x[index]) # replace
}




## apply
?apply
my_matrix <- matrix(1:6, nrow = 2)
apply(my_matrix, 1, max)  # apply per row

apply(my_matrix, 2, max)  # apply per column



my_array <- array(1, dim = c(2, 3, 4))
apply(my_array, c(1, 2), sum) # per row and column

apply(my_array, 3, sum) # per "third dimension"










## Exercises -----
##===========================================================

# 1. Consider the repeat-loop below. Write a while-loop that gives the same results.

## repeat-loop
index <- 0
repeat {
  index <- index + 1
  if (index %in% c(3, 5)) next
  if (index > 6) break
  print(index)
}

## while-loop



# 2. Consider the vector of values. 
#    (a) Write a for loop in which you compute the square of each value and 
#        compare it with the raw value. When the raw values are smaller, 
#        keep the raw values, else, keep the squared values. The result should
#        be a vector. 
#        Note that you do not know in advance how long the vector is, make 
#        sure your code works regardless of the length of the vector.
#    (b) Try to do this without a for loop.
values <- rnorm(sample(5:15))






# 2. Consider the following list ("attendance_list"). Write a for loop in which 
#      (a) the name "Benny" is replaced by "Bob"
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



# 3. Consider the iris data. Using a loop, compute the maximum value 
#    for each column in the iris data and print the results.
#    TIP: computing the maximum for a factor is impossible, make sure
#         to only include the first four columns.
?iris
iris



# 4. Consider the airquality data. 
#    (a) Using a for loop, check whether there are NA values for each column. 
#        For instance using the anyNA() function. The result should be a logical
#        vector with a length that equals the number of columns.
#    (b) Repeat this, but now for each row.
#    (c) Repeat (a) and (b), but use the apply() function.
?airquality
data("airquality")






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
#    Tip 2: use a if() and next, to skip cells that should not be changed
A <- matrix(0, ncol = 7, nrow = 7)





# BONUS. Using the formula (1 + 1 / x)^x, you can approximate Euler's number.
#    Write a loop in which x increases with 1 each iteration and find the
#    first x for which the difference between the formula and exp(1) is 
#    less than 0.00001




