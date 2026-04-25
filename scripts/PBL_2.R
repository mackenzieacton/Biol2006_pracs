# Number of rolls
n <- 10000

# Simulate rolls
rolls <- sample(1:6, size = n, replace = TRUE)

# Frequency distribution
hist(rolls, breaks = seq(0.5, 6.5, by = 1))

# Probability distribution
hist(rolls, breaks = seq(0.5, 6.5, by = 1), probability = TRUE)

# 2 Dice
n <- 10000

die1 <- sample(1:6, n, replace = TRUE)
die2 <- sample(1:6, n, replace = TRUE)

sum_dice <- die1 + die2

hist(sum_dice, breaks = seq(0.5, 12.5, by = 1), probability = TRUE)

#Normal Distribution
n_dice <- 5 # Number of samples
n <- 500 # Rolls per sample
Parameter <- numeric(n_dice) # Initialises vector to 0s. Used to store simulation resu
for(i in 1:n_dice){
  rolls <- sample(1:6, n, replace = TRUE)
  Parameter[i] <- mean(rolls)
}
# Calculate mu and sigma for our parameter
mu <- mean(Parameter)
sigma <- sd(Parameter)
hist(Parameter, probability = TRUE)
# Superimpose a Normal curve
curve(dnorm(x, mean = mu, sd = sigma),
      add = TRUE)


# Standard Error
n <- 100 # number of samples
sample_data <- sample(1:6, n, replace = TRUE)
mean_x <- mean(sample_data)
sd_x <- sd(sample_data)
se <- sd_x / sqrt(n)
cat("n = ", n, " mean = ", mean_x, " sd = ", sd_x, " se =", se)

#Plotting Standard Error
n <- seq(2, 100, by = 1)
sigma <- 1.7 # approximate SD of a die
SE <- sigma / sqrt(n)
plot(n, SE, type = "l")

#Confidence Interval
n <- 30 # number of samples
sample_data <- sample(1:6, n, replace = TRUE)
mean_x <- mean(sample_data)
sd_x <- sd(sample_data)
se <- sd_x / sqrt(n)
# CI using t-distribution
alpha <- 0.05
t_value <- qt(1 - alpha/2, df = n - 1)
t_CI <- mean_x + c(-1, 1) * t_value * se # c(-1,1) calculates both lower and upper
# CI using Normal (i.e., assuming larger sample sizes and appealing to Central Limit T
z_value <- qnorm(1 - alpha/2)
z_CI <- mean_x + c(-1, 1) * z_value * se # c(-1,1) calculates both lower and upper
# Output to the screen
cat("alpha =", alpha, " se =", se, " CI t =", t_CI, " CI z =", z_CI)

# ggplot
library(tidyverse) # loads ggplot and other tidyverse packages

n <- 300
die1 <- sample(1:6, n, replace = TRUE)
die2 <- sample(1:6, n, replace = TRUE)
sum_dice <- die1 + die2
# Convert to data frame
df <- data.frame(sum_dice)
# Estimate mean and SD
mu <- mean(sum_dice)
sigma <- sd(sum_dice)
# Draw a pretty plot
ggplot(df, aes(x = sum_dice)) +
  geom_histogram(aes(y = after_stat(density)),
                 binwidth = 1, boundary = 0.5) +
  stat_function(fun = dnorm, args = list(mean = mu, sd = sigma)) +
  theme_bw()

