# ------------------------------------------------------------
# List Construction
# List Mastery Project — Gene Expression Workflow Abstraction
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Constructs a list object representing the full gene
# expression analysis workflow. Reuses outputs from the
# matrix-based pipeline and organizes them into a single
# structured container.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load upstream pipeline components
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/01_create_matrix.R")
source("foundations/R_programming/02_Matrix/04_handle_missing_data.R")
source("foundations/R_programming/02_Matrix/05_normalization_cpm.R")
source("foundations/R_programming/02_Matrix/06_differencial_expression.R")

# ------------------------------------------------------------
# Sanity check: ensure alignment across components
# ------------------------------------------------------------

# Check gene consistency between matrices
stopifnot(
  identical(rownames(gene_expression_matrix), rownames(filtered_matrix)),
  identical(rownames(filtered_matrix), rownames(cpm_matrix))
)

# Check length consistency for vectors
stopifnot(
  length(fold_change) == nrow(cpm_matrix),
  length(upregulated) == nrow(cpm_matrix),
  length(downregulated) == nrow(cpm_matrix)
)

# ------------------------------------------------------------
# Construct list (analysis pipeline container)
# ------------------------------------------------------------

gene_expression_pipeline <- list(
  raw_counts = gene_expression_matrix,
  cleaned_counts = filtered_matrix,
  normalized_counts = cpm_matrix,
  fold_change = fold_change,
  upregulated = upregulated,
  downregulated = downregulated
)

# ------------------------------------------------------------
# Inspect structure
# ------------------------------------------------------------

str(gene_expression_pipeline)

names(gene_expression_pipeline)

length(gene_expression_pipeline)