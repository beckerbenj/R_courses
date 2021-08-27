# Introduction to Programming in R
# Zurich R Courses, October 2021

# R studio
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


## Create a new RStudio Project


# 1. Copy the course content from the usb-stick to a directory on your machine


# 2. Open RStudio


# 3. In RStudio, create a new R Studio Project: Choose File < New Project < ...


# 4. Choose "Existing Directory"


# 5. Browse to the directory on your machine where you copied the course 
#    content and select the ``Intro-R-programming'' folder as the 
#    Project working directory


# 6. Click "Open in new session"


# 7. Click "Create Project"


## After creating the RStudio Project...
## - Check your current working directory:
getwd()

## - Check the directories/folders in your working directory
list.dirs()


# 8. Create a folder named "R" for your R scripts and a folder named "data" 
#  for data.
## Again check the directories/folders in your working directory
list.dirs()


# 9. After creating the folders, save this script in the "R"-folder
## Check which files are in your R-folder:
list.files(".\\R")


# 10. Try out some keyboard shortcuts
### Tools < Keyboard Shortcuts Help

# 11. Set your preferences via the global options
### Tools < Global Options



# Basic elements \& data types
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

## Useful functions -----
## __________________________________________________________________________

?c       # combines values into a vector (or string)
?seq     # Creates a vector with a sequence of numerical values
?rep     # Creates a new vector by repeating the elements of a vector
?paste   # Creates a character vector by pasting multiple vectors together
?unique  # Creates a vector with the unique values of a vector
?sort    # Creates a sorted version a Vector
?table   # Create a contigency table


## Some examples ----
## (Look at the code, run the code and inspect the result)
## __________________________________________________________________________

c(3, 4, 5, 6)


# seq()
seq(3, 6)
3:6
seq(0, 10, by = 2)
seq(0, 1, length.out = 11)
seq_along(letters)
seq_len(10)


# rep()
rep(1:3, each = 2)
rep(1:3, times = 2)
rep(c("a", "b", "c"), times = 2)
rep(c("this", "may", "be", "useful", "!"), 1:5)


# paste()
value <- 5
paste("The found value is", value, ". Good job!")
paste0("ID_", 0, 1:9)


# unique(), sort(), length() & table()
length(3:6)
length(double(0))
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


# Create empty vectors of a specific type
character(6)
logical(0)
vector(mode = "double", 4)
vector(mode = "integer", 4)
?vector


# the NULL object
c(NULL, "a", NULL)
length(NULL)
c(NULL, NULL, NULL)


# Automatic conversion (all elements of a vector need to be af the same type)
1 + TRUE
c(FALSE, "word", NULL)
c(NULL, 2)


# Explicit conversion
as.character(FALSE)
as.logical(0:5)
as.vector(c(1.1, 1.5, 1.9), "integer")
as.null(c(1.1, 1.5, 1.9))
as.integer(NULL)


# check the basic type of a vector
is.logical(FALSE)
is.character(c(FALSE, "a string")[1])
is.null(NULL)

typeof(Inf)
typeof(TRUE + FALSE)
?typeof


# assignment
object1 <- "<- assigns a name to the object. This string is the object."
object1   #
assign("object2", "This also works, but <- is easier to read for humans.")
object2
?assign



# attributes
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
is.factor(structure(1:2, 
                    levels = c("a", "b"), 
                    class = "factor"))


## Exercises ----
## __________________________________________________________________________


# 1. Create the following sequences using rep() and seq()

#  [1] 0.00 0.25 0.50 0.75 1.00
#  [1] "missis" "sippi"  "missis" "sippi"  "missis" "sippi"
#  [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE
#  [1] 1 3 3 5 5 5 7 7 7 7 9 9 9 9 9

seq(0, 1, by = .25)
rep(c("missis", "sippi"), times = 3)
rep(c(TRUE, FALSE), each = 4)
rep(seq(1, 9, by = 2), 1:5)


# 2. Create the following vectors using paste()

#  [1] "spice-girl_1" "spice-girl_2" "spice-girl_3" "spice-girl_4" "spice-girl_5" 
#      "spice-girl_6" "spice-girl_7" "spice-girl_8" "spice-girl_9" 
#  [1] "spice-girl_1" "spice-girl_2" "spice-girl_3" "spice-girl_4" "spice-girl_5" 
#      "spice-girl_6" "spice-girl_7" "spice-girl_8" "spice-girl_9" 

#  [1] "90" "81" "72" "63" "54" "45" "36" "27" "18" "09"

paste("spice-girl", 1:9, sep = "_")
paste0(9:0, 0:9)


# 3. Create a logical vector with five elements (only the last is TRUE), 
#   - make sure each value has a name ("name_1" to "name_5")
#   - make sure the object has an attribute named "made in" which contains 
#     the string "Zurich"
#  str(my_object)
## Named logi [1:5] FALSE FALSE FALSE FALSE TRUE
## - attr(*, "names")= chr [1:5] "name_1" "name_2" "name_3" "name_4" ...
## - attr(*, "made in")= chr "Zurich"

my_object <- structure(c(rep(FALSE, 4), TRUE), 
                       names = paste0("name_", 1:5), 
                       'made in' = "Zurich")
str(my_object)



# 4. Using c(), rep(), and paste0(), create 30 ID of the form (ID_01, ID_02, ...).
numbers <- c(paste0(rep(0:2, each = 10), rep(0:9, times = 3)), 30)
IDs <- paste0("ID_", numbers)
IDs

# 5. What is the advantage over adding the zero's? Try sort(paste0("ID_", 1:30)).
sort(IDs)   # sorts the IDs in the correct order.






## BONUS ----
## __________________________________________________________________________

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



