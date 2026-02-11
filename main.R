library(arrow)
library(dplyr)
library(lubridate)
library(ggplot2)
library(fixest)

dirs <- c(
  "data",
  "data/raw",
  "data/analysis",
  "results",
  "results/figures",
  "results/tables",
  "results/log"
)

for (dir in dirs) {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
}

sink("results/log/main.txt")

source("code/download_raw_data.R", echo = TRUE)
source("code/create_analysis_data.R", echo = TRUE)
source("code/analyze_data.R", echo = TRUE)

sink()
