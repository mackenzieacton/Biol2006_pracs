# Load library package
library(tidyverse)

# Read in flying fox data
dat <- read_csv("data/flying_fox.csv")

# Check data structure and that predictors are mean-centred (means ~0)
summary(dat)
pairs(dat, upper.panel = panel.smooth)

library(car)

# Starting Model
model <- lm(viral_load ~ social_contacts * foraging_distance * body_condition, 
            data = dat)
summary(model)

 # The data is already centred, which helps VIF interpretation with interactions
 vif(model)  # your full model
 # Rule of thumb: VIF > 10 is a problem
 
 library(DHARMa)
 plot(simulateResiduals(model))  # normality + homogeneity of variance

 # Step 1: remove the 3-way interaction
 model2 <- lm(viral_load ~ social_contacts + foraging_distance + body_condition +
                social_contacts:foraging_distance +
                social_contacts:body_condition +
                foraging_distance:body_condition,
              data = dat)
 summary(model2) 
 
 # Step 2: main effects only
 model3 <- lm(viral_load ~ social_contacts + foraging_distance + body_condition,
              data = dat)
 summary(model3)
 
 # Plot residuals vs fitted values from your final model
 plot(model3, which = 1)

 # Display both plots in one figure (1 row, 2 columns)
 par(mfrow = c(1, 2))
 
 # --- Plot 1: social contacts ---
 
 # Scatter plot of viral_load vs social_contacts
 plot(viral_load ~ social_contacts, data = dat,
      pch = 16,
      col = "grey40",
      xlab = "Social contacts (number of unique contacts per night, mean-centred)",
      ylab = "Viral load (RNA copies per mL)",
      main = "")
 
 # Add the fitted regression line
 # Other predictors (foraging_distance, body_condition) held at their mean = 0
 curve(cbind(1, x, 0, 0) %*% coef(model3),
       add = TRUE,
       col = "firebrick",
       lwd = 2)
 
 
 # --- Plot 2: body condition ---
 # Scatter plot of viral_load vs body_condition
 plot(viral_load ~ body_condition, data = dat,
      pch = 16,
      col = "grey40",
      xlab = "Body condition (mass:forearm length ratio, mean-centred)",
      ylab = "Viral load (RNA copies per mL)",
      main = "")
 
 # Add the fitted regression line
 # Other predictors (social_contacts, foraging_distance) held at their mean = 0
 curve(cbind(1, 0, 0, x) %*% coef(model3),
       add = TRUE,
       col = "steelblue",
       lwd = 2) 
 
 # Reset to single plot layout
 par(mfrow = c(1, 1)) 
 
 