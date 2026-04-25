# Prac 1
# 24/02/2026
# Mackenzie s4801109

# section 1.2.1
example(plot)# show different plots. You need to keep pressiing enter in the console window to step through each plot, which will show up in the bottom right "Plots" panel of RStudio

# section 1.4
1 + 2 # Add 1 and 2
sqrt(1 + 2)  # Take the square root of the sum of 1 and 2
x <- (48 + 34)/5.5  # Make an R object "x" to store the result of adding 48 and 35, and dividing by 5.5
x   # Call the object "x" = show the result in the console

(9+3.3)/(10.1-4)

# section 1.5
##run this code  ONE LINE AT A TME! Otherwise it will be hard to see in the Console what code did what.
stuff <- c(6, "elephant", 4.5, 1, "cat")    # Create a vector of "stuff" with numbers and characters
stuff                # Show stuff in the R console
View(stuff)          # Show stuff as a new tab in the upper left script panel

#call specific bits of 'stuff' based on their position in the vector
stuff[2]             # This calls the second element of the vector, "stuff"
stuff[1]             # And the first. Note the "" around the 6 - R has not recognised 6 as a number
stuff[2:4]           # The 2nd, 3rd, 4th elements of "stuff"
stuff[2:4]


class(stuff)         # What type of class is "stuff"? Everything in "stuff" is recognised as a character
stuff[1] + stuff[4]  # Error message because "6" and "1" are not recognised as numbers so you cannot sum them to calculate a total (just as you cannot sum elephant and cat)

# section 1.5.1

##AGAIN - RUN THIS CODE ONE LINE AT A TIME!
stuffNumeric <- as.numeric(stuff) # There was a warning message here errors "cat" and "elephant" can't be converted to numbers, so they are prelaced with "NA"
class(stuffNumeric)  # Now it's a numeric vector!
stuffNumeric # See the NAs where "cat" and "elephant" were? R has removed them because it couldn't convert them
stuffNumeric[1] + stuffNumeric[4]   # Now this works as desired! 1 + 6 = 7
stuffFactor <- as.factor(stuff)  # Change the type to "factor"
stuffFactor  # This is similar to "stuff", but there are now levels. This is IMPORTANT. Notice that they values are now ordered - numerically then alphabetically.
stuffNumeric2 <- as.numeric(stuffFactor)  # No error! Why?
stuffNumeric2 # This is now a vector of integers; everything has changed - these numbers are the ORDER that each of our original "stuff" appeared in when we converted to a factor.
levels(stuffFactor)  # What are the levels of "stuffFactor"
stuffNumeric[3]      # is 4.5, but
stuffNumeric2[3]     # is 2! AND,
stuffNumeric2[1] + stuffNumeric2[4]  # no longer equals 7

# section 1.6
Owners <- c("Sally", "Harry", "Beth", "Roger") # Vector of people's names
Pets <- c("dog", "lizard", "bird", "cat")      # Vector of the type of pet each person has
OwnersPets <- cbind(Owners, Pets)  # cbind concatenates these two vectors as columns - each row will have both an Owner and Pet name
OwnersPets        # Have a look at it
str(OwnersPets)   # Check the class - here we've used "str" which is useful when you have multiple variables, or columns in your data
dim(OwnersPets)   # the command "dim" returns the dimensions (rows and columns) of our object         
OwnersPets.df<- data.frame(cbind(Owners, Pets))    # Column bind the results
OwnersPets.df         # Have a look at it
str(OwnersPets.df)    # Check the structure

# section 1.7
#RUN THIS CODE ONE LINE AT A TIME
women
View(women)
women$height
women$weight
height 
with(women, height)
plot(women$height, women$weight)
plot(women$weight, women$height)
with(women, plot(height, weight, type = "l"))
plot(women$height, women$weight, type = "b", col = "red", bty = "l", cex = 2, xlab = "Height",ylab = "Weight")

# section 1.8
zebrafish <- read.csv("data/zebrafish.csv",header=T)

zebrafish               # Look at the entire data set
names(zebrafish)        # List the variables (the column names)
head(zebrafish, n = 4)  # Look at the first 4 rows of the data
tail(zebrafish, n = 4)  # Look at the last 4 rows of the data
dim(zebrafish)          # How many rows and columns are there?

# section 1.9
str(zebrafish)              # Note that sex_nr is an integer variable
sex_nr <- as.factor(sex_nr) # Tell R to treat the variable sex_nr as a factor
str(zebrafish)              # Check if it did as you asked

# section 1.10
zebrafish[2, 4]
zebrafish[, 2]
zebrafish[2, ]
zebrafish[, 1:3]
zebrafish[zebrafish$TotalLength > 30, ]
with(zebrafish, zebrafish[sex_nr == 1, ])
zebrafish$sex_nr
zebrafish[, "sex_nr"]

# section 1.11
pairs(zebrafish[, 6:9]) # Plot variables against other variables (variables in columns 6, 7, 8, and 9)
plot(zebrafish$TotalLength, zebrafish$SwimSpeed)# Plot 'TotalLength' (x-axis) against 'SwimSpeed' (y-axis)
plot(zebrafish$TotalLength, zebrafish$SwimSpeed, type = "n",  # Set up a blank graph with axes
     xlab = "Fish length (mm)", ylab = "Fish swimming speed")  # Add axis labels

with(zebrafish, points(TotalLength[sex_nr == 1], SwimSpeed[sex_nr == 1])) # Insert the points for the 1st sex
with(zebrafish, points(TotalLength[sex_nr == 2], SwimSpeed[sex_nr == 2], col = "red")) # Insert the points for the 2nd sex in red

plot(zebrafish$TotalLength, zebrafish$SwimSpeed, type = "n", bty = "l")  # Remove the surrounding box type
plot(zebrafish$TotalLength, zebrafish$SwimSpeed, xlab = "Fish length (mm)", 
     ylab = "Fish swimming speed", cex.axis = 1.5, cex.lab = 1.5)  # The "cex" (= character expand) command controls the sizes of characters

# section 1.12
install.packages("praise")  # This installs the package to your default 'library'
library(praise)  # This command loads the 'praise' package
require(praise)  # This also loads the 'praise' package

# section 1.13
rm(zebrafish)       # Removes the named object from R
rm(list = ls())    # remove all data objects, variables and coded functions from R's memory
