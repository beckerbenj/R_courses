#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#
# generate data
# 
#::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

n <- 542
set.seed(1457)
example_data <- data.frame(
  age = sample(18:60, size = n, replace = TRUE),
  gender = factor(sample(c("M", "V", "X", NA), 
                  size = n, replace = TRUE,
                  prob = c(.32, .59, .02, .07))),
  group = factor(sample(c("control", "group 1", "group 2"), 
                        size = n, replace = TRUE)),
  exog_1 = rnorm(n, 5, 2),
  flet_1 = runif(n, 60, 98),
  meti_2 = round(rnorm(n, 120, 30))
)

summary(example_data)

write.csv2(example_data, file = ".//data//example-data.csv", row.names = FALSE)
