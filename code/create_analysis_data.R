unemployment_rate <- read_parquet("data/raw/unemployment_rate.parquet")
cpi <- read_parquet("data/raw/cpi.parquet")

macro_data <- inner_join(unemployment_rate, cpi, by = "date")

macro_data <- macro_data |>
  mutate(date = as.Date(date, format = "%Y-%m-%d")) |>
  arrange(date)

macro_data <- macro_data |>
  mutate(date_12mo_ago = date %m-% months(12))

cpi_lagged <- macro_data |>
  select(date, cpi) |>
  rename(date_12mo_ago = date, cpi_12mo_ago = cpi)

macro_data <- macro_data |>
  left_join(cpi_lagged, by = "date_12mo_ago") |>
  mutate(inflation = (cpi - cpi_12mo_ago) / cpi_12mo_ago * 100) |>
  filter(!is.na(inflation), !is.na(unemployment_rate)) |>
  filter(date >= as.Date("1970-01-01")) |>
  select(date, unemployment_rate, inflation)

write_parquet(macro_data, "data/analysis/macro_data.parquet")
