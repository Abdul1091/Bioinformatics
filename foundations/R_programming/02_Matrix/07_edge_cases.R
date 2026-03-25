# ------------------------------------------------------------
# Edge Case Handling
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Introduces edge cases into the gene expression matrix
# to test robustness of normalization and differential
# expression workflows.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load normalized matrix
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/05_normalization_cpm.R")

# Work on a copy to preserve original data
edge_matrix <- cpm_matrix

# ------------------------------------------------------------
# 1. Introduce genes with all zeros
# ------------------------------------------------------------

edge_matrix[1:2, ] <- 0

# ------------------------------------------------------------
# 2. Introduce genes with all NA
# ------------------------------------------------------------

edge_matrix[3:4, ] <- NA

# ------------------------------------------------------------
# 3. Introduce columns with very low counts
# ------------------------------------------------------------

# Simulate near-zero library size for a sample
edge_matrix[, 1] <- edge_matrix[, 1] * 1e-6

# ------------------------------------------------------------
# Inspect structure after perturbation
# ------------------------------------------------------------

head(edge_matrix)

# ------------------------------------------------------------
# Recompute group means
# ------------------------------------------------------------

control_cols <- 1:3
treatment_cols <- 4:6

control_mean <- rowMeans(edge_matrix[, control_cols], na.rm = TRUE)
treatment_mean <- rowMeans(edge_matrix[, treatment_cols], na.rm = TRUE)

# ------------------------------------------------------------
# Recompute fold-change
# ------------------------------------------------------------

fold_change <- treatment_mean / control_mean

# Handle invalid values
fold_change[!is.finite(fold_change)] <- NA

# ------------------------------------------------------------
# Identify differential expression
# ------------------------------------------------------------

upregulated <- fold_change > 1.5
downregulated <- fold_change < 0.67

# ------------------------------------------------------------
# Inspect outcomes
# ------------------------------------------------------------

sum(is.na(control_mean))
sum(is.na(treatment_mean))
sum(is.na(fold_change))

sum(upregulated, na.rm = TRUE)
sum(downregulated, na.rm = TRUE)

# Examine problematic genes
head(fold_change)