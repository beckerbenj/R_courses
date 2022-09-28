## read data
dat_analysis <- readRDS("Data\\data_analysis.RDS")


## fit linear models
# no interaction
lm_1 <- lm(Q_A ~ Q_B + Q_C, data = dat_analysis)
summary(lm_1)


# with interaction
lm_2 <- lm(Q_A ~ Q_B * Q_C, data = dat_analysis)
summary(lm_2)
anova(lm_1, lm_2)


plot(lm_2)
