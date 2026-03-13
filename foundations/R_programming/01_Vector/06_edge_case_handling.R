# ------------------------------------------------------------
# Edge Case Handling
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Identifies and handles problematic cases such as zero counts,
# division-by-zero scenarios, and missing values to ensure
# robust downstream differential expression analysis.
# ------------------------------------------------------------

# Load normalized dataset
source("04_normalization_cpm.R")

# Extract expression values
expr_values <- cpm_expression[, -1]

# Detect genes with all-zero expression
all_zero_genes <- rowSums(expr_values == 0) == ncol(expr_values)
n_all_zero <- sum(all_zero_genes)
print(n_all_zero)

# Replace zero control means to avoid division by zero
control_cols <- 1:3
treatment_cols <- 4:6

control_mean <- rowMeans(expr_values[, control_cols])
treatment_mean <- rowMeans(expr_values[, treatment_cols])

# Identify problematic cases
zero_control <- control_mean == 0
print(sum(zero_control))

# Add small pseudocount where necessary
control_mean[zero_control] <- 1e-6

# Recompute fold change safely
safe_fold_change <- treatment_mean / control_mean

# Inspect problematic genes
problematic_genes <- cpm_expression$gene[zero_control]

print(problematic_genes)

# Confirm no infinite or NA values
print(sum(is.infinite(safe_fold_change)))
print(sum(is.na(safe_fold_change)))