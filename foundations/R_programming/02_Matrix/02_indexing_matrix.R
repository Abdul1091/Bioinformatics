# ------------------------------------------------------------
# Matrix Indexing and Subsetting
# Matrix Mastery Project — Structured Gene Expression
# Author: Abdullahi Tukur Bakiyawa
# Description:
# Explores element access and subsetting in a gene
# expression matrix. Reuses the matrix constructed
# in 01_create_matrix.R.
# ------------------------------------------------------------

# ------------------------------------------------------------
# Load previously constructed matrix
# ------------------------------------------------------------

source("foundations/R_programming/02_Matrix/01_create_matrix.R")

# ------------------------------------------------------------
# 1. Extract first 10 genes (row subsetting)
# ------------------------------------------------------------

first_10_genes <- gene_expression_matrix[1:10, ]

dim(first_10_genes)
head(first_10_genes)

# ------------------------------------------------------------
# 2. Extract treatment samples only (column subsetting)
# ------------------------------------------------------------

treatment_matrix <- gene_expression_matrix[, 4:6]
colnames(treatment_matrix)

# Name-based selection (more robust)
treatment_matrix_named <- gene_expression_matrix[, grepl("Treatment", colnames(gene_expression_matrix))]

# ------------------------------------------------------------
# 3. Subset genes with mean expression > 200
# ------------------------------------------------------------

gene_means <- rowMeans(gene_expression_matrix)

high_expression_genes <- gene_expression_matrix[gene_means > 200, ]

dim(high_expression_genes)

# ------------------------------------------------------------
# 4. Access a single gene across all samples
# ------------------------------------------------------------

gene_005 <- gene_expression_matrix["Gene_005", ]

gene_005
class(gene_005)

# Preserve structure explicitly
gene_005_matrix <- gene_expression_matrix["Gene_005", , drop = FALSE]

dim(gene_005_matrix)

# ------------------------------------------------------------
# 5. Matrix vs Vector Indexing
# ------------------------------------------------------------

# Matrix indexing (2D)
element_1_1 <- gene_expression_matrix[1, 1]

# Linear (vector-style) indexing
element_linear <- gene_expression_matrix[1]

element_1_1
element_linear

# Structural comparison
class(gene_expression_matrix[1, ])
class(gene_expression_matrix[, 1])
class(gene_expression_matrix[1])