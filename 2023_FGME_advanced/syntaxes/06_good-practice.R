#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# Good Practices
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::




# Input
#===========================================================

# Computation Speed - run time analysis
# ...........................................
n <- 2e+4
data <- data.frame(x = runif(n), 
                   y = runif(n), 
                   z = seq_len(n))



# DON'T grow
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


# replace instead
system.time({
  n_rows <- dim(data)[1]
  data$result <- rep(NA, n_rows)
  
  for(row_nr in seq_len(n_rows)){
    data$result[row_nr] <- exp(data$x[row_nr]) / 
      log(data$z[row_nr]) + 
      5 * sqrt(data$y[row_nr])
  } 
})


# when possible, vectorize
system.time({
  data$result <- exp(data$x) / log(data$z) + 
    5 * sqrt(data$y)
})


# Compare function-speed
# ......................

# naive approach
get_mean1 <- function(x){
  weight <- 1/length(x)
  out <- 0
  for(i in seq_along(x)){
    out <- out + x[i] * weight 
  }
  return(out)
}

# slim approach
get_mean2 <- function(x){
  sum(x)/length(x)
}

# microbenchmark
x <- rnorm(500)
microbenchmark::microbenchmark(
  mean(x), get_mean1(x), get_mean2(x))

