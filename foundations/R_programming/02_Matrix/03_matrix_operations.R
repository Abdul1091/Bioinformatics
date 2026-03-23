# ------------------------------------------------------------
# Matrix Operations / Transformation
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Applies row-wise and column-wise operations to the
# gene expression matrix. Reuses the matrix constructed
# in 01_create_matrix.R.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load previously constructed matrix
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/01_create_matrix.R")

# ------------------------------------------------------------
# 1. Row-wise mean expression (gene-level summary)
# ------------------------------------------------------------

gene_mean_expression <- rowMeans(gene_expression_matrix)

head(gene_mean_expression)
length(gene_mean_expression)

# ------------------------------------------------------------
# 2. Column-wise library sizes (sample-level totals)
# ------------------------------------------------------------

library_sizes <- colSums(gene_expression_matrix)

library_sizes
length(library_sizes)

# ------------------------------------------------------------
# 3. apply() — flexible aggregation
# ------------------------------------------------------------

# Row-wise standard deviation
gene_sd_expression <- apply(gene_expression_matrix, 1, sd)

head(gene_sd_expression)
length(gene_sd_expression)

# Column-wise maximum
sample_max_expression <- apply(gene_expression_matrix, 2, max)

sample_max_expression
length(sample_max_expression)

# ------------------------------------------------------------
# Structural consistency checks
# ------------------------------------------------------------

dim(gene_expression_matrix)