# 🧬 Matrix Mastery Project — Structured Gene Expression Analysis

## Overview

This module extends the vector-based exploration into **matrix-based computation in R**, using a simulated gene expression dataset.

While vectors provide the foundation for computation in R, most real-world biological data—such as gene expression matrices—are naturally represented as **two-dimensional structures**, where rows correspond to genes and columns correspond to samples.

This project reconstructs the previous workflow using matrices, allowing for more structured data representation and more efficient computation through built-in matrix operations.

---

## Objectives

- Understand matrix construction and structure in R
- Perform row-wise and column-wise operations
- Apply vectorized matrix functions (`rowMeans`, `colSums`, `apply`)
- Handle missing values in a matrix context
- Perform normalization and simple differential expression analysis
- Explore edge cases in structured data

---

## Workflow

1. Matrix construction (gene expression dataset)
2. Indexing and subsetting
3. Matrix operations and transformations
4. Handling missing data
5. Normalization (CPM)
6. Differential expression analysis
7. Edge case handling

---

## Exploration

### Matrix construction

A gene expression matrix was created with:
- rows representing genes
- columns representing samples (control vs treatment)

Gene identifiers and sample labels were assigned using `rownames()` and `colnames()`.

---

### Indexing and subsetting

Matrix indexing was explored using:
- row and column selection
- logical indexing
- slicing subsets of genes or samples

This step highlights the difference between vector indexing and matrix indexing.

---

### Matrix operations

Common matrix operations were applied:
- `rowMeans()` for gene-level summaries
- `colSums()` for library size calculations
- `apply()` for flexible row/column computations

These operations simplify many tasks that required manual handling in the vector-based implementation.

---

### Missing data handling

Missing values were:
- identified using `is.na()`
- quantified per gene
- filtered based on missingness thresholds
- imputed using row-wise summaries

This demonstrates how missing data propagates in structured datasets.

---

### Normalization

Raw counts were transformed into **Counts Per Million (CPM)** using column-wise normalization.

Matrix operations (`colSums`) enabled a more natural and efficient implementation compared to vector recycling.

---

### Differential expression summary

Gene-level summaries were computed using row-wise operations:
- mean expression in control vs treatment groups
- fold-change estimation

Genes with strong simulated expression differences were identified.

---

### Edge cases

Special cases were explored, including:
- genes with zero counts across all samples
- rows containing only missing values
- division-by-zero scenarios

These cases highlight the importance of robust data handling in matrix-based workflows.

---

## Key Concepts

- matrices are collections of atomic vectors arranged in 2D
- row-wise vs column-wise computation
- efficient aggregation using built-in functions
- structured indexing for biological datasets
- propagation of missing values in matrices

---

## Example Use Case

Gene expression datasets from RNA-seq experiments are commonly represented as matrices, where:
- rows = genes
- columns = samples

Understanding matrix operations is essential for downstream analyses such as normalization, clustering, and differential expression.

---

## Key Observations

- matrix operations are more expressive than manual vector manipulation
- built-in functions reduce complexity and improve readability
- structured data reduces reliance on implicit recycling
- missing values require careful handling in row-wise computations

---

## Limitations

- matrices require homogeneous data types
- less flexible than lists for heterogeneous data
- manual handling still required for complex biological scenarios

---

## Task Mapping

| Task | Script |
|------|--------|
| Matrix Construction | 01_create_matrix.R |
| Indexing | 02_indexing_matrix.R |
| Matrix Operations | 03_matrix_operations.R |
| Missing Data | 04_handle_missing_data.R |
| Normalization | 05_normalization_cpm.R |
| Differential Expression | 06_differential_expression.R |
| Edge Cases | 07_edge_cases.R |

---

## Reproducibility

1. Clone the repository
git clone https://github.com/Abdul1091/Bioinformatics

2. Navigate to this module
cd Bioinformatics/foundations/R_programming/02_Matrix

3. Run the full workflow
Rscript 00_run_all.R

---

## Motivation

This module builds on vector fundamentals and introduces structured computation using matrices.

By transitioning from vectors to matrices, this project moves closer to how real biological data is represented and analyzed, forming a bridge toward more advanced data structures and bioinformatics workflows.