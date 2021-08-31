# Advanced R
# Spring Academy FDZ, March 2021

# R flow & conditional programming
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................
# pisa <- readRDS("c:/Benjamin_Becker/02_Repositories/workshops/R_courses/data//pisaPlus_CF.RDS")
# pisa <- readRDS("C:/Users/benjb/Documents/Repositories/R_courses/data//pisaPlus_CF.RDS")
pisa <- readRDS("data//pisaPlus_CF.RDS")

# documentation
#...........................
?`if`
?ifelse

# related functions
#...........................
?switch
?cut


# if
#...........................
## Examples
if(!"tidyr" %in% installed.packages()[, 1]) {
  install.packages("tidyr")
}

iris2 <- iris
if(!is.character(iris2$Species)) {
  iris2$Species <- as.character(iris2$Species)
}


# Typical test functions
#...........................
a <- c(1, NA, 4, NA)
b <- c(1, 7, 2, NA)

a == b 
a != b 
is.na(a)

a == b & a > 1
a == b && a > 1

# ...

# ifelse
#...........................
table(pisa$classsize)
pisa$classsize_cat <- ifelse(pisa$classsize > 10, yes = "big", no = "small")
table(pisa$classsize_cat)


table(pisa$repeated)
pisa$school_entry_age <- ifelse(pisa$repeated == "Did not repeat a grade", 
                                yes = pisa$age - 8, no = pisa$age - 9)
table(pisa$school_entry_age)



# Exercises
#===========================================================
pisa <- readRDS("data//pisaPlus_CF.RDS")

# 1. Check if 'idstud' is unique in the pisa data set and create a new, unique id-Variable if it is not.  
if(length(unique(pisa$idstud)) < nrow(pisa)) {
  pisa[, "new_id"] <- seq(nrow(pisa))
}
pisa$new_id

# 2. Create a variable that indicates whether children are attending a Gymnasium ('schtype') with an afternoon program ('ganztag'). 
pisa$Gym_afternoon <- ifelse(pisa$schtype == "Gymnasium (academic track)" & pisa$ganztag == "Yes", 
                             yes = "yes", no = "no")

table(pisa$Gym_afternoon)
table(pisa$Gym_afternoon, pisa$schtype)


# 3. consider the pisa data-set. The students should be split into six groups based on how many books they have at home, and the years of parent education. Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 >= pared       and  books >= 26 => group 2
# pared < 12       and  books <  26 => group 3
# 12 >= pared      and  books <  26 => group 4
table(pisa$books)
table(pisa$pared)

pisa$group <- ifelse(pisa$books %in% c("0-10 books", "11-25 books") & pisa$pared < 12, yes = 1, no = 
                       ifelse(pisa$books %in% c("0-10 books", "11-25 books") & pisa$pared >= 12, yes = 2, no =
                       ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & pisa$pared < 12, yes = 3, no = 
                       ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & pisa$pared >= 12, yes = 4, no = NA))))

table(pisa$group, useNA = "if")
table(pisa$books, pisa$pared, useNA = "if")
table(pisa$group, pisa$pared, useNA = "if")
table(pisa$group, pisa$books, useNA = "if")


pisa$group <- ifelse(pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared < 12, yes = 1, no = 
                       ifelse(pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared >= 12, yes = 2, no =
                                ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared < 12, yes = 3, no = 
                                         ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared >= 12, yes = 4, no = NA))))

table(pisa$group, useNA = "if")
table(pisa$books, pisa$pared, useNA = "if")
table(pisa$group, pisa$pared, useNA = "if")
table(pisa$group, pisa$books, useNA = "if")






