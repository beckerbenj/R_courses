# Introduction to Programming in R
# Zurich R Courses, October 2021

# Basic elements \& data types II
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


## Useful functions -----
## __________________________________________________________________________

?list        # creates a list
?matrix      # creates a matrix (i.e., an array with two dimensions)
?array       # creates an array with any number of dimensions
?data.frame  # creates a data frame


## Some examples ----
## (Look at the code, run the code and inspect the result)
## __________________________________________________________________________


# lists
my_list <- list(1.23, 
                "this", 
                a = list(a = c(1:2)), 
                b = TRUE)
attr(my_list, "dim") <- c(2, 2) # adding a "dim" attribute is possible
my_list                         # but not very useful
?list()


# matrix & array
my_matrix <- matrix(2.5, nrow = 3, ncol = 3)
my_matrix
is.array(my_matrix)
dim(my_matrix)
typeof(my_matrix)
as.double(my_matrix)   # attributes are lost

my_array <- array(1:8, dim = c(2, 2, 2))
my_array
is.array(my_array)
dim(my_array)
typeof(my_array)
length(my_array)       # length of the vector (does not take dim-attribute)
                       # into account
?dim



# data.frame
my_data  <- data.frame(1:4, 
                       var1 = c("a", "b", "c", "d")) 
my_data               # automatic column names when not provided
attributes(my_data)
dim(my_data)          # has 2 dimensions but no dim-attribute!
names(my_data)        # gives the column names
colnames(my_data)     # gives the column names
rownames(my_data)     # gives the row names 
                      # We advise not to use row names when in programming 
                      # with data.frames
typeof(my_data)
data.frame(1:4, var1 = I(list(c("a", "b"),       # columns can be lists
                         list(FALSE, "FALSE"),   # using the I() function
                         1:5, c("c", "d"))))
?colnames
?rownames


# subsetting and replacing
#...........................
# subsetting attomic vectors - logical
my_object <- c(a = 1, b = 5, c = 3, d = 8)
my_object[c(TRUE, FALSE, FALSE, TRUE)]
my_object[TRUE]
my_object[c(FALSE, TRUE)]
my_object[c(FALSE, TRUE, TRUE, FALSE, TRUE)]   # NA is returned TRUE exceeds the 
                                               # length of the vector
my_object[my_object > 4]     # usefull for conditional selection
my_object[1:4 < 4]


# subsetting attomic vectors - integer
my_object[c(1, 5)]     # NA is return if index exceeds the length of the vector
my_object[c(1, 2, 1, 2, 1, 2, 1 ,2, 1, 2, 1, 2)] # repeated selection
my_object[-c(2, 4, 2)] # negative integers

my_object[my_object > 4]  
my_object[which(my_object > 4)]   
which(my_object > 4)
?which

my_object[1.999]    # why does this happen?


# subsetting attomic vectors - character
my_object[c("a", "b")]
my_object[c("a", "b", "a", "b", "a", "b", "a", "b", "a", "b", "a", "b")]
my_object[-c("a", "b")]   # returns error

?`[`

# [[]] selects one element
my_object[[2]]
my_object[["c"]]
my_object[[TRUE]]  # why does this work?
my_object[[2.2]]   # why does this work?


# subsetting matrix and arrays
my_matrix <- matrix(c(11, 12, 21, 22), ncol = 2, dimnames = list(paste0("row", 1:2), paste0("col", 1:2)))
names(my_matrix) <- letters[1:4]
my_matrix[2]
my_matrix[["b"]]
my_matrix[my_matrix < 20]

my_matrix[2,]
my_matrix[,2]
my_matrix[-1,"col2"]
my_matrix["row1",c(TRUE, FALSE)]
my_matrix["row1",c(TRUE, FALSE)]
is.matrix(my_matrix[,1])
is.matrix(my_matrix[,1, drop = FALSE])

my_matrix[matrix(c(c(1, 2), c(1, 2)), ncol = 2)]
selection_matrix <- rbind(c(1, 1), c(1, 2), c(2, 1))
my_matrix[selection_matrix]


# subsetting lists
my_list<- list(a = 1, b = 5, c = 3, d = 8)
my_list[c(2, 2)]
my_list[["b"]]
my_list$b
my_list[c(TRUE, TRUE, FALSE)]
is.list(my_list["a"])
is.list(my_list[["a"]])


# subsetting data.frame
my_dat <- data.frame(col1 = c(11, 21), 
                     col2 = c(12, 22))
### data.frames are lists
my_dat[1]
my_dat["col1"]
my_dat$col1
my_dat[c(TRUE, FALSE)]
is.data.frame(my_dat["col1"])
is.data.frame(my_dat[["col1"]])

### a data.frame also behaves like matrix
my_dat[,"col1"]
my_dat[,"col1", drop = FALSE]
my_dat[c(TRUE, FALSE), "col2"]
my_dat[c(TRUE, FALSE), "col2", drop = FALSE]
my_dat[matrix(c(c(1, 2), c(1, 2)), ncol = 2)]


# replacement
a <- 1:4
a
a[2:3] <- "a"
a
a[8] <- "b"
a
my_dat[2, 1] <- 33
my_dat
my_dat["col3"] <- 44
my_dat
my_dat[,1] <- NULL
my_dat




## Exercises ----
## __________________________________________________________________________


# 1. Create the following matrixes
#       [,1] [,2] [,3] [,4]
#  [1,]    1    3    5    7
#  [2,]    2    4    6    8

#       [,1] [,2]
#  [1,]    1    5
#  [2,]    2    6
#  [3,]    3    7
#  [4,]    4    8

#       [,1]  [,2]  [,3] 
#  [1,] "a11" "a12" "a13"
#  [2,] "a21" "a22" "a23"
#  [3,] "a31" "a32" "a33"
#  [4,] "a41" "a42" "a43"

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

