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
View(jaccsim)

#add a row with names to melt on
jaccsim$names <- rownames(jaccsim)
#melt the data frame to make it tidy
jacc.m <- reshape2::melt(jaccsim, id.vars = "names")

#make sure the parties are in correct order in the plot
#convert to factor
jacc.m$names <- factor(jacc.m$names, rownames(jaccsim))
jacc.m$variable <- factor(jacc.m$variable, rev(rownames(jaccsim)))
#sort the data frame
jacc.m <- plyr::arrange(jacc.m, variable, plyr::desc(names))

#ggplot
library(ggplot2)
pt <- ggplot(jacc.m, aes(names, variable)) +
      geom_tile(aes(fill=value), colour = "white") +
      scale_fill_gradient(low = "#b7f7ff", high = "#0092a3")

base_size <- 20

pt + theme_light(base_size = base_size) +
      labs(x = "", y = "") +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) +
      guides(fill=guide_legend(title=NULL)) +
      theme(axis.ticks = element_blank(),
            axis.text.x = element_text(size = base_size * 0.8,
                                       angle = 330, hjust = 0),
            axis.text.y = element_text(size = base_size * 0.8)
      )
