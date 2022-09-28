## read data
dat <- haven::read_sav("Data\\example-SPSS-data.sav")


## preprocess data -------

# check missing responses per item
prop_missing <- sapply(dat, function(col) sum(is.na(col)) / length(col))
prop_missing[which(prop_missing > .2)]


# remove variable with more than 20% missing
dat <- dat[, which(prop_missing < .2)]


saveRDS(dat, "Data\\dat_raw.RDS")
rm(list = ls())
