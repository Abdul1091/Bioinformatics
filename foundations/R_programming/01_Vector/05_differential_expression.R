# ------------------------------------------------------------
# Differential Expression Summary
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Computes mean expression for control and treatment groups,
# calculates fold-change per gene, and identifies genes that
# are strongly upregulated or downregulated.
# ------------------------------------------------------------

# Load normalized dataset
source("04_normalization_cpm.R")

# Extract numeric expression values
expr_values <- cpm_expression[, -1]

# Define sample groups
control_cols <- 1:3
treatment_cols <- 4:6

control_mean <- rowMeans(expr_values[, control_cols])
treatment_mean <- rowMeans(expr_values[, treatment_cols], na.rm = TRUE)

# Compute fold-change (Treatment / Control)
fold_change <- treatment_mean / control_mean

# Identify DE genes
upregulated <- fold_change > 1.5
downregulated <- fold_change < 0.67

# Count genes in each category
n_up <- sum(upregulated)
n_down <- sum(downregulated)

print(n_up)
print(n_down)

# Assemble summary table
de_results <- data.frame(
gene = cpm_expression$gene,
control_mean = control_mean,
treatment_mean = treatment_mean,
fold_change = fold_change
)

# Inspect strongest changes
print(head(de_results[order(-de_results$fold_change), ]))
print(head(de_results[order(de_results$fold_change), ]))