#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Flow & conditional programming
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Input
#===========================================================
#...........................

pisa <- readRDS("data//pisaPlus_CF.RDS")

# documentation
#...........................
?`if`
?ifelse

# related functions
#...........................
?switch
?cut



# Typical test functions
#...........................
a <- c(1, NA, 4, NA)
b <- c(1, 7, 2, NA)

a == b 
a != b 
is.na(a)

# compare & and &&  (similar for | and ||)
c(TRUE, TRUE) & c(FALSE, TRUE)
c(TRUE, TRUE) && c(FALSE, FALSE)

a == b & a > 1
a == b && a > 1


# if
# ....
# only the first element is evaluated
age <- c(8, 17, 39, 55)
if (age >= 18) {
  "can vote"
} else {
  "too young"
}


## if and else 
age <- 17
if (age >= 18) {
  vote <- "can vote"
} else {
  vote <- "too young"
}
vote


# meaningful initialisation
age <- 17
vote <- "too young"
if (age >= 18) {
  vote <- "can vote"
}
vote



# Examples
if(!"dplyr" %in% installed.packages()[, 1]) {
  install.packages("dplyr")
}


str(iris)
iris2 <- iris
if(!is.character(iris2$Species)) {
  iris2$Species <- as.character(iris2$Species)
}
str(iris2)



# ifelse
#...........................

age <- c(8, 17, 39, 55)
ifelse(age >= 18, yes = "can vote",
       no = "too young")


age_estimated <- c(10, 20, 35, 60)
age_self_rep <- c(NA, 17, 39, NA)
# Use available information, prioritize self report
ifelse(!is.na(age_self_rep), yes = age_self_rep,
       no = age_estimated)


table(pisa$classsize)
pisa$classsize_cat <- ifelse(pisa$classsize > 10, yes = "big", no = "small")
table(pisa$classsize_cat)


table(pisa$repeated)
pisa$school_entry_age <- ifelse(pisa$repeated == "Did not repeat a grade", 
                                yes = pisa$age - 8, no = pisa$age - 9)
table(pisa$school_entry_age)



# Exercises
#===========================================================

# load the pisa-dataset from the data-folder
pisa <- readRDS("data//pisaPlus_CF.RDS")

# 1. Use conditional programming to check if the student identifier variables "idstud" 
#    has repetitions. If not all values are unique, create a new variable with
#    unique (integer) values for every row, and add it to the pisa data.frame as
#    "new_id", in addition, print "Variable new_id was added to the data.". 
#    If all values in "idstud" are unique, print "Nothing was done."
# (TIP: you can combine unique() and length() to get the number of unique identifiers) 



# 2. Create a variable that indicates whether children are attending a 
#    Gymnasium ('schtype') with an afternoon program ('ganztag'). 





# 3. Consider the pisa data-set. The students should be split into four groups 
#    based on how many books they have at home and the years of parent education. 
#    Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 >= pared       and  books >= 26 => group 2
# pared < 12       and  books <  26 => group 3
# 12 >= pared      and  books <  26 => group 4
# TIP: use %in% to check if character string apears in another character string
?'%in%'







