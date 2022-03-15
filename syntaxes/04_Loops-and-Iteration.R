#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Loops & Iteration
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
?lapply      # applies a function over a list/vector

# other functions in the same family
?tapply
?mapply
?Reduce
?aggregate
?by


## Example Code
## __________________________________________________________________________

# iterate over a numeric vector
for (index in 1:3){
  cat(" computation -")
}


# iterate over a character vector
for (name in c("Alice", "Bob", "Casey")){
  if(name == "Bob") cat(" This was Bob -")
  else cat(" Not Bob -")
}


## nested for loop
matrix <- matrix(NA, nrow = 2, ncol = 3)
for (rowNr in 1:2){
  for (colNr in 1:3){
    matrix[rowNr, colNr] <- rowNr * 10 + colNr
  }
}



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


## use seq() and not :
x <- numeric()
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



## lapply
?lapply
?iris
str(iris)
lapply(iris, FUN = class)


?airquality
str(airquality)
means <- lapply(airquality, FUN = mean, na.rm = TRUE)
str(means)






## Exercises -----
##===========================================================
# 1. Consider the following list ("attendance_list"). Write a for loop in which 
#      (a) the name "Benny" is replaced by "bob"
#      (b) the Attendees are put in alphabetical order (using sort())
#    Tip: You can use the index of the elements, or the names of the elements
#         to iterate over.

attendance_list <- list(
  may_02 = c("Benny", "Anna", "Freddy", "Casey"), 
  may_09 = c("Freddy", "Casey", "Donny", "Anna"), 
  may_16 = c("Eddy", "Anna", "Freddy", "Casey", "Benny"), 
  may_23 = c("Donny", "Freddy", "Anna"),
  may_30 = c("Casey", "Freddy", "Donny", "Anna", "Benny", "Eddy")
)





# 2. Consider the airquality data. 
#    (a) Using a for loop, check whether there are NA values each column. 
#        For instance using the anyNA() function. The result should be a logical
#        vector with a length that equals the number of columns.
#    (b) Repeat this, but now for each row.
#    (c) Repeat (a) and (b), but use the apply() function.
?airquality
data("airquality")




# 3. Use the lapply function to sort the attendees alphabetically in 
#    attendance_list 
attendance_list <- list(
  may_02 = c("Benny", "Anna", "Freddy", "Casey"), 
  may_09 = c("Freddy", "Casey", "Donny", "Anna"), 
  may_16 = c("Eddy", "Anna", "Freddy", "Casey", "Benny"), 
  may_23 = c("Donny", "Freddy", "Anna"),
  may_30 = c("Casey", "Freddy", "Donny", "Anna", "Benny", "Eddy")
)




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




# BONUS. Using the formula (1 + 1 / x)^x, you can approximate Euler's number.
#    Write a loop in which x increases with 1 each iteration and find the
#    first x for which the difference between the formula and exp(1) is 
#    less than 0.00001



