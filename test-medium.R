
library(ggplot2)
library(animint)
library(dplyr)
set.seed(42)

brownian_data <- function(niter = 100, npoints = 10) {
  # niter is the number of iterations to run
  # npoints is the number of points to visualize
  dat <- data_frame(iter = factor(rep(1:niter, npoints)), 
                    point = factor(rep(1:npoints, each = niter))) %>% 
    group_by(point) %>% 
    mutate(x = cumsum(rnorm(niter)), 
           y = cumsum(rnorm(niter))) %>% 
    ungroup()
}

plot_dat <- brownian_data(niter = 10)
p <- ggplot() + 
  geom_point(aes(x = x, y = y, colour = point, showSelected = iter, 
                 label = point), data = plot_dat) + 
  geom_text(aes(x = x, y = y, colour = point, showSelected = iter, 
                label = point), data = plot_dat) + 
  ggtitle("Brownian Motion in Two Dimensions")
p
animint2dir(list(plot = p, 
                 time = list(variable = "iter", ms = 1000), 
                 duration = list(iter = 250)), 
            out.dir = "brownian_motion", open.browser = FALSE)
servr::httd("brownian_motion")
