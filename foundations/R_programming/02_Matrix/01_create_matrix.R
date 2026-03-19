# ------------------------------------------------------------
# Matrix Construction
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Constructs a gene expression matrix representing
# 100 genes across 6 samples (3 control, 3 treatment)
# using base R.
# ------------------------------------------------------------

# Reproducibility
set.seed(42)

# ------------------------------------------------------------
# Define dimensions
# ------------------------------------------------------------

n_genes <- 100
n_samples <- 6
total_cells <- n_genes * n_samples

# Sanity checks
stopifnot(n_samples == 6)

# ------------------------------------------------------------
# Simulate expression counts
# ------------------------------------------------------------

# Generate random integer counts between 0 and 500
expression_values <- sample(0:500, total_cells, replace = TRUE)

# Ensure consistency between vector length and matrix size
stopifnot(length(expression_values) == total_cells)

# ------------------------------------------------------------
# Construct matrix
# ------------------------------------------------------------

# Reshape flat vector into 2D structure (column-major filling)
gene_expression_matrix <- matrix(
  expression_values,
  nrow = n_genes,
  ncol = n_samples,
  byrow = FALSE
)

# ------------------------------------------------------------
# Assign biological identifiers
# ------------------------------------------------------------

# Gene IDs: Gene_001 → Gene_100
rownames(gene_expression_matrix) <- sprintf("Gene_%03d", 1:n_genes)

# Sample labels: 3 Control, 3 Treatment
colnames(gene_expression_matrix) <- c(
  "Control_1", "Control_2", "Control_3",
  "Treatment_1", "Treatment_2", "Treatment_3"
)

# ------------------------------------------------------------
# Inspect structure
# ------------------------------------------------------------

dim(gene_expression_matrix)
head(gene_expression_matrix)