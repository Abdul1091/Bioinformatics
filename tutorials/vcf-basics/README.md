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

| Step | File | Primary Focus | Key Learning Outcome |
| :---: | :--- | :--- | :--- |
| **1** | **[01-what-is-vcf.md](./01-what-is-vcf.md)** | **Foundation (Core):** Purpose of VCF, its structure, and the role of the header & body. | Understand why VCF is the standard format for variant representation. |
| **2** | **[02-the-nine-columns.md](./02-the-nine-columns.md)** | **Structure (Core):** Detailed breakdown of the nine fixed columns. | Recognize where positional, reference, and variant information is stored. |
| **3** | **[03-info-vs-format.md](./03-info-vs-format.md)** | **Core Concept:** Difference between global (INFO) and sample-specific (FORMAT) data. | Know where to find annotations vs. genotype metrics. |
| **4** | **[04-allelic-representation.md](./04-allelic-representation.md)** | **Genotype Interpretation:** Understanding GT, AD, DP, and the 0/1 allele indexing system. | Correctly interpret a sample’s genotype and calculate VAF. |
| **5** | **[05-simple-vcf-filtering.md](./05-simple-vcf-filtering.md)** | **Hands-on (Core):** Practical filtering with `bcftools`. | Perform essential quality filtering (e.g., PASS, SNPs only). |

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