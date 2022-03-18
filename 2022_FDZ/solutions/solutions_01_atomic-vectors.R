#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Atomic vectors - Solutions
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



## Exercises ----
## __________________________________________________________________________


# 1. Create the following sequences using rep() and/or seq()

# 1.1
#  [1] 0.00 0.25 0.50 0.75 1.00

# 1.2
#  [1] "missis" "sippi"  "missis" "sippi"  "missis" "sippi"

# 1.3
#  [1]  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE

# 1.4
#  [1] 1 3 3 5 5 5 7 7 7 7 9 9 9 9 9

seq(0, 1, by = .25)
rep(c("missis", "sippi"), times = 3)
rep(c(TRUE, FALSE), each = 4)
rep(seq(1, 9, by = 2), 1:5)


# 2. Create the following vectors using paste()

# 2.1
#  [1] "spice-girl_1" "spice-girl_2" "spice-girl_3" "spice-girl_4" "spice-girl_5" 
#      "spice-girl_6" "spice-girl_7" "spice-girl_8" "spice-girl_9" 

# 2.2
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



# 4. Using c(), rep(), and paste0(), create 30 IDs of the form (ID_01, ID_02, ...).
numbers <- c(paste0(rep(0:2, each = 10), rep(0:9, times = 3)), 30)
IDs <- paste0("ID_", numbers)
IDs

# 5. What is the advantage over adding the zero's? Try sort(paste0("ID_", 1:30)).
sort(IDs)   # sorts the IDs in the correct order.







