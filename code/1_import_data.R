###############################################################################
##### PROJECT: ROSE-ROYCE
##### PURPOSE: IMPORTS AND CLEANS RAW DATA
###############################################################################

##Import, convert all columns to character for joining/cleaning purposes
cw_00_02 = read_csv("../input/00_02.csv") %>%
  mutate_all(as.character)
cw_03_05 = read_csv("../input/03_05.csv") %>%
  mutate_all(as.character)
cw_06_08 = read_csv("../input/06_08.csv") %>%
  mutate_all(as.character)
cw_09_11 = read_csv("../input/09_11.csv") %>%
  mutate_all(as.character)
cw_12_14 = read_csv("../input/12_14.csv") %>%
  mutate_all(as.character)
cw_15_18 = read_csv("../input/15_18.csv") %>%
  mutate_all(as.character)

##Join years into single dataset
sales = cw_00_02 %>%
  bind_rows(cw_03_05) %>%
  bind_rows(cw_06_08) %>%
  bind_rows(cw_09_11) %>%
  bind_rows(cw_12_14) %>%
  bind_rows(cw_15_18)

##make date column
sales %<>%
  mutate(date = mdy(paste(month, day, year, sep = "/"))) %>%
  filter(!is.na(date))

##Import third party data sets
csi = read_csv("../input/csi_history_2018-02.csv")
weather = read_csv("../input/weather.csv")

##clean csi and join with sales
csi %<>%
  mutate(month = as.numeric(str_extract(Month, "\\d*")),
         year  = as.numeric(Year)) %>%
  rename(csi_index = `Index value`) %>%
  select(month, year, csi_index) %>%
  filter(!is.na(year))

sales %<>%
  mutate(month = as.numeric(month),
         year  = as.numeric(year)) %>%
  left_join(csi)

##join weather with sales
weather_selected = weather %>%
  rename(date  = DATE,
         t_max = TMAX,
         t_min  = TMIN,
         rain  = PRCP) %>%
  select(date, t_max, t_min, rain)

sales %<>%
  left_join(weather_selected)

##remove empty days
##add dummy for closed
##add dummy for season
sales %<>%
  filter(!is.na(revenue) & !is.na(tcars)) %>%
  filter(wday != "SUN") %>%
  mutate(revenue = as.numeric(revenue),
         tcars   = as.numeric(tcars)) %>%
  mutate(is_closed = ifelse(revenue < 50, TRUE, FALSE)) %>%
  mutate(is_season = ifelse(month < 4 | month == 12, TRUE, FALSE))

open = sales %>%
  filter(!is_closed)

closed = sales %>%
  filter(is_closed)
