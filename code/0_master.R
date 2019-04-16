###############################################################################
##### PROJECT: ROSE-ROYCE
##### PURPOSE: CLEANS RAW DATA
###############################################################################

library(lubridate)
library(magrittr)
library(stringr)
library(tidyverse)

setwd("~/code/rose-royce/code")

source("1_import_data.R")
source("2_create_revenue_model.R")
source("3_create_charts_for_report")
