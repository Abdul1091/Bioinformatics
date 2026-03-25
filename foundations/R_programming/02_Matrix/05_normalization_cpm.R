# ------------------------------------------------------------
# Normalization (CPM)
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Converts raw gene expression counts to Counts Per Million (CPM)
# using column-wise normalization. Reuses the cleaned matrix
# from 04_handle_missing_data.R.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load cleaned matrix (after missing data handling)
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/04_handle_missing_data.R")

# ------------------------------------------------------------
# 1. Compute library sizes (column sums)
# ------------------------------------------------------------

library_sizes <- colSums(filtered_matrix)

library_sizes

# ------------------------------------------------------------
# 2. Handle division-by-zero edge case
# ------------------------------------------------------------

zero_library <- library_sizes == 0

sum(zero_library)  # number of problematic samples

# Replace zero library sizes with NA to avoid division errors
library_sizes[zero_library] <- NA

# ------------------------------------------------------------
# 3. Apply CPM normalization
# ------------------------------------------------------------

cpm_matrix <- sweep(
  filtered_matrix,
  2,
  library_sizes,
  FUN = "/"
) * 1e6

# ------------------------------------------------------------
# Inspect normalized matrix
# ------------------------------------------------------------

dim(cpm_matrix)
head(cpm_matrix)

# ------------------------------------------------------------
# Sanity check: column sums should be ~1e6 (ignoring NA)
# ------------------------------------------------------------

colSums(cpm_matrix, na.rm = TRUE)