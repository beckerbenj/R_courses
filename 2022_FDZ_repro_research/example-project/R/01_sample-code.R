2 + 4
x <- 1:10
y <- rnorm(10)
my_data <- data.frame(x, y)
View(my_data)
?lm
lin_mod <- lm(y ~ x, data = my_data)
summary(lin_mod)
plot(lin_mod)