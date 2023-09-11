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
iris_mat <- as.matrix(head(iris))
dim(iris_mat)
length(iris_mat)
iris_mat[1:2,]


