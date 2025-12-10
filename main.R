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
  "results/tables"
)

for (dir in dirs) {
  dir.create(dir, recursive = TRUE, showWarnings = FALSE)
}

source("code/download_raw_data.R")
source("code/create_analysis_data.R")
source("code/analyze_data.R")
