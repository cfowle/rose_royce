###############################################################################
##### PROJECT: ROSE-ROYCE
##### PURPOSE: CREATES OUTPUT CHARTS
###############################################################################

##Demonstrate corellation with days of the week
wday_average = open %>%
  group_by(wday) %>%
  summarise(avg = mean(revenue, na.rm = TRUE)) %>%
  arrange(desc(wday))

daily_averages = ggplot(wday_average, aes(x=wday, y=avg)) +
  geom_bar(stat = "identity") +
  theme_limesight() +
  xlab("Day of the Week") +
  ylab("Average Sales ($)")

##demonstrate seasonality
monthly_avg= open %>%
  group_by(month, year) %>%
  summarise(avg = mean(revenue, na.rm = TRUE)) %>%
  mutate(period = mdy(paste(month, 1, year, sep = "/"))) %>%
  filter(year > 2007)

monthly_averages = ggplot(monthly_avg, aes(x=period, y = avg)) +
  geom_line()+
  theme_limesight() +
  xlab("Month") +
  ylab("Average Daily Revenue ($)")

ggsave("daily_averages.png", daily_averages, path = "../output", device = png(),
       width = 8, height = 5)
ggsave("monthly_averages.png", monthly_averages, path = "../output", device = png(),
       width = 8, height = 5)
