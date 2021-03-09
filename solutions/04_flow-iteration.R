# Advanced R
# Spring Academy FDZ, March 2021

# R flow & iteration
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Exercises + Possible Sollutions
#===========================================================
# 1. Create an object and add some attributes. Write some code that checks whether the object has and attribute called "date". If not, the code should automatically add a "date" attribute to the object with today's date as its value (?Sys.Date). If the object already has a "date" attribute, than make sure the attribute is of "Date".

my_object <- structure(list(string = c("these", "are", "some", "words"), 
                            numbers = c(-10:10)), 
                       first_attribute = "irrelevant for this exercise", 
                       date = "1992-09-14")

if(is.null(attr(my_object, "date"))) {
  attr(my_object, "date") <- Sys.Date()
} 

if(!inherits(attr(my_object, "date"), "Date")) {
  attr(my_object, "date") <- as.Date(attr(my_object, "date"))
}


# 2. consider the pisa data-set. The students should be split into six groups based on how many books they have at home, and the years of parent education. Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 <= pared       and  books >= 26 => group 2
# pared < 12        and  books >= 26 => group 3
# 12 <= pared       and  books >= 26 => group 4

pisa <- readRDS("data//pisaPlus_CF.RDS")

#  a) use a loop an if statements
#  b) use ifelse

# loop and if () else
pisa$group <- NA
for (rowNr in seq_len(dim(pisa)[1])){
  if(any(is.na(pisa$books[rowNr]), is.na(pisa$pared[rowNr]))) next
  pisa$group[rowNr] <- if(pisa$books[rowNr] %in% c("0-10 books", "11-25 books")) {
    if(pisa$pared[rowNr] < 12) "group_1"
    else "group_2"
  } else {
    if(pisa$pared[rowNr] < 12) "group_3"
    else "group_4"
  }
}

# ifelse
pisa$group <- ifelse(is.na(pisa$books) & is.na(pisa$pared),
                     NA, 
                     ifelse(pisa$books %in% c("0-10 books", "11-25 books"),
                            ifelse(pisa$pared[rowNr] < 12, 
                                   "group_1", 
                                   "group_2"),
                            ifelse(pisa$pared[rowNr] < 12, 
                                   "group_3", 
                                   "group_4")
                            )
)

# sapply
get_group <- function(rowNr) {
  books <- pisa$books[rowNr]
  pared <- pisa$pared[rowNr]
  if(any(is.na(books), is.na(pared))) return(NA)
  if(books %in% c("0-10 books", "11-25 books")) {
    if(pared < 12) return("group_1")
    else return("group_2")
    } else {
      if(pared < 12) return("group_3")
      else return("group_4")
    }
}
sapply(seq_len(dim(pisa)[1]), get_group)


# using while
pisa$group <- NA
rowNr <- 0
while (rowNr < dim(pisa)[1]){
  rowNr <- rowNr + 1
  if(any(is.na(pisa$books[rowNr]), is.na(pisa$pared[rowNr]))) next
  pisa$group[rowNr] <- if(pisa$books[rowNr] %in% c("0-10 books", "11-25 books")) {
    if(pisa$pared[rowNr] < 12) "group_1"
    else "group_2"
  } else {
    if(pisa$pared[rowNr] < 12) "group_3"
    else "group_4"
  }
}

# using repeat
pisa$group <- NA
rowNr <- 0
repeat {
  rowNr <- rowNr + 1
  if(any(is.na(pisa$books[rowNr]), is.na(pisa$pared[rowNr]))) next
  pisa$group[rowNr] <- if(pisa$books[rowNr] %in% c("0-10 books", "11-25 books")) {
    if(pisa$pared[rowNr] < 12) "group_1"
    else "group_2"
  } else {
    if(pisa$pared[rowNr] < 12) "group_3"
    else "group_4"
  }
  if(rowNr == dim(pisa)[1]) break
}


# 3. Write a function based on the code from exercise 1. Use todays date as the default, but let users have the option to specify the date. Don't forget to return the object.

my_object <- structure(list(string = c("these", "are", "some", "words"), 
                            numbers = c(-10:10)), 
                       first_attribute = "irrelevant for this exercise", 
                       date = "1992-09-14")

add_date <- function(object, date = Sys.Date()){
  if(is.null(attr(object, "date"))) {
    attr(object, "date") <- date
  } 
  
  if(!inherits(attr(object, "date"), "Date")) {
    attr(object, "date") <- as.Date(attr(object, "date"))
  }
  object
}

add_date(5)
add_date(my_object)


# 4. Apply the split-apply paradigm to the pisa data. Create a summary for the hisei column, for each group created in exercise 2.

sapply(split(pisa$hisei, pisa$group), summary)

# other options, each with own arguments
aggregate(pisa$hisei, by = list(pisa$group), summary)
by(pisa$hisei, pisa$group, summary)
tapply(pisa$hisei, pisa$group, summary)

# check the plyr and dplyr packages







