# ------------------------------------------------------------
# Simulate Expression Counts
# Vector Mastery Project
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Generates baseline counts, upregulates specific genes in
# treatment samples, and introduces random missingness using
# vectorized logical indexing and recycling.
# ------------------------------------------------------------


# Define the dimensions of the simulation
n_genes <- 100
n_samples <- 6
total_cells <- n_genes * n_samples


# Generate baseline counts (0–500) for all genes and samples
counts <- sample(0:500, total_cells, replace = TRUE)


# Upregulate the first 20 genes in treatment samples (Samples 4-6)

# Create logical masks using vector recycling
gene_mask <- rep(c(rep(TRUE, 20), rep(FALSE, 80)), times = n_samples)

sample_mask <- rep(c(rep(FALSE,3), rep(TRUE,3)), each = 100)

# Apply the upregulation
counts[gene_mask & sample_mask] <- counts[gene_mask & sample_mask] + 100


# Introduce random missing values (~5%)
missing_indices <- sample(1:total_cells, 30)
counts[missing_indices] <- NA


# Generate gene IDs (reusing the logic from Script 01)
gene_ids <- paste0("Gene_", sprintf("%03d", 1:100))


# Fold the vector into a matrix (100 genes × 6 samples)
expr_matrix <- matrix(counts, nrow = n_genes)

simul_expr_count <- data.frame(gene = gene_ids, expr_matrix)


# Rename columns to S1, S2 ... S6
colnames(simul_expr_count)[2:7] <- paste0("S", 1:6)


# Define sample group labels for downstream analyses
sample_groups <- c("Control","Control","Control",
                   "Treatment","Treatment","Treatment")


# Inspect results
print(head(simul_expr_count))
print(tail(simul_expr_count))