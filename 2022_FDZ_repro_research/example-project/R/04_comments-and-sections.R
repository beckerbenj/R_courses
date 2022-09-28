## Start each Rscript with a comment that explains 
##  what the code in the script does, why it does 
##  this, and to which project it belongs. 
##  Your future self will be very thankful!
##
## Mention which packages you are using in this Rscript.




## Use sections to separate chunks ----------------------

# Use hash tags to add comments to your code.


# read data
data <- readxl::read_xlsx("Data\\example-data.xlsx")

dat <- as.matrix(data[-c(2:3)])

# add random missing
which_99 <- cbind(sample(nrow(dat), 50, replace = FALSE), 
                  sample(ncol(dat), 50, replace = TRUE))
which_999 <- cbind(sample(nrow(dat), 50, replace = FALSE), 
                  sample(ncol(dat), 50, replace = TRUE))
dat[which_99] <- 99
dat[which_999] <- 999



## Maybe even subsections ===============================

## Recode variables so that missings are coded as "NA"
dat[dat %in% c(99, 999)] <- NA  # missings coded 99 or 999


# proportion missing responses
round(apply(dat, 2, function(col) sum(is.na(col))/length(col)), 2)

