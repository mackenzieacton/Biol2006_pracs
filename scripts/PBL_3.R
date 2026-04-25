# Load library package
library(tidyverse)

# Read in fertiliser data
dat <- read_csv("data/Fertiliser.csv")

# Plot Data
ggplot(data = dat,
       aes(x = Control, y = Fertiliser)) +
  geom_point()

# Changing data from wide to long
dat_long <- dat %>%
  pivot_longer(
    cols = Control:Fertiliser,
    names_to = "treatment",
    values_to = "biomass"
  )

# Always check that your data wrangling has done what you want it to...
dat_long

# Visualise data - all OK?
ggplot(data = dat_long,
       aes(x = treatment, y = biomass)) +
  geom_boxplot() +
  geom_point()

# T-Test - 2 sided
t.test(x = dat$Fertiliser, y = dat$Control)

# T-Test - 1 Sided
# A 1-sided t-test for H1 > H0
t.test(x = dat$Fertiliser,
       y = dat$Control,
       alternative = "greater")

# t-test for paired samples
t.test(x = dat$Fertiliser,
       y = dat$Control,
       alternative = "greater",
       paired = TRUE)

# Check if shuffling results changes
dat$Fertiliser_RandOrder <- sample(dat$Fertiliser)
# t-test for paired samples
t.test(dat$Fertiliser_RandOrder, dat$Control,
       alternative = "greater",
       paired = TRUE)

