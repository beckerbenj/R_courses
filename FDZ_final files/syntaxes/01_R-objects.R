# Advanced R
# Spring Academy FDZ, March 2021


# R studio
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# 1. Create a new R Studio Project
### File < New Project < ...
getwd()

# 2. Create an "R"-folder for R scripts and a "data" folder for data.
list.dirs()

# 3. Save this script in the "R"-folder
list.files(".\\R")

# 4. Try out some keyboard shortcuts
### Tools < Keyboard Shortcuts Help

# 5. Set your preferences via the global options
### Tools < Global Options



# R objects (recap)
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

# Try to predict the output for each of the following lines
#===========================================================
#...........................

# Atomic vectors
#...........................
# build atomic vectors:
?c
c(3, 4, 5, 6)

?seq
seq(3, 6)
3:6

?rep
rep(c(1, 3), times = 5)
rep(c(1, 3), each = 5)
rep(c("this", "may", "be", "useful", "!"), 1:5)

character(6)
logical(0)
vector(mode = "double", 4)

length(3:6)
length(double(0))


# NULL
c(NULL, "a", NULL)
length(NULL)
c(NULL, NULL, NULL)


# conversion
1 + TRUE
c(FALSE, "word", NULL)
c(NULL, 2)

as.character(FALSE)
as.logical(0:5)
as.vector(c(1.1, 1.5, 1.9), "integer")
as.null(c(1.1, 1.5, 1.9))
as.integer(NULL)


# check vector type
is.logical(FALSE)
is.character(c(FALSE, "a string")[1])
is.null(NULL)

?typeof
typeof(Inf)
typeof(TRUE + FALSE)


# Assignment and Attributes
#...........................
# assignment
my_object <- 55
my_object
assign("object2", "This also works, but <- is easier to read for humans.")
object2
?assign


# attributes
my_object <- structure(5, 
                       my_attribute = "string", 
                       other_attribute = FALSE)
attributes(my_object)

attr(my_object, "new") <- c(14, 25)
str(my_object)

str(as.integer(my_object)) # attributes are lost

a <- 1:8
str(a)
attr(a, "dim") <- c(2, 4)
str(a)
is.matrix(a)
as.character(c(aa = 1, bb = 2))
is.factor(structure(1:2, 
                    levels = c("a", "b"), 
                    class = "factor"))
as.character(c(a = 1, b = 2))


# A factor in R is actually an integer vector with:
#   - a "class" attribute set to "factor"
#   - a "levels" attribute set to the level-labels that correspond 
#     to the integer values from 1 to the highest integer value in the 
#     integer vector.
int <- as.integer(c(1, 2, 1, 1, 3, 1, 5, 2))
# Bad practice! Use as.factor() or factor()
attr(int, "levels") <- c("Now way!", "Not sure", "Maybe", "OK", 
                         "Definitively!")
attr(int, "class") <- "factor"
int
typeof(int)
is.integer(int)  # check ?is.integer
is.factor(int)
levels(int)
factor(as.integer(c(1, 2, 1, 1, 3, 1, 5, 2)), 
       levels = 1:5, 
       labels = c("Now way!", "Not sure", "Maybe", "OK", "Definitively!"))



# Vector structures
#...........................
# list
my_list <- list(1.23, 
                "this", 
                a = list(a = c(1:2)), 
                b = TRUE)
attr(my_list, "dim") <- c(2, 2) # adding a "dim" attribute is possible
my_list                         # but not very useful


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

# data.frame
my_data  <- data.frame(1:4, 
                       var1 = c("a", "b", "c", "d")) 
my_data               # automatic column names when not provided
attributes(my_data)
dim(my_data)          # has 2 dimensions but no dim-attribute!
names(my_data)        # gives the column names
colnames(my_data)     # gives the column names
rownames(my_data)     # should not be used
typeof(my_data)
data.frame(1:4, var1 = I(list(c("a", "b"),       # columns can be lists
                         list(FALSE, "FALSE"),   # using the I() function
                         1:5, c("c", "d"))))


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

# select one element
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

