library(tidyverse)
library(ggplot2)
library(arrow)
library(zoo)
library(DBI)
library(RSQLite)
library(lubridate)
library(scales)


source("src/01_read_and_clean.R")

DailyMail <- Create_Daily_DataFrame()
AllMail <- read_parquet("data/AllMail.parquet")

source("src/02_Yearly_Summary.R")

source("src/03_SentVsReceieved.R")

source("src/04_LineGraphOfYear.R")

source("src/05_Histogram_of_hourly.R")

