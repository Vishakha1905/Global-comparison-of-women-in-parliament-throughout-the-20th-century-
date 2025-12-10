# downloading all the required packages
library(tidyverse)
library(ggplot2)
library(dplyr)
library(magrittr)
library(gganimate)
library(gifski)

# loading data
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

# Reshape the data from wide (6 count columns) to long format
women_data_long <- women_data %>%
  pivot_longer(
    cols = c(NoC0_10, NoC10_20, NoC20_30, NoC30_40, NoC40_50, `NoC50+`), 
    names_to = "Percentage",      
    values_to = "Countries"        
  )

#first 
ggplot(women_data_long, 
       aes(x = Year, 
           y = Countries, 
           color = Percentage,
           group = Percentage)) + # Must include group
  
  geom_line(size = 1) +
  labs(title = "Count Trend of Countries in Each Percentage Bin",
       y = "Count of Countries",
       color = "Percentage") +
  theme_minimal()

# second line graph 
library(ggplot2)
library(dplyr)
ggplot(women_data_long, aes(x = Year,
                         y = Countries,
                         fill = Percentage)) +
  geom_bar(stat = "identity") +
  labs(title = "Women in parliament by continent over time",
       x = "Year",
       y = "Countries") +
  theme_minimal()

#third, all the graphs
ggplot(women_data_long, 
       aes(x = Year, 
           y = Countries, 
           fill = Percentage)) + # Use 'fill' to define the stacked layers
  
  # 1. Add the stacked area geometry
  geom_area(alpha = 0.8, color = "black", linewidth = 0.1) +
  
  # 2. Separate the chart into different panels for each continent
  facet_wrap(~ Entity, scales = "free_y") + 
  
  labs(title = "Global comparison of women in parliament throughout the 20th century",
       x = "Year",
       y = "Number of Countries",
       fill = "Percentage of Women(%)") +
  
  theme_minimal() 
  
#Final graph, animated
```{r}
library(ggplot2)
library(gganimate)
library(ggplot2)
library(dplyr)
p <- ggplot(
  women_data_long,
  aes( x = Year,
    y = No.Women.In.Parliament,
    color = Entity,
    group = Entity)) +
  geom_line(size = 1) +
  labs(
    title = "Women in Parliament by Continent Over Time",
    subtitle = "Year: {frame_along}",
    x = "Year",
    y = "Number of Women in Parliament",
    color = "Entity") +
  theme_minimal()

animated_plot <- p +
  transition_reveal(Year)
animate(animated_plot, fps = 2, duration = 8, width = 800, height = 500)

# If you want to save it:
anim_save("women_in_parliament_animation.gif", animation = last_animation())



install.packages("ragg")


