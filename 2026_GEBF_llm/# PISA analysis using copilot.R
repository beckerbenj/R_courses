# PISA analysis using copilot autocomplete

# load PISA data
data <- readRDS("data/pisaPlus_CF.RDS")

# using the tidyverse compute the test restest reliability
# for the attitude scores (attitud_a - attitud_h)
# first compute the average attitude score for t1 and t2,
# then compute the correlation between them
# but first recode the attitude scores from -2 (strongly disagree)
# to 2 (strongly agree)
