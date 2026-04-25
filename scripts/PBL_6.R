# let's have a look at how the data is organized in the dataframe.
d1 <- read.csv("data/loyn2.csv")
head(d1) # this command tells R to show just the top few rows of the dataframe.

# before we fit the model let's explore the data graphically
plot(d1)
mtext(text="Fig. 1.",at = 0,cex=1.5,line = 2,adj = 0)

# Now let's fit a linear model to the data and have a look at one output
m1 <- lm(abundance~c_Log10Area*c_graze,data=d1)
plot(m1$residuals~m1$fitted.values,xlab="fitted values",ylab="residuals")
abline(h=0,lty=3)
mtext(text="Fig. 2",at = -3,cex=1.8,line=1.5)

# let us look at another model diagnostic
library(car) # this R package will help
vif(m1) # calculates Variance Inflation Factors for all variables in the model

summary(m1)
