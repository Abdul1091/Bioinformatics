# ------------------------------------------------------------
# Differential Expression
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Computes differential expression between control and
# treatment samples using CPM-normalized data.
# Identifies upregulated and downregulated genes.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load normalized matrix
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/05_normalization_cpm.R")

# ------------------------------------------------------------
# 1. Define sample groups
# ------------------------------------------------------------

control_cols <- 1:3
treatment_cols <- 4:6

# ------------------------------------------------------------
# 2. Compute mean expression per group
# ------------------------------------------------------------

control_mean <- rowMeans(cpm_matrix[, control_cols], na.rm = TRUE)
treatment_mean <- rowMeans(cpm_matrix[, treatment_cols], na.rm = TRUE)

head(control_mean)
head(treatment_mean)

# ------------------------------------------------------------
# 3. Compute fold-change per gene
# ------------------------------------------------------------

fold_change <- treatment_mean / control_mean

head(fold_change)

# ------------------------------------------------------------
# 4. Handle division-by-zero edge case
# ------------------------------------------------------------

# Replace Inf and NaN with NA
fold_change[!is.finite(fold_change)] <- NA

# ------------------------------------------------------------
# 5. Identify differentially expressed genes
# ------------------------------------------------------------

# Upregulated genes (> 1.5)
upregulated <- fold_change > 1.5

# Downregulated genes (< 0.67)
downregulated <- fold_change < 0.67

# Counts
sum(upregulated, na.rm = TRUE)
sum(downregulated, na.rm = TRUE)

# ------------------------------------------------------------
# Extract gene subsets
# ------------------------------------------------------------

upregulated_genes <- cpm_matrix[upregulated, ]
downregulated_genes <- cpm_matrix[downregulated, ]

dim(upregulated_genes)
dim(downregulated_genes)

# ------------------------------------------------------------
# Inspect results
# ------------------------------------------------------------

head(upregulated_genes)
head(downregulated_genes)