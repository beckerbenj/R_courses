# Introduction to Programming in R
# Zurich R Courses, September - October 2021

# R flow & conditional programming
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::



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

nRows <- nrow(pisa)
if(length(unique(pisa$idstud)) < nRows) {
  pisa[, "new_id"] <- seq_len(nRows) 
  print("Variable new_id was added to the data.")
} else {
  print("Nothing was done.")
}
pisa$new_id

# 2. Create a variable that indicates whether children are attending a 
#    Gymnasium ('schtype') with an afternoon program ('ganztag'). 

pisa$Gym_afternoon <- ifelse(pisa$schtype == "Gymnasium (academic track)" & 
                               pisa$ganztag == "Yes", 
                             yes = "yes", no = "no")

with(pisa, table(Gym_afternoon))
with(pisa, table(Gym_afternoon, schtype))



# 3. Consider the pisa data-set. The students should be split into four groups 
#    based on how many books they have at home and the years of parent education. 
#    Create a new variable "group" based on the following specifications:
# pared < 12        and  books >= 26 => group 1
# 12 >= pared       and  books >= 26 => group 2
# pared < 12       and  books <  26 => group 3
# 12 >= pared      and  books <  26 => group 4
# TIP: use %in% to check if character string apears in another character string
?'%in%'


with(pisa, table(books))
with(pisa, table(pared))


pisa$group <- ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared < 12, yes = 1, no = 
                       ifelse(!pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared >= 12, yes = 2, no =
                                ifelse(pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared < 12, yes = 3, no = 
                                         ifelse(pisa$books %in% c("0-10 books", "11-25 books") & !is.na(pisa$books) & pisa$pared >= 12, yes = 4, no = NA))))

with(pisa, table(group, useNA = "if"))
with(pisa, table(books, pared, useNA = "if"))
with(pisa, table(group, pared, useNA = "if"))
with(pisa, table(group, books, useNA = "if"))






