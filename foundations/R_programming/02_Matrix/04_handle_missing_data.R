# ------------------------------------------------------------
# Missing Data Handling
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Introduces missing values into the gene expression matrix,
# quantifies missingness, removes genes with excessive NA,
# and imputes remaining values using row-wise means.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load previously constructed matrix
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/01_create_matrix.R")

# ------------------------------------------------------------
# 1. Introduce ~5% missing values
# ------------------------------------------------------------

total_cells <- length(gene_expression_matrix)
n_missing <- round(0.05 * total_cells)

missing_indices <- sample(1:total_cells, n_missing)

gene_expression_matrix[missing_indices] <- NA

# Inspect
sum(is.na(gene_expression_matrix))

# ------------------------------------------------------------
# 2. Count total missing values
# ------------------------------------------------------------

total_missing <- sum(is.na(gene_expression_matrix))
total_missing

# ------------------------------------------------------------
# 3. Compute missing values per gene (row-wise)
# ------------------------------------------------------------

gene_missing_counts <- rowSums(is.na(gene_expression_matrix))

head(gene_missing_counts)

# ------------------------------------------------------------
# 4. Remove genes with >2 missing values
# ------------------------------------------------------------

genes_to_remove <- gene_missing_counts > 2

sum(genes_to_remove)

filtered_matrix <- gene_expression_matrix[!genes_to_remove, ]

dim(filtered_matrix)

# ------------------------------------------------------------
# 5. Replace remaining NA with row means
# ------------------------------------------------------------

# Compute row means (excluding NA)
row_means <- rowMeans(filtered_matrix, na.rm = TRUE)

# Identify NA positions
na_positions <- is.na(filtered_matrix)

# Replace NA with corresponding row mean
filtered_matrix[na_positions] <- row_means[row(filtered_matrix)][na_positions]

# ------------------------------------------------------------
# Inspect results
# ------------------------------------------------------------

sum(is.na(filtered_matrix))  # should be 0

head(filtered_matrix)
tail(filtered_matrix)