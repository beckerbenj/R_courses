#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Atomic Vectors - sample code
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




## Useful functions -----
## __________________________________________________________________________

?c       # combines values into a vector (or string)
?seq     # Creates a vector with a sequence of numerical values
?rep     # Creates a new vector by repeating the elements of a vector
?paste   # Creates a character vector by pasting multiple vectors together
?unique  # Creates a vector with the unique values of a vector
?sort    # Creates a sorted version a Vector
?table   # Create a contingency table


## Some examples ----
## (Look at the code, run the code and inspect the result)
## __________________________________________________________________________

# c creates a vector
c(3.3, 2.44, 9, 634)


# functions that create empty vectors of a specific type
character(6)
logical(0)
vector(mode = "double", 4)
vector(mode = "integer", 4)
?vector


# the NULL object
c(NULL, "a", NULL)
length(NULL)
c(NULL, NULL, NULL)


# usefull functions for creating vectors
# seq()
seq(3, 6)
3:6
seq(0, 10, by = 2)
seq(0, 1, length.out = 11)
seq_along(c("a", "b", "c", "d"))
seq_len(10)

# avoid 1:length(vector)!  
# compare:
seq_along(logical(0))
1:length(logical(0))


# rep()
rep(1:3, each = 2)
rep(1:3, times = 2)
rep(c("a", "b", "c"), times = 2)
rep(c("this", "may", "be", "useful", "!"), 1:5)


# paste()
paste("one", "big", "string", sep = " ")
paste0("word_", seq(1, 4))
value <- 5
paste("The found value is", value, ". Good job!")
paste0("ID_", 0, 1:5)
paste(c("ONE", "TWO"), seq(1, 3), 
      sep = " || ", collapse = "_-_")


# unique(), sort(), length() & table()
unique(c("b", "a", "a", "b"))
sort(c("b", "a", NA, "a", "b"))
sort(c("b", "a", NA, "a", "b"), na.last = TRUE)

length(3:6)
length(double(0))
length(NULL)

ordered_drinks <- c("Beer", "Wine - Red", "Soda", "Soda", "Soda", 
                    "Juice", "Water", "Wine - white", "Beer", "Wine - Red", 
                    "Soda", "Wine - white", "Beer", "Wine - Red", "Beer", 
                    "Wine - Red", "Soda", "Wine - white",  "Beer", "Wine - Red", 
                    "Beer", "Juice", "Water", "Wine - white", "Soda", "Soda", 
                    "Juice", "Water")
length(ordered_drinks)
unique(ordered_drinks)
sort(ordered_drinks)
table(ordered_drinks)




# Automatic conversion (all elements of a vector need to be af the same type)
1 + TRUE
c(FALSE, "word", NULL)
c(NULL, 2)


# Explicit conversion
as.logical(0:5)
as.character(FALSE)
as.vector(c(1.1, 1.5, 1.9), "integer")
as.null(c(1.1, 1.5, 1.9))
as.integer(NULL)


# check the basic type of a vector
is.null(NULL)
is.logical(FALSE)
is.character(c(FALSE, "a string")[1])
is.null(NULL)

typeof(Inf)
typeof(TRUE + FALSE)
?typeof


# assignment
my_object <- TRUE
my_object
object1 <- "<- assigns a name to the object. This string is the object."
object1   #
assign("object2", "This also works, but <- is easier to read for humans.")
object2
?assign



# attributes
my_object <- structure(5,
                       my_attribute = "string",
                       other_attribute = FALSE)
attributes(my_object)
attributes(object1)
attr(object1, "A new attribute") <- c(14, 25)
attributes(object1)
?attributes
?attr

object3 <- structure(5, 
                     my_attribute = "This is a s", 
                     other_attribute = FALSE)
str(object3)
?structure
?str


# Be aware, some function drop attributes
object3
as.integer(object3)
str(as.integer(object3)) # attributes are lost


# "names" attribute
points <- c(Anna = 6, Benny = 4, Casey = 8, Danny = 6) 
points
str(points)
names(points)
as.double(points) # names are lost, because names are attributes


# "dim" attribute
a <- 1:8
str(a)
attr(a, "dim") <- c(2, 4)
str(a)
is.matrix(a)
as.character(c(aa = 1, bb = 2))












































## BONUS ----
## __________________________________________________________________________

# A factor in R is actually an integer vector with:
#   - a "class" attribute set to "factor"
#   - a "levels" attribute set to the level-labels that correspond 
#     to the integer values from 1 to the highest integer value in the 
#     integer vector.
is.factor(structure(1:2, 
                    levels = c("a", "b"), 
                    class = "factor"))
int <- as.integer(c(1, 2, 1, 1, 3, 1, 5, 2))
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


# Bad practice! Use as.factor() or factor()



