## 🧬 02c — Quality & Status (QUAL, FILTER)

> 📘 **VCF Spec Alignment:** This lesson follows VCF v4.2+ conventions.

## 📌 Introduction: Quality & Status in VCF
In **02a**, we learned how to locate a variant (`CHROM`, `POS`). In **02b**, we learned what changed at that location (`REF`, `ALT`).

This lesson focuses on the third conceptual group: **Quality & Status**. If **positional and allelic data** describe what a variant is, **quality and status** describe how confident we are in it.

> ⚠️ **Blunt truth:**
> A biologically correct variant with poor quality metrics is often less useful than a wrong variant with high confidence.

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:
- Explain what `QUAL` represents — and what it does *not*
- Interpret Phred-scaled quality scores
- Understand how `FILTER` communicates pass/fail status
- Distinguish variant confidence from variant truth
- Avoid common analytical mistakes involving quality thresholds


## 🧬 VCF Column 6: QUAL (Quality Score)

### Overview

`QUAL` is a **Phred-scaled confidence score** representing the probability that a variant exists at the reported position.

It answers the question:
> **“How confident is the caller that this variant is real?”**
- `QUAL` is **one value per variant record**
- It is **not per sample**

> 🧠 **Mental Model**
> Think of `QUAL` as **statistical confidence**, not **biological truth**.
> - High QUAL: Strong evidence the variant is real.
> - Low QUAL: Weak or ambiguous evidence.
> - It does **not** mean the variant is biologically important.


## 1️⃣ Phred-Scale Explained (Critical)
The Phred scale is logarithmic. The formula is: $QUAL = -10 \times \log_{10}(P_{error})$.

Where `P_error` is the probability that the variant call is wrong.

## Common interpretations

| QUAL | Error Probability | Confidence |
|----:|------------------:|------------|
| 10  | 1 in 10 (10%)          | Low        |
| 20  | 1 in 100 (1%)          | Moderate   |
| 30  | 1 in 1,000 (0.1%)       | High       |
| 50  | 1 in 100,000      | Very high  |
| 100 | $10^{-10}$         | Extremely high |

> ⚠️ **Non-linear scale:**  
> A `QUAL` of 40 is **not twice** as confident as 20 — it is **100× more confident**.


## 2️⃣ What `QUAL` Actually Measures

What `QUAL` represents depends on the variant caller, but commonly includes:
- Read depth
- Base quality
- Mapping quality
- Allele balance
- Statistical model assumptions

Different callers compute `QUAL` differently:
| Caller     | QUAL Meaning |
|------------|--------------|
| GATK       | Confidence in non-reference allele |
| FreeBayes  | Probability the site is polymorphic |
| bcftools  | Model-based likelihood |

> 🔗 Recall from **02a**: Just as `CHROM` naming must match your reference, `QUAL` values should only be compared among variants called by the same tool.

> ⚠️ **Key rule:**  
> `QUAL` values are **not comparable across different callers**.


## 3️⃣ Missing QUAL Values

If `QUAL` is unavailable or undefined:
```
QUAL = .
```

This can occur when:
- Variants are force-called
- Structural variants are symbolically represented
- The caller does not compute a single-site quality

🚫 **Do not assume** missing `QUAL` means low quality.


## 4️⃣ Common Misconceptions About QUAL

| Myth | Reality |
|-----|---------|
| High QUAL = true variant | ❌ Only statistically confident |
| Low QUAL = false variant | ❌ May be real but poorly supported |
| QUAL is per-sample | ❌ It is site-level |
| QUAL measures biological importance | ❌ It measures call confidence only |


## 5️⃣ When `QUAL` Is Useful

`QUAL` is commonly used for:
- Preliminary filtering
- Ranking variants by confidence
- Quality control diagnostics
- Comparing variant sets from the **same caller**

Example:
```
QUAL >= 30
```

> ⚠️ **Never filter blindly.**  
> Thresholds must be dataset- and caller-specific.


## 🚨 Common QUAL Pitfalls

| Pitfall | Rule / Consequence |
|--------|---------------------|
| Applying FILTER logic without checking QUAL | Misinterpretation |
| Using universal QUAL cutoffs | Removes true variants |
| Treating QUAL as biological relevance | Conceptual error |


***✅ One-Sentence Takeaway (QUAL)***
**`QUAL` is a Phred-scaled measure of statistical confidence — not biological truth or importance.**

> Note: Per-sample confidence is represented by `GQ`, not `QUAL`, and is covered in the next lesson.


## 🧬 VCF Column 7: FILTER (Filter Status)

### Overview

`FILTER` indicates whether a variant **passed or failed** a predefined set of quality filters.

It answers the question:
> **“Did this variant meet the caller’s quality criteria?”**

> **🧠 Mental Model**
> `FILTER` is the Verdict, while `QUAL` is the Evidence.


## 1️⃣ Allowed FILTER Values

- `PASS`: The variant met all quality criteria.
- Named Filters (e.g., `LowQual`, `StrandBias`): The variant failed these specific checks.
- `.` (Dot): No filtering was applied to this record.


## 2️⃣ Multiple Failed Filters

Multiple filters are separated by semicolons:
```
FILTER = LowQual;LowDepth
```

This indicates **multiple independent issues**.


## 3️⃣ FILTER Definitions Live in the Header

Every label in the `FILTER` column must be defined in the VCF header.
If you see LowDepth in the table, you must find a corresponding line in the header:
```
##FILTER=<ID=LowDepth,Description="Total read depth below 10">
```

> ⚠️ **Critical rule:**  
> If a `FILTER` label is not defined in the header, the VCF is **invalid**.


### 4️⃣ PASS Does *Not* Mean “True”

This is one of the most dangerous misconceptions.

| Interpretation | Correct? |
|---------------|----------|
| PASS = real variant | ❌ |
| PASS = met caller criteria | ✅ |
| FILTERed = false variant | ❌ |
| FILTERed = failed specific checks | ✅ |

Filtering rules are:
- Caller-specific
- Pipeline-dependent
- Often conservative


## 5️⃣ When FILTER Is Most Useful

`FILTER` is essential for:
- Rapid quality control
- Downstream filtering logic
- Reproducibility
- Pipeline auditability

Example:
```
FILTER == PASS
```
Used cautiously, this is reasonable.


## 6️⃣ FILTER vs QUAL (Side-by-Side)

| Aspect | QUAL | FILTER |
|------|------|--------|
| Type | Numeric (Phred-scaled) | Categorical (Label) |
| Scope | Statistical confidence | Rule-based decision |
| Definitions | Model-dependent | Header-defined (##FILTER) |
| Biologically meaningful | No | No |
| Used for filtering | Yes | Yes |

> 🧠 **Key insight:**  
> `FILTER` often uses `QUAL` internally — but they are **not interchangeable**.
Example:
A variant with QUAL = 25 may receive FILTER = LowQual if the pipeline threshold is QUAL < 30.


## 🚨 Common FILTER Pitfalls

| Pitfall | Rule / Consequence |
|--------|---------------------|
| Assuming PASS = True | Overconfidence; PASS variants can still be artifacts. |
| Ignoring missing QUAL (.) | Misinterpreting why a variant failed (e.g., what does RF mean?). |
| Mixing Filter Logic | Applying GATK filters to bcftools data leads to inconsistent results. |
| Hard-dropping filtered sites | Irreversible data loss; better to flag than to delete. |


**✅ One-Sentence Takeaway (FILTER)**

**`FILTER` records whether a variant met predefined quality rules — not whether it is biologically real or important.**

---
## 🔗 Concept Bridge — Quality Is Not Truth

> 🧠 **Final intuition**
>
> - `CHROM` + `POS` tell you **where**
> - `REF` + `ALT` tell you **what**
> - `QUAL` + `FILTER` tell you **how confident**
>
> None of these tell you **whether the variant matters biologically**.


## ➡️ What’s Next?

Up to now, we have looked at data that describes the **variant site** as a whole. In the next lesson, we cross the **"Genotype Divide"** to learn how to distinguish between global data (`INFO`) and data unique to each individual sample (`FORMAT`).

Continue to:

**[03-info-vs-format.md](./03-info-vs-format.md)**