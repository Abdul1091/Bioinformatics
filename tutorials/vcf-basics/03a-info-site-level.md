## 🧬 03a — Site-Level Annotations (INFO)

> 📘 **VCF Spec Alignment:** This lesson follows VCF v4.2+ conventions.

---

## 📌 Introduction: What INFO Represents

In **02a–02c**, we learned:

* **Where** a variant is (`CHROM`, `POS`, `ID`)
* **What** changed (`REF`, `ALT`)
* **How confident** the call is (`QUAL`, `FILTER`)

This lesson introduces the **INFO** column — the first column that goes beyond the fixed, universal fields.

> 🧠 **Core idea**:
> **INFO stores annotations and statistics about the variant *as a genomic site*, not about individuals.**

If you remember only one thing from this lesson, remember this:

> **INFO = site-level knowledge**

---

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:

* Define the scope of the INFO column
* Understand INFO syntax (flags, key–value pairs, lists)
* Recognize common *types* of INFO annotations
* Clearly distinguish INFO data from FORMAT data
* Avoid the most common INFO-related interpretation errors

---

## 🧬 VCF Column 8: INFO

### Overview

The INFO column contains **annotations that describe the variant site itself**.

It answers questions like:

> * How common is this variant in the dataset?
> * What statistical or quality metrics summarize this site?
> * Has this variant been functionally annotated?

> 🧠 **Mental Model**
> Think of INFO as the **variant’s résumé**:
>
> * One résumé per variant
> * Shared by all samples
> * Can grow richer over time

---

## 1️⃣ INFO Is Site-Level (Scope Comes First)

This is the single most important rule.

* INFO describes the **variant location**
* INFO does **not** describe individual samples
* INFO values do **not** change from sample to sample

If a value differs between samples, it **cannot belong in INFO**.

> ⚠️ **Hard rule**:
> If you see per-sample variation, you must look in `FORMAT`, not INFO.

---

## 2️⃣ INFO Syntax (Simple but Precise)

INFO is a **semicolon-separated list** of entries:

```
INFO=KEY=VALUE;KEY2=VALUE2;FLAG
```

There are **three allowed forms**.

### a) Key–Value Pairs

```
DP=128
AF=0.42
```

* The key identifies the annotation
* The value provides the data

---

### b) Flags (Boolean)

```
SOMATIC
```

* Flags have **no value**
* Presence means *true*
* Absence means *false*

---

### c) Lists (Multiple Values)

```
AF=0.12,0.03
```

* Used when multiple ALT alleles exist
* Order corresponds to ALT allele order

> 🧠 **Reminder from 02b**: ALT allele order matters everywhere in VCF.

---

## 3️⃣ INFO Definitions Live in the Header

Every INFO key **must be defined** in the VCF header.

Example:

```
##INFO=<ID=AF,Number=A,Type=Float,Description="Allele frequency">
```

This definition tells you:

* **ID**: Tag name
* **Number**: Cardinality (per allele? per site?)
* **Type**: Data type
* **Description**: Human-readable meaning

> ⚠️ **Critical rule**:
> If an INFO key appears in the body but not in the header, the VCF is **invalid**.

---

## 4️⃣ Common Categories of INFO Annotations

INFO tags vary widely across tools, but conceptually they fall into a few groups.

### 🧩 a) Allele Statistics

Summarize allele counts or frequencies across samples.

Examples:

* Allele counts
* Allele frequencies
* Number of samples with the variant

> These describe the *cohort*, not individuals.

---

### 🧪 b) Quality & Evidence Metrics

Summarize evidence supporting the variant.

Examples:

* Total depth at the site
* Strand bias metrics
* Mapping quality summaries

> ⚠️ INFO depth is **not** the same as per-sample depth.

---

### 🧬 c) Functional Annotations

Describe predicted biological effects.

Examples:

* Coding consequence
* Gene name
* Impact predictions

> These are **annotations**, not measurements.

---

### 🌍 d) Population or Dataset Context

Describe how the variant behaves across datasets.

Examples:

* Known vs novel variants
* Database membership flags
* Population-level frequencies

---

## 5️⃣ INFO vs FORMAT (The Line You Must Not Cross)

This distinction prevents nearly all beginner mistakes.

| Aspect              | INFO              | FORMAT            |
| ------------------- | ----------------- | ----------------- |
| Scope               | Variant site      | Individual sample |
| Repeats per sample  | ❌ No              | ✅ Yes             |
| Describes           | Shared properties | Genotype evidence |
| Scales with samples | ❌ No              | ✅ Yes             |

> 🧠 **Rule of thumb**:
> INFO answers *“What is known about this variant?”*
> FORMAT answers *“How does each sample relate to it?”*

---

## 🚨 Common INFO Pitfalls

| Pitfall                          | Why It’s Wrong                         |
| -------------------------------- | -------------------------------------- |
| Treating INFO DP as sample depth | INFO DP is site-level                  |
| Assuming INFO tags are universal | Tags are tool-defined                  |
| Ignoring header definitions      | Leads to misinterpretation             |
| Expecting biological truth       | INFO stores annotations, not certainty |

---

***✅ One-Sentence Takeaway (INFO)***

**INFO stores shared, site-level annotations about a variant — never per-sample data.**

---

## 🔗 Concept Bridge — From Sites to Samples

So far, everything we’ve studied applies to the **variant site as a whole**.

> * POS tells us *where*
> * ALT tells us *what*
> * QUAL tells us *how confident*
> * INFO tells us *what is known*

But genomes are personal.


## ➡️ What’s Next?

In the next lesson, we cross the **sample boundary** and learn how VCF represents **individual-level data**.

Continue to:

**[03b-format-sample-level.md](./03b-format-sample-level.md)**