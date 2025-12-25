## 🧬 03b — FORMAT (Sample-Level Data)

> 📘 **VCF Spec Alignment:** This lesson follows VCF v4.2+ conventions.

---

## 📌 Introduction: Sample-Level Data in VCF

In **03a**, we learned how the `INFO` field stores annotations that apply to the **variant site as a whole**.

This lesson focuses on the complementary concept: **sample-level data**, stored through the `FORMAT` column and the sample columns that follow it.

If `INFO` answers:

> *“What is true about this variant overall?”*

Then `FORMAT` answers:

> *“How does this variant look in each individual sample?”*

This distinction is one of the most important conceptual boundaries in the entire VCF format.

---

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:

* Explain what the `FORMAT` column represents
* Understand how `FORMAT` defines the structure of sample columns
* Distinguish schema (`FORMAT`) from measurements (sample data)
* Correctly interpret per-sample fields such as `GT`, `DP`, and `AD`
* Avoid common and dangerous INFO vs FORMAT confusions

---

## 🧬 VCF Column 8: FORMAT (Data Schema)

## Overview

`FORMAT` defines **how to interpret the per-sample columns** that follow it.

It is a **schema**, not data.

It answers the question:

> **“What measurements are reported for each sample at this variant?”**

* `FORMAT` applies to **all samples in the record**
* Sample values inherit their meaning **entirely from `FORMAT`**

> ⚠️ **Critical rule:**
> `FORMAT` never contains measurements — it only defines how to read the sample columns.

---

## 🧠 Mental Model

Think of `FORMAT` as a **column header template** that repeats for every sample.

* `FORMAT` = *labels*
* Sample columns = *values*

Without `FORMAT`, sample columns are meaningless strings.

---

## 1️⃣ FORMAT Syntax

`FORMAT` is a colon-separated list of keys:

```
FORMAT = GT:DP:AD:GQ
```

Each key defines:

* what type of measurement exists
* how many values it contains
* how to interpret sample entries

The sample columns then follow the same order:

```
SAMPLE_1 = 0/1:35:18,17:99
SAMPLE_2 = 0/0:42:40,2:85
```

> 🧠 **Design insight:**
> Sample columns do not have individual field names — their meaning is inherited entirely from `FORMAT`.

---

## 2️⃣ FORMAT Keys Are Defined in the Header

Every key used in `FORMAT` **must be declared in the VCF header**:

```
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Read depth">
```

If a key appears in `FORMAT` but is missing from the header:

> 🚫 The VCF is invalid.

---

## 3️⃣ Common FORMAT Fields (Conceptual Overview)

This tutorial focuses on **roles**, not exhaustive tag lists.

| Field | Conceptual Role                          |
| ----- | ---------------------------------------- |
| `GT`  | Which alleles the sample carries         |
| `DP`  | How much evidence exists for this sample |
| `AD`  | How reads are split between alleles      |
| `GQ`  | Confidence in the genotype call          |

> 🔍 Exact interpretation of these fields is covered in **04 — Genotype Interpretation**.

---

## 4️⃣ Site-Level vs Sample-Level (Hard Boundary)

A value belongs in `FORMAT` **if and only if** it can differ between samples.

| Question               | INFO | FORMAT |
| ---------------------- | ---- | ------ |
| Same for all samples?  | ✅    | ❌      |
| Varies per individual? | ❌    | ✅      |
| Describes site?        | ✅    | ❌      |
| Describes observation? | ❌    | ✅      |

> ⚠️ **Common trap:**
> `INFO/DP` ≠ `FORMAT/DP`
>
> * `INFO/DP` → total site depth
> * `FORMAT/DP` → depth for one sample

---

## 5️⃣ Missing Sample Values

If a sample lacks a value for a given field, it is represented with a dot:

```
0/1:.:.:.
```

This means:

* the field exists
* the value is unknown or not computed

🚫 Do not treat missing values as zero.

---

## 🚨 Common FORMAT Pitfalls

| Pitfall                       | Rule / Consequence                  |
| ----------------------------- | ----------------------------------- |
| Treating FORMAT as data       | Leads to meaningless interpretation |
| Mixing INFO and FORMAT values | Produces incorrect conclusions      |
| Assuming GT alone is enough   | Ignores confidence and depth        |
| Ignoring header definitions   | Guarantees misinterpretation        |

---

***✅ One-Sentence Takeaway (FORMAT)***

**`FORMAT` defines how to interpret per-sample measurements — it does not contain the measurements themselves.**

---

## 🔗 Concept Bridge — From Site to Sample

> 🧠 **Final intuition**
>
> * `INFO` tells you what is true about the variant site
> * `FORMAT` tells you how to read each sample’s data
> * Sample columns tell you what each individual shows

---

## ➡️ What’s Next?

Now that you understand how sample data is structured, the next lesson focuses on **interpreting genotypes and allele counts**.

Continue to:

**[04-allelic-representation.md](./04-allelic-representation.md)**