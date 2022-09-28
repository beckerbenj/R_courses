# install package
install.packages("car")
install.packages("effects")
install.packages("dplyr")
install.packages("readxl")
install.packages("haven")


# load package
?Anova
library(car)
?Anova


# unload package
detach("package:car")
?Anova


# direct access
?car::Anova


# packages can use the same name for different functions
?filter
library(dplyr)
?filter


x <- 1:100
filter(x, rep(1, 3))


# avoid errors via direct access
stats::filter(x, rep(1, 3))


# get your session information
#  R version
#  loaded packages (with version)
sessionInfo()



