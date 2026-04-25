library(tidyverse) # includes ggplot
dat <- read_csv("Data/OutlookFish.csv") # Read in data file
head(dat) # Display first few lines of the tibble (a dataframe with more attributes)
str(dat) # Show tibble structure

# Rename variables to make them easier to read and remember
dat <- dat %>% rename(Year = year,
                      Transect = transect_id,
                      Site = site_id,
                      Lat = lat,
                      Lon = lon,
                      Facies = facies,
                      Reef = reef_name,
                      CoralCover = plhcoral,
                      Family = family,
                      Species = scientific_name,
                      Length = length_cm,
                      Weight = av.weight.g,
                      Count = animal_count)
names(dat)

# Only geom_point first
ggplot() +
  geom_point()

# Specify dataset, aesthetics (variables to be plotted), and geom (i.e., use points)
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight))

# Add colour :)
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight),
             colour = "blue")
# Make points blue ... or maybe not!
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight),
             colour = "blue")

# Make points blue ... or maybe not!
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight,
                 colour = "blue"))

# Colour-coded points according to family!
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight,
                 colour = Family))

# Different geoms in one call!
ggplot() +
  geom_violin(data = dat,
              aes(x = Facies,
                  y = Length)) +
  geom_point(data = dat,
             aes(x = Facies,
                 y = Length),
             position = "jitter",
             alpha = 0.05) +
             labs(y = "Length (m)")

# Saving and sizing plot
ggsave(filename = "Output/Plot1.png", width = 8, height = 3, dpi = 300)

# Better sizing
ggsave(filename = "Output/Plot2.png", width = 10, height = 8, dpi = 300)

# Adding fitted lines
ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight)) +
  geom_smooth(data = dat,
              aes(x = Length,
                  y = Weight))

# Facets
p1 <- ggplot() +
  geom_point(data = dat,
             aes(x = Length,
                 y = Weight))
p1

p1 +
  facet_wrap(vars(Family))

p1 +
  geom_smooth(data = dat,
              aes(x = Length,
                  y = Weight)) +
  facet_wrap(vars(Family), ncol = 4)

