# Load required libraries
library(tidyverse)
library(car)

# Read in flying fox dataset containing viral load and three predictor 
# variables (social contacts, foraging distance, body condition) for 
# 120 P. scapulatus individuals
dat <- read_csv("data/flying_fox.csv")

# Inspect data structure and confirm predictor variables are mean-centred 
summary(dat)

# Assess linearity assumption visually -> examine relationship between viral 
# load and each predictor variable in the top row of the scatterplot matrix.
# Smooth lines with no obvious curves indicate linear relationships (Figure 1)
pairs(dat, upper.panel = panel.smooth)

# Fit the fully saturated initial model provided, including all main effects 
# and two-way and three-way interactions between social contacts, foraging 
# distance and body condition as predictors of viral load in P. scapulatus
model <- lm(viral_load ~ social_contacts * foraging_distance * body_condition, 
            data = dat)
summary(model)

# Assess independence of predictor variables (collinearity assumption) using 
# Variance Inflation Factors (VIF).
vif(model)

# Step 1 of model simplification - remove the non-significant three-way 
# interaction term (p = 0.130) following the hierarchical marginality principle,
# retaining all two-way interactions
model2 <- lm(viral_load ~ social_contacts + foraging_distance + body_condition +
               social_contacts:foraging_distance +
               social_contacts:body_condition +
               foraging_distance:body_condition,
             data = dat)
# Examine output to assess significance of remaining two-way interactions -
# all interaction terms remain non-significant (p > 0.41). Model 2 not reported 
# in results as it is an intermediate simplification step only
summary(model2)

# Step 2 of model simplification - remove all non-significant two-way 
# interaction terms following the hierarchical marginality principle.
model3 <- lm(viral_load ~ social_contacts + foraging_distance + body_condition,
             data = dat)
# Final model summary used to extract all reported statistics.
summary(model3)

# Assess normality assumption of final model residuals by plotting against 
# theoretical quantiles from a normal distribution. Points following the 
# 1:1 line indicate normally distributed residuals (Figure 2)
qqnorm(model3$residuals,
       main = "", ylab = "Residuals from Model 3")
qqline(model3$residuals)

# Assess homogeneity of variance and linearity assumptions of final model 
# by plotting residuals against fitted values. No systematic pattern or 
# fanning indicates assumptions are met (Figure 3)
plot(model3, which = 1)

# Set plot layout to display social contacts and body condition relationships 
# side by side as a single figure (Figure 4)
par(mfrow = c(1, 2))

# Figure 4A - Plot viral load against social contacts for all 120 P. scapulatus
# individuals. 
plot(viral_load ~ social_contacts, data = dat,
     pch = 16,
     col = "grey40",
     xlab = "Social contacts (number of unique contacts per night, mean-centred)",
     ylab = "Viral load (RNA copies per mL)",
     main = "")

# Add predicted regression line for social contacts from final model
curve(cbind(1, x, 0, 0) %*% coef(model3),
      add = TRUE,
      col = "firebrick",
      lwd = 2)

# Figure 4B - Plot viral load against body condition for all 120 P. scapulatus
# individuals.
plot(viral_load ~ body_condition, data = dat,
     pch = 16,
     col = "grey40",
     xlab = "Body condition (mass:forearm length ratio, mean-centred)",
     ylab = "Viral load (RNA copies per mL)",
     main = "")

# Add predicted regression line for body condition from final model
curve(cbind(1, 0, 0, x) %*% coef(model3),
      add = TRUE,
      col = "firebrick",
      lwd = 2)

# Reset plot layout to single figure
par(mfrow = c(1, 1))

