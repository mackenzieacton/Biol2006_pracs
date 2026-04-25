# Load library package
library(tidyverse)

# Read in flying fox data
dat <- read_csv("data/flying_fox.csv")

# Inspect structure and check for missing values or anything unexpected
str(dat)
summary(dat)
head(dat)