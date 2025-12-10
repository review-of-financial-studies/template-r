unemployment_rate <- read.csv(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?id=UNRATE"
) |>
  rename(date = observation_date, unemployment_rate = UNRATE) |>
  filter(!is.na(date)) |>
  distinct(date, .keep_all = TRUE) |>
  arrange(date)

write_parquet(unemployment_rate, "data/raw/unemployment_rate.parquet")

cpi <- read.csv(
  "https://fred.stlouisfed.org/graph/fredgraph.csv?id=CPIAUCSL"
) |>
  rename(date = observation_date, cpi = CPIAUCSL) |>
  filter(!is.na(date)) |>
  distinct(date, .keep_all = TRUE) |>
  arrange(date)

write_parquet(cpi, "data/raw/cpi.parquet")
