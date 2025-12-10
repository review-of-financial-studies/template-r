macro_data <- read_parquet("data/analysis/macro_data.parquet")

plot <- ggplot(macro_data, aes(x = inflation, y = unemployment_rate)) +
  geom_point(color = "blue", size = 1.5, alpha = 0.6) +
  geom_smooth(method = "lm", color = "red", linewidth = 1, se = TRUE) +
  labs(
    x = "Inflation, y/y (%)",
    y = "Unemployment rate (%)",
    title = "Scatterplot of Unemployment vs. Inflation with Fitted Line"
  ) +
  theme_minimal() +
  theme(
    panel.background = element_rect(fill = "white"),
    plot.background = element_rect(fill = "white")
  )

ggsave(
  "results/figures/unemployment_inflation.png",
  plot = plot,
  width = 14,
  height = 8,
  dpi = 100
)

model <- feols(unemployment_rate ~ inflation, data = macro_data)

latex_table <- etable(model, tex = TRUE)
writeLines(latex_table, "results/tables/phillips_regression.tex")
