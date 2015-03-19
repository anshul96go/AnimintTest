
library(ggplot2)
library(animint)
library(dplyr)
library(testthat)
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
a <- animint2dir(list(plot = p, 
                 time = list(variable = "iter", ms = 1000), 
                 duration = list(iter = 250)), 
            out.dir = "brownian_motion", open.browser = FALSE)

test_that("Both points and text are present", {
  expect_equal(length(a$plots$plot$geoms), 2)
  expect_true(substr(a$plots$plot$geoms[[1]], 7, 11) %in% c("point", "text_"))
  expect_true(substr(a$plots$plot$geoms[[2]], 7, 11) %in% c("point", "text_"))
})

test_that("legend displays properly", {
  # correct length
  expect_equal(length(a$plots$plot$legend$point$entries), n_distinct(plot_dat$point))
  # two geoms
  expect_equal(length(a$plots$plot$legend$point$geoms), 2)
  # correct point names
  point_names <- sapply(a$plots$plot$legend$point$entries, function(x) x$label)
  expect_true(all(point_names %in% unique(as.character(plot_dat$point))))
  expect_true(all(unique(as.character(plot_dat$point)) %in% point_names))
  # color of points matches color of text
  expect_true(all(sapply(a$plots$plot$legend$point$entries, 
                         function(x) x$pointcolour == x$textcolour)))
  # distinct colors
  color_vals <- sapply(a$plots$plot$legend$point$entries, function(x) x$pointcolour)
  expect_equal(n_distinct(color_vals), length(color_vals))
})

test_that("proper title", {
  expect_equal(a$plots$plot$title, "Brownian Motion in Two Dimensions")
})