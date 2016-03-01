?dist
load("C:\\Users\\Kira\\OneDrive\\Journocode\\similarities\\jaccard.Rdata")
View(values)

#dist() calculates over rows, so we'll use t(values)
jacc <- dist(t(values), method = "binary")
#we want values for diagonal and upper as well, so:
jacc <- dist(t(values), method = "binary",
             diag = TRUE, upper = TRUE)

#ggplot needs a dataframe:
jacc <- as.data.frame(as.matrix(jacc))


#we want the jaccard similarity, not the distance:
jaccsim <- 1 - jacc