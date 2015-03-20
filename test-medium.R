
library(ggplot2)
library(animint)
library(dplyr)
set.seed(42)

brownian_data <- function(niter = 100, npoints = 10) {
  # niter is the number of iterations to run
  # npoints is the number of points to visualize
  dat <- data_frame(iter = rep(1:niter, npoints), 
                    point = factor(rep(1:npoints, each = niter))) %>% 
    group_by(point) %>% 
    mutate(x = cumsum(rnorm(niter)), 
           y = cumsum(rnorm(niter))) %>% 
    ungroup()
}

# location at each iteration
plot_dat <- brownian_data(niter = 10)
p <- ggplot() + 
  geom_point(aes(x = x, y = y, colour = point, showSelected = iter, 
                 label = point), data = plot_dat) + 
  geom_text(aes(x = x, y = y, colour = point, showSelected = iter, 
                label = point), data = plot_dat) + 
  ggtitle("Brownian Motion in Two Dimensions")

# total displacement
disp <- plot_dat %>% 
  group_by(point) %>% 
  mutate(x_disp = lag(x) - x, 
         y_disp = lag(y) - y, 
         disp_sum = sqrt(x_disp ^ 2 + y_disp ^ 2), 
         disp_sum = ifelse(is.na(disp_sum), 0, disp_sum), 
         tot_disp = cumsum(disp_sum)) %>% 
  ungroup() %>% 
  select(point, iter, tot_disp) %>% 
  data.frame()
p_disp <- ggplot() + 
  make_tallrect(data = disp, "iter", alpha = I(.2)) + 
  geom_line(aes(x = iter, y = tot_disp, group = point, colour = point), 
            data = disp) + 
  scale_x_continuous(name = "Iteration", 
                     breaks =  1:10) + 
  labs(y = "Total Displacement", title = "Cumulative Displacement")

# to animint --------------------------------------

animint2dir(list(location = p, 
                 displacement = p_disp, 
                 time = list(variable = "iter", ms = 1000), 
                 duration = list(iter = 250)), 
            out.dir = "brownian_motion", open.browser = FALSE)
servr::httd("brownian_motion")

# not working
animint2gist(list(plot = p, 
                  time = list(variable = "iter", ms = 1000), 
                  duration = list(iter = 250)), 
             out.dir = "brownian_motion", 
             description = "A Demonstration of Brownian Motion")
