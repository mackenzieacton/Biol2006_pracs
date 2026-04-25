# Preliminaries
library(tidyverse)
dat <- read_csv("data/ZooBiomass.csv")
head(dat) # Look at the top of the tibble; looks OK
glimpse(dat) # Check the structure

# Plot the data to look at it
ggplot() +
  geom_point(data = dat,
             aes(x = Depth, y = Biomass))

# A simple linear model: y = a + bx
m1 <- lm(Biomass ~ Depth, data = dat) # Read this as "Biomass as a function of Depth"

# Examine coefficients of the model
summary(m1)

# ANOVA table showing SS
anova(m1)

# Extract slope and intercept
intercept <- coef(m1)[1] # Intercept (b0)
slope <- coef(m1)[2] # Slope (b1)
# Plot regression line
ggplot() +
  geom_point(data = dat,
             aes(x = Depth, y = Biomass)) +
  geom_abline(intercept = intercept, slope = slope) +
  labs(x = "Depth (m)", y = "Zooplankton biomass (dry weight.m-3)")

# Easier plotting of predictions using package marginaleffects
library(marginaleffects)
plot_predictions(m1, condition = "Depth") +
geom_point(data = dat,
           aes(x = Depth, y = Biomass))

# Plot model diagnostics (using base graphics)
plot(m1)

# Plot model diagnostics using package gglm
library(gglm)
gglm(m1)

# A log-transformed model of the response
m2 <- lm(log10(Biomass) ~ Depth, data = dat)
summary(m2)

# Plot the model predictions
plot_predictions(m2, condition = "Depth") +
  geom_point(data = dat,
             aes(x = Depth, y = log10(Biomass))) # Take log10 transformation of raw da

# Function to back calculate the response
antilog <- function(x){return(10^x)}
# Plot model predictions
plot_predictions(m2, condition = "Depth", transform = antilog) +
  geom_point(data = dat,
             aes(x = Depth, y = Biomass))

# Examine diagnostic plots
gglm(m2)
