# Advanced R
# Spring Academy FDZ, March 2021

# R flow & iteration
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


# Input
#===========================================================
#...........................

pisa <- readRDS("data//pisaPlus_CF.RDS")

# Conditional programming
#...........................
# implement checks in your analysis/function
subset1 <- pisa[1:10, 1:2]
subset2 <- pisa[1:10, 1]

check_data_frame <- function(object){
  if(!is.data.frame(object)) stop("The object is not a 'data.frame'.")
}

check_data_frame(subset1)
check_data_frame(subset2)


# change behavior depending on the "test"
my_plot1 <- function(x, y, ...) {
  if(is.character(x)) x <- factor(x)
  if(is.character(y)) x <- factor(y)
  plot(x, y, ...)
}

with(pisa, plot(age, hisei))
with(pisa, my_plot1(age, hisei))

with(pisa, plot(books, hisei))
with(pisa, my_plot1(books, hisei))

with(pisa, plot(books, pared))
with(pisa, my_plot1(books, pared))
my_plot1(pisa$books, pisa$pared, xlab = "Books", ylab = "Education Years Parents")



# Set defaults
my_plot2 <- function(x, y, xlab = NULL, ylab = NULL, ...) {
  if(is.character(x)) x <- factor(x)
  if(is.character(y)) x <- factor(y)
  if(is.null(xlab)) xlab <- deparse(match.call()$x)
  if(is.null(ylab)) ylab <- deparse(match.call()$y)
  plot(x, y, xlab = xlab, ylab = ylab, ...)
}

with(pisa, my_plot2(books, pared))
my_plot2(pisa$books, pisa$pared)
my_plot2(pisa$books, pisa$pared, xlab = "Books", ylab = "Education Years Parents")



# switch
compute_stat <- function(vector, statistic, ...) {
  if(is.function(statistic)) return(statistic(vector, ...))
  if(is.character(statistic)){
    switch(statistic, 
           "mean" = mean(vector, ...),
           "median" = median(vector, ...), 
           "sd" = sd(vector, ...),
           "var" = var(vector, ...),
           "min" = min(vector, ...),
           "max" = max(vector, ...),
           stop(paste0("'", statistic, "' does not work. Maybe it works without the quotation marks." )))
  }
}

compute_stat(pisa$hisei, "min", na.rm = TRUE)
compute_stat(pisa$hisei, mean, na.rm = TRUE)
compute_stat(pisa$hisei, "quantile", na.rm = TRUE, prob = c(.2, .5, .8))
compute_stat(pisa$hisei, quantile, na.rm = TRUE, prob = c(.2, .5, .8))



# documentation
#...........................
?`if`
?ifelse
?switch


.
#...........................

# iteration
#...........................

n <- 2e+4
data <- data.frame(x = runif(n), 
                   y = runif(n), 
                   z = seq_len(n))

# grow object
system.time({
  new_data <- NULL
  
  for(row_nr in seq_len(NROW(data))){
    new_data <- cbind(
      data[row_nr,], 
      result = exp(data$x[row_nr]) /
        log(data$z[row_nr]) + 
        5 * sqrt(data$y[row_nr]))
  }  
})

# replace
system.time({
  n_rows <- dim(data)[1]
  data$result <- rep(NA, n_rows)
  
  for(row_nr in seq_len(n_rows)){
    data$result[row_nr] <- exp(data$x[row_nr]) / 
      log(data$z[row_nr]) + 
      5 * sqrt(data$y[row_nr])
  } 
})


# vectorize where possible
system.time({
  data$result <- exp(data$x) / log(data$z) + 
    5 * sqrt(data$y)
})



# split and apply
#...........................
# a function to apply to a (subset of) the data drame 
# note that the first argument in do_glm is the data, rather than the formula
do_glm <- function(data, formula, ...) glm(formula, data = data, ...)

# do_glm does exactly what glm() does
glm(as.factor(books) ~ pared, data = pisa, family = binomial)
do_glm(data = pisa, as.factor(books) ~ pared, family = binomial)

# we can apply do_glm to the pisa data
do_glm(pisa, as.factor(books) ~ pared, family = binomial)

# but we can also apply it to subsets of the data
# split creates subsets
?split
pisa_school <- split(pisa, pisa$schtype)
class(pisa_school)
length(pisa_school)
names(pisa_school)
class(pisa_school[[1]])

# apply do_glm to all splits/subsets
results_split <- lapply(pisa_school, do_glm, formula = as.factor(books) ~ pared, family = binomial)
names(results_split)
results_split$`Gymnasium (academic track)`

# combine results
sapply(results_split, coef)


# Exercises
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







