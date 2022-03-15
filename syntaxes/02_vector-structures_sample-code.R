#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Vector structures - Sample code
# 
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
my_list <- list("this",
                a = list(a = c(1:2)))
my_list
attr(my_list, "dim") <- c(2, 2) # adding a "dim" attribute is possible
my_list                         # but not very useful
?list()


# matrix & array
my_matrix <- matrix(2.5, nrow = 3, ncol = 3)
my_matrix
cbind(1:3, 1:3)
rbind(1:3, 1:3)
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
vector <- c(a = 1, b = 5, c = 3, d = 8)
vector[c(TRUE, FALSE, FALSE, TRUE)]
vector[TRUE]
vector[c(FALSE, TRUE)]
vector[c(FALSE, TRUE, TRUE, FALSE, TRUE)]   # NA is returned TRUE exceeds the 
                                               # length of the vector
vector[vector > 4]     # usefull for conditional selection
vector[1:4 < 4]


# subsetting attomic vectors - integer
vector[c(1, 5)]     # NA is return if index exceeds the length of the vector
vector[c(1, 2, 1, 2, 1, 2, 1 ,2, 1, 2, 1, 2)] # repeated selection
vector[-c(2, 4, 2)] # negative integers

vector[vector > 4]  
vector[which(vector > 4)]   
which(vector > 4)
?which

vector[1.999]    # why does this happen?


# subsetting attomic vectors - character
vector[c("a", "b")]
vector[c("a", "b", "a", "b", "a", "b", "a", "b", "a", "b", "a", "b")]
vector[-c("a", "b")]   # returns error

?`[`

# [[]] selects one element
vector[[2]]
vector[["c"]]
vector[[TRUE]]  # why does this work? Automatic conversion!
vector[[2.2]]   # why does this work? Automatic conversion!


# subsetting matrix and arrays
my_matrix <- matrix(c(11, 21, 12, 22), ncol = 2, 
                    dimnames = list(paste0("row", 1:2), paste0("col", 1:2)))
names(my_matrix) <- letters[1:4]
my_matrix[2]
my_matrix[["b"]]
my_matrix[my_matrix < 20]

my_matrix[,2]
my_matrix[,2, drop = FALSE]
my_matrix[2,]
my_matrix[2, , drop = FALSE]
my_matrix[-1,"col2"]
my_matrix["row1",c(TRUE, FALSE)]
my_matrix["row1",c(TRUE, FALSE)]
is.matrix(my_matrix[,1])                 # not a matrix anymore
is.matrix(my_matrix[,1, drop = FALSE])   # still a matrix


# subsetting using a matrix
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





