#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Debugging - Solutions
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




pisa <- readRDS("data/pisaPlus_CF.RDS")


# Exercises
#===========================================================
# 1. We have written a function, that determines the position of the maximum for a numeric vector. 
# However, the function sometimes throws an unexpected warning. Can you debug it?
whichMax <- function(x) {
  if(any(is.na(x))) stop("'x' can not contain missing values.")
  which(x == max(x))
}
whichMax(5)
whichMax(c(NA, 5, 4))
whichMax(1:3)


# 2. We have written a function that rounds all variables in a data.frame. When applied to
# mtcars the function seems to work well, when applied to iris it throws an error.
# Use the appropriate debugging tools to fix the function.
roundDataFrame <- function (df, roundN = 3) {
  for(i in seq_along(df)) {
    if(!is.numeric(df[, i])) next
    df[, i] <- round(df[, i], digits = roundN) 
  }
  df
}

roundDataFrame(mtcars, roundN = 1)
roundDataFrame(iris, roundN = 1)


# 3. We have written two functions to make calculating relative frequencies easier. prop_table(),
# a function that creates a simple relative frequency table and prop_table_by_all() which combines
# multiple tables for a grouping variable. The function prop_table_by_all() works fine in our first example but throws
# an error for the second one. Use your debugging skills to find the problem and fix the function.
prop_table <- function (vec, useNA = "no", round_perc = 1) {
  stopifnot(is.vector(vec) || is.factor(vec))
  tab <- round(100 * prop.table(table(vec, useNA = useNA)), 
               digits = round_perc)
  out_df <- as.data.frame(as.list(tab))
  names(out_df) <- names(tab)
  out_df
}


prop_table_by_all <- function (df, dep, by_var, useNA = "no", round_perc = 1) {
  stopifnot(is.data.frame(df))
  stopifnot(is.character(dep) && length(dep) == 1)
  stopifnot(is.character(by_var) && length(by_var) == 1)

  if(is.character(df[, dep])) df[, dep] <- as.factor(df[, dep])
  out_list <- by(df, INDICES = df[, by_var], function(df) prop_table(df[, dep], useNA = useNA))
  out <- do.call(rbind, out_list)
  rownames(out)[nrow(out)] <- "Total"
  out
}

prop_table(pisa$migration)
prop_table(pisa$books)
prop_table(pisa$grade_bio_t1)

prop_table_by_all(pisa, dep = "books", by_var = "migration")
prop_table_by_all(pisa, dep = "grade_bio_t1", by_var = "books")




