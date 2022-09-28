## read data
dat <- readRDS("Data\\dat_raw.RDS")
scale_names <- paste0("Q_", c("A", "B", "C"))


## Item analysis
# index of column numbers for each scale
scale_index <- structure(lapply(scale_names, function(scale_name) {
  which(startsWith(names(dat), scale_name))}), 
  names = scale_names)


# data split per scale
dat_split <- lapply(scale_index, function(col_nrs) {
  dat[, col_nrs]})


# compute polychoric correlations pre scale
polychor_split <- lapply(dat_split, function(data) psych::polychoric(data)$rho)


# compute ordinal alpha based on polychoric correlations
ord_alpha_split <- lapply(polychor_split, psych::alpha)


## remove items with item-rest correlation lower than .4
to_drop <- unlist(lapply(scale_names, function(name) {
  names(dat_split[[name]])[ord_alpha_split[[name]]$item.stats$r.drop < .4]
}))

dat <- dat[, names(dat) != to_drop]


## compute scale scores
# index of column numbers for each scale
scale_index <- structure(lapply(scale_names, function(scale_name) {
  which(startsWith(names(dat), scale_name))}), 
  names = scale_names)


# data split per scale
dat_split <- lapply(scale_index, function(col_nrs) {
  dat[, col_nrs]})


# compute scale scores
dat_analysis <- cbind(dat$ppID, as.data.frame(lapply(dat_split, rowMeans, na.rm = TRUE)))


# z-transform scale-scores
dat_analysis[, -1] <- scale(dat_analysis[, -1] )




saveRDS(dat_analysis, "Data\\data_analysis.RDS")
rm(list = ls())
