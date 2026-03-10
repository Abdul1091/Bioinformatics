# ------------------------------------------------------------
# Handle Missing Data
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Examines missing values in the simulated expression dataset,
# removes genes with excessive missingness, and replaces the
# remaining NA values using gene-wise mean imputation.
# All operations rely on base R vector functions.
# ------------------------------------------------------------

# Load simulated expression dataset
source("02_simulate_expression_count.R")

# Count total missing values in the dataset
total_missing <- sum(is.na(simul_expr_count[, -1]))
print(total_missing)

# Compute per-gene missingness
gene_missing_counts <- rowSums(is.na(simul_expr_count[, -1]))
print(head(gene_missing_counts))

# Identify genes with more than 2 missing values
genes_to_remove <- gene_missing_counts > 2

removed_genes <- sum(genes_to_remove)
print(removed_genes)

# Remove those genes
filtered_data <- simul_expr_count[!genes_to_remove, ]

# Replace remaining NA values with gene means
expr_values <- filtered_data[, -1]

gene_means <- rowMeans(expr_values, na.rm = TRUE)

na_positions <- is.na(expr_values)

expr_values[na_positions] <- gene_means[row(expr_values)][na_positions]

# Recombine gene IDs
clean_expression <- data.frame(
  gene = filtered_data$gene,
  expr_values,
  row.names = NULL
)

# Inspect results
print(head(clean_expression))
print(tail(clean_expression))

# Confirm no missing values remain
remaining_na <- sum(is.na(clean_expression[, -1]))
print(remaining_na)