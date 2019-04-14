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





