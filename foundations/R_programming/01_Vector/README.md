# 🧬 Vector Mastery Project — Simulated Gene Expression

## Overview

This project explores the behavior of **vectors in R** through a small simulated gene expression experiment. The goal was to examine how vector construction, type coercion, missing values, and vectorized operations interact in practice when working with structured biological data.

Rather than relying on loops or external packages, the entire workflow is implemented using **base R vector operations**. This made it possible to observe how R internally handles data types, recycling rules, and missing values during analytical tasks that resemble common steps in bioinformatics pipelines.

The exercise simulates a simple dataset consisting of **100 genes measured across six samples** (three controls and three treatments) and follows a minimal workflow from data generation to summary statistics.

---

## Exploration

### Gene identifiers

A vector of gene identifiers (`Gene_001` to `Gene_100`) was generated programmatically using sequence functions and formatted numbering. This step highlights how sequences and character formatting can be combined to construct structured identifiers.

### Simulated expression counts

Expression counts were generated randomly to represent baseline gene expression across six samples. A subset of genes was then artificially upregulated in treatment samples to introduce a simple biological signal. A small proportion of values was replaced with `NA` in order to explore how missing values propagate through vectorized calculations.

### Type coercion

An intentional mixture of numeric and character elements was introduced to observe how R coerces atomic vectors to a common data type. This provided a clear demonstration of how seemingly small changes in a vector can alter its internal representation.

### Missing data

The dataset was examined for missing values, and simple strategies were explored for dealing with incomplete observations. This included identifying genes with excessive missingness and replacing remaining `NA` values using gene-wise summaries.

### Normalization

Raw counts were transformed to **counts per million (CPM)** using vectorized arithmetic. Implementing this step purely with vectors provided a clearer understanding of indexing and recycling rules in R.

### Differential expression summary

Mean expression values for control and treatment groups were calculated, and fold-change estimates were derived to identify genes with strong simulated changes in expression.

### Edge cases

Special attention was given to cases such as zero counts and missing values during calculations. These situations revealed how easily unexpected numerical behavior can arise if edge conditions are not considered.

### Built-in vector functions

A range of base R summary functions (`min`, `max`, `range`, `quantile`, `sd`, `var`, `sum`, `which.max`, `which.min`) were applied to explore how they behave with real vectors containing missing values and heterogeneous distributions.

---

## Key Observations

Working through this project reinforced several aspects of how R handles vectors:

- atomic vectors must contain a **single data type**
- mixing data types triggers **automatic coercion**
- missing values require **explicit handling** during calculations
- many statistical operations in R are naturally **vectorized**
- seemingly simple operations can behave differently when **edge cases** are present

Understanding these mechanics is essential when scaling analyses to large biological datasets.

---

## Motivation

Vectors are the most fundamental data structure in R. Many higher-level objects used in bioinformatics—matrices, data frames, and specialized Bioconductor classes—are built on top of vector behavior.

Exploring these mechanics directly helps develop a clearer mental model of how R evaluates expressions and stores data, which ultimately supports more reliable and reproducible analytical workflows.

---

## Reproducibility

All analyses in this repository were performed using **base R** without external packages.  
To reproduce the results:

1. Clone the repository

```
git clone https://github.com/Abdul1091/Bioinformatics
```

2. Navigate to the project directory

```
cd Bioinformatics/foundations/R_programming/01_Vector
```

3. Run the analysis script

```
Rscript 01_gene_ids.R
```

Because the data are simulated, results may vary slightly between runs unless a random seed is specified.

---