library(tidyverse)
library(janitor)
theme_set(theme_bw())

# To run this script, you'll first need to download the correct datasets from
# NYC's open data portal:
# https://data.cityofnewyork.us/Public-Safety/NYPD-Calls-for-Service-Historic-/d6zx-ckhd/about_data
# https://data.cityofnewyork.us/Public-Safety/NYPD-Calls-for-Service-Year-to-Date-/n2zq-pubd/about_data
# Then place these datasets in a new folder at the project root called "data",
# and run this script from the project root.

# Note: it took me about 64gb of RAM to run this script. (911 data is big!)
# If you don't have that much RAM available, you might consider using the 
# `arrow` R library to perform some of these functions more efficiently.

# Import dataset ---------------------------------------------------------------
raw_historic  <- read_csv("data/NYPD_Calls_for_Service_(Historic).csv",
                          col_types = cols(.default = col_character())) |> 
  clean_names()
raw_this_year <- read_csv("data/NYPD_Calls_for_Service_(Year_to_Date).csv",
                          col_types = cols(.default = col_character())) |> 
  clean_names()

raw_data <- bind_rows(raw_historic,
                      raw_this_year)


# Dataset statistics -----------------------------------------------------------
# Size of combined dataset (51,381,582)
raw_data |> count()

# Year range of data (2018--2025)
raw_data |> 
  mutate(create_date = mdy(create_date)) |> 
  count(year(create_date)) |> 
  print(n = Inf)


# Policy change chart ----------------------------------------------------------
data <- raw_data |> 
  filter(radio_code == "75M") |> 
  mutate(
    create_date = mdy(create_date),
    create_month = floor_date(create_date, unit = "month"),
    add_timestamp = ymd_hms(add_ts),
    # This extra line handles differently formatted timestamps from 2025
    add_timestamp = coalesce(add_timestamp, mdy_hms(add_ts))
  ) |> 
  relocate(create_month, add_timestamp, .after = create_date)
  
plot_data <- data |> 
  filter(
    add_timestamp >= "2019-09-01",
    hour(add_timestamp) >= 21 | hour(add_timestamp) < 5
  ) |> 
  mutate(pre_post = if_else(create_month < "2025-01-15",
                            "Pre-announcement",
                            "Post-announcement")) |> 
  count(create_month, 
        pre_post)

# Pre average: 7,335
# Post average: 15,324
plot_data |> 
  group_by(pre_post) |> 
  summarize(mean(n))

output <- plot_data |> 
  ggplot(aes(x = create_month,
             y = n,
             group = pre_post)) +
  geom_smooth(method = "lm",
              color = "tomato",
              formula = "y ~ 1") +
  geom_point() + geom_line() +
  geom_vline(xintercept = ymd("2025-01-15"), 
             linetype = "dashed") + 
  annotate(geom = "text", 
           label = "Policy change", 
           y = 2500, 
           x = ymd("2024-12-15"),
           hjust = 1
           ) + 
  scale_x_date(name = "", 
               labels = scales::date_format(format = "%b %Y"),
               limits = c(ymd("2019-01-01"), NA),
               date_breaks = "6 months",
               date_labels = "%b '%y",
               expand = c(0.08, 0.08)
  ) +
  coord_cartesian(xlim = c(ymd("2020-01-01"), NA)) +
  scale_y_continuous(limits = c(0, NA), 
                     labels = scales::comma,
                     name = "Train patrol calls / month") 

ggsave("src/train_patrols.png", 
       output, 
       width = 7.5, height = 5, 
       units = "in")
         

browseURL('https://www.youtube.com/watch?v=dQw4w9WgXcQ%27')
