# ------------------------------------------------------------
# Gene ID Generation
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Generates a vector of gene identifiers from Gene_001 to Gene_100
# using vectorized operations in base R.
# ------------------------------------------------------------


# First create numbers from 1 to 100. seq(1, 100) will also do the same job
numbers <- 1:100

# Add Zero Padding and apply to the Whole Vector
padded <- sprintf("%03d", numbers)

# Add the Gene Prefix
gene_ids <- paste0("Gene_", padded)

# Inspect results
print(head(gene_ids))
print(tail(gene_ids))

# One-line alternative
gene_ids_one_line <- paste0("Gene_", sprintf("%03d", 1:100))