library(ggplot2)

## read data
dat_analysis <- readRDS("Data\\data_analysis.RDS")


## make figure 1 ----
fig_1 <- ggplot(dat_analysis, aes(x = Q_B, y = Q_A)) +
  geom_point(aes(color = Q_C)) +
  geom_smooth(formula = y ~ x, method = "lm") + 
  geom_hline(yintercept = 0) + 
  geom_vline(xintercept = 0)
print(fig_1)

# save figure
tiff("Figures\\Figure-1.tiff",  units="in", width = 5, height = 4, res = 300)
print(fig_1)
dev.off()



## make figure 2 ----
fig_2 <- ggplot(dat_analysis, aes(x = Q_C, y = Q_A)) +
  geom_point(aes(color = Q_B)) +
  geom_smooth(formula = y ~ x, method = "lm") + 
  geom_hline(yintercept = 0) + 
  geom_vline(xintercept = 0)
print(fig_2)

# save figure
tiff("Figures\\Figure-2.tiff",  units="in", width = 5, height = 4, res = 300)
print(fig_2)
dev.off()


## make figure 3 ----
new_dat <- expand.grid(Q_C = quantile(dat_analysis$Q_C, c(.20, .80)),
                       Q_B = seq(min(dat_analysis$Q_B), 
                                 max(dat_analysis$Q_B), length.out = 40))

dat_plot <- cbind(new_dat, predict(lm_1, newdata = new_dat,  interval = "confidence"))
dat_plot$Q_C_f <- round(dat_plot$Q_C, 2)

fig_3 <- ggplot(dat_analysis, aes(x = Q_B, y = Q_A)) +
  geom_point(aes(color = Q_C)) +
  scale_color_gradient(low = "yellow", high = "darkblue") + 
  geom_line(data = dat_plot, aes(x = Q_B, y = fit, color = Q_C_f, group = Q_C_f), size = 1.25) + 
  theme_bw() +
  labs(title = "Prediction of Q_A by Q_B and Q_C",
       x = "Q_B (z-transformed)",
       y = "Q_A (z-transformed)",
       color = "Q_C \n(z-transformed)")


# save figure
tiff("Figures\\Figure-3.tiff",  units="in", width = 5, height = 4, res = 300)
print(fig_3)
dev.off()
