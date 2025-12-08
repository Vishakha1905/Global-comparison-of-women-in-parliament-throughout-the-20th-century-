# downloading all the required packages
library(tidyverse)
library(ggplot2)
library(dplyr)
library(magrittr)
library(gganimate)
library(gifski)

# loding data
countries_by_share_of_women_in_parliament <- read_csv("countries-by-share-of-women-in-parliament.csv")

#rename the dataset in the environment
women_data <- countries_by_share_of_women_in_parliament

#rename the columns
women_data <- read.csv("countries-by-share-of-women-in-parliament.csv")
summary(women_data) 
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.0.10..women.in.parliament"] <- "NoC0_10"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.10.20..women.in.parliament"] <-"NoC10_20"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.20.30..women.in.parliament"] <- "NoC20_30"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.30.40..women.in.parliament"] <- "NoC30_40"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.40.50..women.in.parliament"] <- "NoC40_50"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.50...women.in.parliament"] <- "NoC50+"
colnames(women_data)[colnames(women_data) == "Number.of.countries.with.no.women.in.parliament"] <- "No.Women.In.Parliament"

#getting rid of unneeded columns

women_data<- women_data %>% 
  select(-Code)


# first line plot
library(ggplot2)
library(dplyr)
ggplot(women_data, aes(x = Year, 
                         y = No.Women.In.Parliament, 
                         color = Entity, 
                         group = Entity)) +
  geom_line(size = 1) +
  labs(title = "Women in Parliament by Continent Over Time",
       x = "Year",
       y = "Number of Women in Parliament",
       color = "Entity") +
  theme_minimal()

#second graph 
library(ggplot2)
library(dplyr)
ggplot(women_data, aes(x = Year,
                         y = No.Women.In.Parliament,
                         fill = Entity)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Entity, scales = "free_y") +
  labs(title = "Women in parliament by continent over time",
       x = "Year",
       y = "NO.Women.In.Parliament") +
  theme_minimal()



# animated graph code
library(gifski)
library(magrittr)
library(gganimate)
p <- ggplot(women_data, aes(x = Year,
                              y = No.Women.In.Parliament,
                              color = Entity,
                              group = Entity)) +
  geom_line(size = 1) +
  labs(title = "Women in Parliament by Continent Over Time",
       subtitle = "Year: {frame_along}",
       x = "Year",
       y = "No. Women in Parliament",
       color = "Entity") +
  theme_minimal()

animated <- p +
  transition_reveal(Year)

animated
animate(animated, fps = 4, width = 800, height = 500)
        
