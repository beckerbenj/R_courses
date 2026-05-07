# PISA analysis using copilot autocomplete

# load PISA data
data <- readRDS("data/pisaPlus_CF.RDS")

# using the tidyverse compute the test restest reliability
# for the attitude scores (attitud_a - attitud_h)
# first compute the average attitude score for t1 and t2,
# then compute the correlation between them
# but first recode the attitude scores from Strongly disagree = -2
# to Strongly agree = 2

# create a scatter plot of attitude_t1 vs attitude_t2 with a regression
#  line and histograms on the margins. Use two different colors for the
# histograms that are distinguishable when printed in black and white,
# but also distinguishable when printed in color, for colorblind viewers.
# Use a the theme that is suitable for publication in a scientific journal.
