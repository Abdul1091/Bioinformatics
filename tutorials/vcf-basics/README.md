# 🧬 VCF Basics Tutorial: Study Guide and Reference

This guide demystifies the Variant Call Format (VCF). It is structured for rapid learning, with emphasis on understanding the concept before mastering the tools.

**Goal:** Be able to accurately interpret any VCF line and clearly distinguish between *site-level* (INFO) and *sample-level* (FORMAT) data.

---

## 📌 Prerequisites & Audience Level

**Command-Line Basics (VCF Track):**  
- Navigate directories: `cd`  
- View file contents: `cat`, `less`  
- Pipe and redirect output: `|`, `>`  

> You do **not** need prior experience with bioinformatics tools like `bcftools`, `vcftools`, or annotation software.  

**Genomics Terminology:**  
- Basic understanding is helpful but not required.  
- **New to genomics?** Take 2 minutes to review our [Quick Terminology Guide](./00-glossary.md) for key terms like *read*, *allele*, and *genotype*.  

**Audience Level:**  
- **Beginners:** Focus on the Core Concepts in each tutorial.  
- **Intermediate/Advanced learners:** Deep Dive / Context sections (marked with 🧠 or `[Context]`) provide additional insights without being mandatory.

---

## 🗺️ Learning Track Progression

Follow the documents below in sequential order to build a strong foundation in VCF interpretation.

|  Step  | File                                                               | Primary Focus                                                             | Key Learning Outcome                                                    |
| :----: | :----------------------------------------------------------------- | :------------------------------------------------------------------------ | :---------------------------------------------------------------------- |
|  **1** | **[01-what-is-vcf.md](./01-what-is-vcf.md)**                       | **Foundation (Core):** Purpose of VCF, header vs body, and why it exists. | Understand why VCF is the standard format for variant representation.   |
| **2a** | **[02a-positional-data.md](./02a-positional-data.md)**             | **Group 1 – Positional Data:** CHROM, POS, ID.                            | Accurately locate and identify a variant by genomic coordinates.        |
| **2b** | **[02b-allelic-data.md](./02b-allelic-data.md)**                   | **Group 2 – Allelic Data:** REF, ALT, SNPs & indels.                      | Interpret substitutions, insertions, deletions, and normalized alleles. |
| **2c** | **[02c-quality-status.md](./02c-quality-status.md)**               | **Group 3 – Quality & Status:** QUAL, FILTER.                             | Assess variant confidence and pass/fail status.                         |
|  **3** | **[03-info-vs-format.md](./03-info-vs-format.md)**                 | **Core Concept:** INFO vs FORMAT distinction.                             | Know where to find global annotations vs sample-level metrics.          |
|  **4** | **[04-allelic-representation.md](./04-allelic-representation.md)** | **Genotype Interpretation:** GT, AD, DP, allele indexing (0/1).           | Correctly interpret genotypes and calculate VAF.                        |
|  **5** | **[05-simple-vcf-filtering.md](./05-simple-vcf-filtering.md)**     | **Hands-on (Core):** Practical filtering with `bcftools`.                 | Perform essential quality filtering and understand command syntax.      |


> **Why Step 2 is split:**  
> The original “nine fixed columns” concept is easier to understand when broken into **positional**, **allelic**, and **quality** groups.  
> Steps **2a–2c** together cover all fixed VCF columns while reducing cognitive overload.


> **Tip:** Beginners can prioritize the Core Concepts first and come back to Deep Dive/Context blocks later.

---

## 🔗 Next Steps: Tool Mastery (Coming Soon)

Once you understand the concepts in this track, you will be ready to explore **tool-based tutorials** that demonstrate how to manipulate, filter, query, and annotate VCF files using industry-standard tools such as:

- **bcftools**  
- **vcftools**  
- **htslib**  
- **Annotation tools (e.g., SnpEff, VEP)**  

Planned workflow topics include:

- Full `bcftools` VCF processing pipelines  
- Practical `vcftools` usage  
- VCF annotation workflows  
- Handling large cohort VCF datasets  
- Automating VCF analysis with scripts  

> These resources will be added once the conceptual tutorials in this folder are complete.

---