# ------------------------------------------------------------
# CPM Normalization
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Converts raw gene expression counts to Counts Per Million (CPM)
# using vectorized arithmetic in base R. Column sums are computed
# manually and vector recycling is used to perform normalization
# across all samples without explicit matrix conversion.
# ------------------------------------------------------------

# Load cleaned expression dataset
source("foundations/R_programming/01_Vector/03_handle_missing_data.R")
# `clean_expression` must exist; first column should be gene IDs

# Extract expression values (exclude gene ID column)
# I ususally use [, -1] to remove the gene column
#This way, if columns change, the code is safe
expr_values <- clean_expression[, setdiff(names(clean_expression), "gene")]

# Compute library sizes (column sums)
library_sizes <- colSums(expr_values, na.rm = TRUE)
cat("Library sizes for each sample:\n")
print(library_sizes)

# Convert counts to CPM
# CPM = (counts / column_sum) * 1e6
# Vector recycling automatically divides each column
# by its corresponding library size
cpm_values <- (expr_values / library_sizes) * 1e6

# Recombine gene IDs with normalized values
cpm_expression <- data.frame(
    gene = clean_expression$gene,
    cpm_values,
    row.names = NULL
)

# Inspect normalized dataset
print(head(cpm_expression))
print(tail(cpm_expression))

# Verify normalization
# Column sums should be approximately 1,000,000
cpm_sums <- colSums(cpm_expression[, setdiff(names(cpm_expression), "gene")])
print(cpm_sums)