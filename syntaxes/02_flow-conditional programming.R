# Advanced R
# Spring Academy FDZ, March 2021

# R flow & conditional programming
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................
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


# ifelse
#...........................
table(pisa$classsize)
pisa$classsize_cat <- ifelse(pisa$classsize > 10, yes = "big", no = "small")


table(pisa$repeated)
pisa$school_entry_age <- ifelse(pisa$repeated == "Did not repeat a grade", 
                                yes = pisa$age - 8, no = pisa$age - 9)
table(pisa$school_entry_age)



# Exercises
#===========================================================
# 1. Check if 'idstud' is unique in the data set and create a new, unique id-Variable if it is not.  
if(length(unique(pisa$idstud)) < nrow(pisa)) {
  pisa[, "new_id"] <- seq(nrow(pisa))
}

# 2. Create a variable that indicates whether children are attending a Gymnasium ('schtype') with an afternoon program ('ganztag'). 
pisa$Gym_afternoon <- ifelse(pisa$schtype == "Gymnasium (academic track)" & pisa$ganztag == "Yes", 
                             yes = "yes", no = "no")

table(pisa$Gym_afternoon)
table(pisa$Gym_afternoon, pisa$schtype)


# 3. consider the pisa data-set. The students should be split into six groups based on how many books they have at home, and the years of parent education. Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 <= pared       and  books >= 26 => group 2
# pared < 12        and  books >= 26 => group 3
# 12 <= pared       and  books >= 26 => group 4

pisa <- readRDS("data//pisaPlus_CF.RDS")

# Bonus: Use the cat()-function instead.






