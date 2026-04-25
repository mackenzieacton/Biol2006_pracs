# Load library package
library(tidyverse)

# Read in flying fox data
dat <- read_csv("data/flying_fox.csv")

# Check data structure and that predictors are mean-centred (means ~0)
summary(dat)
pairs(dat, upper.panel = panel.smooth)

library(car)
# The data is already centred, which helps VIF interpretation with interactions
vif(model)  # your full model
# Rule of thumb: VIF > 10 is a problem

library(DHARMa)
plot(simulateResiduals(model))  # normality + homogeneity of variance

# Starting Model
model <- lm(viral_load ~ social_contacts * foraging_distance * body_condition, 
            data = dat)
summary(model)
 plot(dat)
 