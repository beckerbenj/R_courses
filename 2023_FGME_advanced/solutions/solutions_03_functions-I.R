#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Functions I - Solutions
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Exercises
#===========================================================
# 1. Write a function with one argument that returns the input times 3 + 1 
#    (3x + 1).
get_3x_plus1 <- function(x){
  out <- x * 3 + 1
  return(out)
}

get_3x_plus1(3)


# 2. Write a function with two arguments that returns the sum of the two 
#    arguments divided by 10 as the following character string: 
#    "A tenth of the sum of <first argument> and <second argument> 
#    equals <value>."
#    TIP: use the paste() or paste0() function
?paste()
    
get_tenth_sum <- function(x, y) {
  value <- (x + y) / 10
  out <- paste0("A tenth of the sum of ", x, " and ", y, " equals ", value, ".")
  return(out)
}

get_tenth_sum(5, 2)


# 3. Write a function with one argument that returns a vector with NA values 
#    removed. TIP: ?is.na()
drop_NA <- function(vector){
  vector[!is.na(vector)]
}

drop_NA(c(1, NA, 5))


# 4. Write a function with two arguments that returns the first argument (a vector)
#    with the values in the second argument removed. 
#    Make sure the function works when the second argument contains multiple values
# TIP: use %in%
?`%in%`

purify <- function(vector, values){
  vector[! vector %in% values]
}

purify(letters, values = c("a", "c"))
purify(c(1, 3, 5, 4, 2, 6, 3, 4, 2), values = c(2, 3, 7))




# 5. Write a function that takes a vector and creates a relative frequency table 
#    (output in percentage!). TIP: the function prop.table() can help. 
#    Test your function with the iris data.
data(iris)
?prop.table

computeRelFreq <- function(x) {
  prop.table(table(x)) * 100
}
computeRelFreq(iris$Species)


