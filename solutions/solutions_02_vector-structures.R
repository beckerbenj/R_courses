#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Vector structures
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




## Useful functions -----
## __________________________________________________________________________

?list        # creates a list
?matrix      # creates a matrix (i.e., an array with two dimensions)
?array       # creates an array with any number of dimensions
?data.frame  # creates a data frame


## Exercises ----
## __________________________________________________________________________


# 1. Create the following matrices:  (Tip use rep() and paste())

# 1.1
#       [,1] [,2] [,3] [,4]
#  [1,]    1    3    5    7
#  [2,]    2    4    6    8


# 1.2
#       [,1] [,2]
#  [1,]    1    5
#  [2,]    2    6
#  [3,]    3    7
#  [4,]    4    8


# 1.3
#       [,1]  [,2]  [,3] 
#  [1,] "a11" "a12" "a13"
#  [2,] "a21" "a22" "a23"
#  [3,] "a31" "a32" "a33"
#  [4,] "a41" "a42" "a43"


# 1.4
#       [,1] [,2] [,3] [,4] [,5]
#  [1,]    8    0    0    0    0
#  [2,]    0    7    0    0    0
#  [3,]    0    0    1    0    0
#  [4,]    0    0    0    6    0
#  [5,]    0    0    0    0    3
# TIP: use diag()  


matrix(1:8, nrow = 2)
matrix(1:8, ncol = 2)
matrix(paste0("a", rep(1:4, 3), rep(1:3, each = 4)), nrow = 4)
diag(c(8, 7, 1, 6, 3))


# 2. create the following array with three dimensions

#  , , Dim3 = dim3_1
#  
#         Columns
#  Rows    col_1 col_2 col_3 col_4
#    row_1     1     1     1     1
#    row_2     1     1     1     1
#  
#  , , Dim3 = dim3_2
#  
#         Columns
#  Rows    col_1 col_2 col_3 col_4
#    row_1     2     2     2     2
#    row_2     2     2     2     2
#  
#  , , Dim3 = dim3_3
#  
#         Columns
#  Rows    col_1 col_2 col_3 col_4
#    row_1     3     3     3     3
#    row_2     3     3     3     3


array(rep(1:3, each = 8), 
      dim = c(2, 4, 3), 
      dimnames = list(Rows = paste0("row_", 1:2), 
                      Columns = paste0("col_", 1:4), 
                      Dim3 = paste0("dim3_", 1:3)))

# 3. Assign the array you just created to a name, and select
#    all elements in the second column. The result should be:

#         Dim3
#  Rows    dim3_1 dim3_2 dim3_3
#    row_1      1      2      3
#    row_2      1      2      3

A <- array(rep(1:3, each = 8), 
           dim = c(2, 4, 3), 
           dimnames = list(Rows = paste0("row_", 1:2), 
                           Columns = paste0("col_", 1:4), 
                           Dim3 = paste0("dim3_", 1:3)))
A
A[, 2, ]


# 4. What happens if you add the argument "drop = FALSE", to the 
#    selection

A[, 2, , drop = FALSE]
# The object contains the same values, but still has three dimensions



# 5. Load the iris data frame using data(iris). Find ways to select the 
#    the second column as a data,frame, and as a vector.

data(iris)

iris[, c(FALSE, TRUE, FALSE, FALSE, FALSE)]
iris[, 2]
iris[[2]]
iris[,"Sepal.Width"]
iris[["Sepal.Width"]]

iris[c(FALSE, TRUE, FALSE, FALSE, FALSE)]
iris[2]
iris["Sepal.Width"]

