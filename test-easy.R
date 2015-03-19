
library(dplyr)
library(ggplot2)
library(animint)

# loading ebola data
load("data/lib_ebola.RData")            ## contains one tbl_df called lib_ebola
ani_dat <- lib_ebola %>% 
  select(Date:Location, Total_suspected_cases) %>% 
  filter(Location != "National", !is.na(Total_suspected_cases)) %>% 
  mutate(Date = as.numeric(Date)) %>%   ## have to convert date to numeric
  data.frame()                          ## have to drop tbl_df class for animint

# getting coordinates of Liberia
load("data/Liberia-coordinates.RData")  ## contains one tbl_df call coords

# plotting -------------------------------------------------

# over time
p_time <- ggplot() + 
  make_tallrect(data = ani_dat, "Date") + 
  geom_line(aes(x = Date, y = Total_suspected_cases, group = Location, colour = Location), 
            data = ani_dat) + 
  scale_x_continuous(breaks = c(1.405e9, 1.41e9, 1.415e9), 
                     labels = c("July", "September", "November")) + 
  theme_animint(width = 350) + 
  ggtitle("Ebola Cases in Liberia in 2014") + 
  ylab("Cumulative Suspected Cases")
# map
p_map <- ggplot() + 
  geom_path(aes(x = long, y = lat, group = group), 
            data = coords, alpha = I(.5), colour = "grey", size = I(.1)) + 
  geom_point(aes(x = lon, y = lat, size = Total_suspected_cases, colour = Location, 
                 showSelected = Date), 
             data = ani_dat, alpha = I(.7)) + 
  scale_size_continuous(range = c(1, 10)) + 
  ggtitle("Ebola Cases in Liberia") + 
  xlab("Longitude") + 
  ylab("Latitude")

# animint
ani_list <- list(timeLine = p_time, 
                 ebolaMap = p_map, 
                 time = list(variable = "Date", ms = 1000))
animint2dir(ani_list, out.dir = "ebola_viz", open.browser = FALSE)
servr::httd("ebola_viz")

