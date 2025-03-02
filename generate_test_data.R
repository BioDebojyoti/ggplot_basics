# Load necessary library
if (!requireNamespace("dplyr", quietly = TRUE)) {
  install.packages("dplyr")
}
library(dplyr)

# Set seed for reproducibility
set.seed(42)

# Number of genes to simulate
num <- 10000

log2FC = rnorm(n=num, mean = 0.0, sd = 1.5)
p_values = runif(n = num, min = 0.0, max = 5.0)


vol_data <- data.frame(
  Gene_symbol = paste0("Gene", 1:num),
  log2FC = log2FC,
  neg_log10pval = p_values,
  log2FC_sq = log2FC**2
)

vol_data <- vol_data %>% 
  dplyr::filter(neg_log10pval < log2FC_sq) %>%
  dplyr::mutate(
    p_value = 10**(-neg_log10pval)
  )

# Define output path
project_dir <- "/Users/debda22/Projects/core_facility_projects/ggplot_basics"
data_dir <- paste0(project_dir, "/input_data")
if (!dir.exists(data_dir)) dir.create(data_dir, recursive = TRUE)
output_file <- paste0(data_dir, "/test_input_file.csv")

# Save as CSV
write.csv(vol_data, output_file, row.names = FALSE)