# 🧬 02b — Allelic Data (REF, ALT)
> 📘 **VCF Spec Alignment:** This lesson follows VCF v4.2+ conventions. Differences for earlier versions are noted where relevant.

## 📌 Introduction: Allelic Data in VCF

This lesson builds directly on **positional** data and covers the second group of fixed VCF columns: **allelic data** (`REF`, `ALT`). These columns only make sense once **`CHROM`** and **`POS`** are correct.

If `CHROM` and `POS` tell you **where a variant is**,
`REF` and `ALT` tell you **what changed**.

These two columns encode the exact nucleotide-level difference between the **reference genome** and the **observed variant**.

> ⚠️ **Blunt truth:**
> If you misunderstand `REF` and `ALT`, every downstream analysis—annotation, frequency calculation, pathogenicity inference—is compromised.

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:

- Interpret `REF` and `ALT` for **SNPs**, **insertions**, **deletions**, and **replacements**

- Explain why `REF` must match the **reference genome** exactly

- Understand anchoring rules for indels

- Correctly reason about **multi-allelic variants**

- Identify and diagnose **common allelic representation errors**

## 🧬 VCF Column 4: REF (Reference Allele)

## Overview

**`REF`** represents the **exact nucleotide sequence** present in the **reference genome** at the position specified by **`CHROM`** and **`POS`**.

> **🧠 Mental model**
> REF is the ground truth.
> It is what the reference genome says must be there.

## Core rules (non-negotiable)

- `REF` must exactly match the reference FASTA at `CHROM:POS`

- `REF` is written **5' → 3'**

- `REF` is never empty

- `POS` always points to the first base of `REF`

If any of these fail, the VCF record is invalid.

## Simple SNP example
```
CHROM POS REF ALT
1     1000 A   G
```

**Interpretation**

- Reference base at position 1000 is **A**
- The sample shows **G** instead


## 1. What `REF` Actually Represents

Let’s eliminate common misconceptions immediately:

- `REF` is **not** “the original base”
- `REF` is **not** “the common allele”
- `REF` is **not** chosen from your samples
- `REF` is **not** guaranteed to be biologically correct

`REF` is **only** the allele present in the **reference genome assembly** at that coordinate.

If the reference genome says:
```
chr7:140453136 = A
```
Then:

`REF` = `A`

Even if:

- 100% of your samples have **`G`**
- The reference allele is rare in the population
- The reference genome is outdated or wrong

VCF does not care.

**VCF logic:**  
`REF` is **reference-anchored**, not biology-anchored.


## 2. `REF` Is Assembly-Dependent (Critical Concept)

`REF` only makes sense relative to a **specific genome build**.

The same coordinate can have different `REF` alleles across assemblies.

| Genome Build | Coordinate     | `REF` |
|-------------|----------------|-----|
| GRCh37      | chr1:12345     | `A`   |
| GRCh38      | chr1:12345     | `G`  |

> 🧭 **Visual intuition — why assemblies matter**
>
> Think of a genome assembly as a *specific edition of a book*.
>  
> The **page number** (CHROM + POS) might be the same,
> but the **word printed there** (`REF`) can differ between editions.
>
> That is why:
> - `chr1:12345` in GRCh37 ≠ `chr1:12345` in GRCh38
> - A VCF is meaningless without knowing *which edition* was used

This is why every valid VCF **must declare its reference genome**:
##reference=GRCh38

> **Hard truth:**  
> A VCF without a declared reference genome is scientifically weak and should not be trusted.


## 3. `REF` Length Is Not Arbitrary

**Rule:**  
The length of `REF` defines the **span of the variant**.

| `REF` | Meaning              |
|-----|----------------------|
| `A`   | Single-base event    |
| `AT`  | Two-base event       |
| `ATG` | Three-base event     |

`POS` + `REF` together define the **exact genomic interval** affected.


## 4. `REF` Is Always Non-Empty

This is enforced by the VCF specification:

- `REF` cannot be `.`
- `REF` cannot be empty
- `REF` cannot be inferred

If `REF` is missing, the record is invalid.

**Why?**  
You cannot define a change without defining what existed first.


## 5. `REF` Must Match the Reference Genome Exactly

This is a **hard validation rule**, not a guideline.

If the reference genome contains:
```
chr2:2001–2003 = ATC
```

Then this is valid:

`POS` = 2001
`REF` = ATC


This is invalid:

`REF` = ATG

Even if sequencing strongly supports **ATG**.

**Blunt reality:**  
If `REF` does not match the reference genome, the VCF record is wrong.


## 6. `REF` and `POS` Are Inseparable

`REF` is meaningless without `POS`.

Together, they define the genomic interval:

[`CHROM` : `POS` → `POS` + len(`REF`) − 1]

**Example**
`CHROM` = 5
`POS`   = 100
`REF`   = ATG

This variant spans:

chr5:100–102

This logic underpins:

- Variant overlap
- Functional annotation
- Normalization
- Visualization (e.g., IGV)
- Dataset comparison and merging


## 7. `REF` as an Anchor (Why Indels Look “Odd”)

> 🔗 Recall from 02a: As seen in the [Indel Anchor Diagram], the REF base at POS provides the fixed starting point for the insertion or deletion.

**Example:**

`REF` = G
`ALT` = GTT


Why include `G`?

Because **VCF does not allow zero-length alleles**.

REF provides:

- A positional anchor
- A stable coordinate
- An unambiguous reference point

> **Key insight:**  
> `REF` is the fixed point against which change is described.


## 8. `REF` Is Not “What Most Samples Have”

This misconception quietly destroys analyses.

Even if:

- `REF` is rare
- `ALT` is common

VCF will still encode:

`REF` = rare allele
`ALT` = common allele

Because:

- `REF` ≠ wild-type  
- `REF` ≠ ancestral  
- `REF` ≠ major allele  

`REF` is **only** the reference genome allele.


## 9. 🚨 Common REF-Related Pitfalls
> 🚫 **Hard-stop errors:** Any of the following invalidate the VCF record.

| Pitfall | Rule / Consequence |
|--------|---------------------|
| `REF` does not match the reference genome | Variant is invalid and must be discarded |
| `REF` length does not match the implied interval | Genomic span is misdefined, breaking annotation and overlap logic |
| `REF` and `ALT` share no anchor base in indels | Violates VCF anchoring rules and shifts coordinates |
| `REF` differs across VCFs using the same assembly | Indicates reference inconsistency and prevents reliable merging |

These are **data integrity failures**, not formatting issues.

**One-sentence takeaway:**  
**`REF` is the exact allele found in the reference genome at a defined coordinate; it is assembly-dependent, non-negotiable, and foundational.**


---

## 🧬 VCF Column 5: ALT (Alternate Allele)

## Overview
**`ALT`** lists one or more **alternative alleles** observed in the sample that differ from `REF`.

> 🧠 **Mental model**  
> `ALT` answers: *“What was observed instead of the reference?”*

## Allowed Values
- One or more nucleotide sequences (`G`, `T`, `AG`)
- Symbolic alleles (`<DEL>`, `<INS>`, `<DUP>`)
- Multiple alleles separated by commas


## Variant Types Explained (Core Concepts)

## 1. Single-Nucleotide Polymorphisms (SNPs)

`REF` = A
`ALT` = G

Exactly one base changes.


## 2. Insertions

**Rule:** Insertions include the anchor base in both `REF` and `ALT`.

```
CHROM POS REF ALT
1     1500 A   AGT
```

**Interpretation**
> - A is present in the reference
> - GT is inserted **after** position 1500

> **⚠️ Warning:**
> **There is no such thing as an empty `REF` in VCF.**


## 3. Deletions

```
CHROM POS REF   ALT
1     2000 ATC   A
```

**Interpretation**
> - Reference has ATC
> - TC is deleted
> - A anchors the variant


## 4. Replacements (Multi-Base Substitutions)
```
CHROM POS REF  ALT
1     5000 ACG  TTT
```

**Interpretation**
> Three bases are replaced by three different bases.

> 🧠 **Mental model — think in spans, not letters**
>
> This is **one variant affecting a contiguous interval**, not multiple SNPs.
>
> ```
> Reference:  A C G
> Variant:    T T T
>             ↑ ↑ ↑
> ```
>
> The entire span defined by `REF` is replaced *as a unit*.
>
> ➜ This matters for:
> - Functional annotation
> - Protein impact prediction
> - Variant normalization

## Multi-Allelic Sites
```
CHROM POS REF ALT
2     1000 A   G,T
```

- ALT[1] = G
- ALT[2] = T

All alternates share the same `CHROM`, `POS`, and `REF`.

> **🧠 Mental Model**
> **Genotypes reference ALT alleles by **index** (covered later).**

## Symbolic ALT Alleles (Structural Variants)

```
1  12345  A  <DEL>  .  PASS  SVTYPE=DEL;END=13000
```

**Key points**
- `REF` anchors the variant at `POS`, even though the full affected interval is defined via `INFO` fields such as `END` and `SVLEN`.
- Size and nature are defined in `INFO`
- Used for large or imprecise variants

## 5. Normalization and Minimal Representation

> 🔗 Recall from 02a: POS must be the leftmost coordinate. Normalization ensures allelic representation obeys that rule.
VCF requires variants to be:

- **Left-aligned**
- **Minimally represented**

**Bad (unnormalized)**
```
POS  REF   ALT
100  AATC  AAT
```

**Good (normalized):**
```
POS  REF  ALT
101  ATC  AT
```

🛠️ **Tools**

- `bcftools norm`
- `vt normalize`

> Always normalize before merging or comparing VCFs.


## 6. 🚨 Common Allelic Pitfalls

| Pitfall | Rule / Consequence |
|--------|---------------------|
| `REF` doesn’t match FASTA | Variant is invalid and must be discarded |
| Empty `REF` or `ALT` | Not allowed by the VCF specification |
| Wrong indel anchoring | Shifts coordinates and breaks interpretation |
| Insertion/deletion confusion | Leads to incorrect variant classification |
| Skipping normalization | Causes duplicate or incomparable variants |


**One-sentence takeaway:**  
`REF` defines what the reference genome contains; `ALT` defines what was observed instead—together, they encode the precise molecular change.

---

> 🧬 **Concept bridge — how alleles become genotypes**
>
> `REF` and `ALT` define the **possible alleles** at a genomic location.
>  
> The **genotype (GT)** later specifies **which of those alleles each sample carries**.
>
> ```
> REF = A
> ALT = G
>
> Allele index:
>   0 → A (REF)
>   1 → G (ALT)
>
> Example genotypes:
>   0/0 → A/A  (homozygous reference)
>   0/1 → A/G  (heterozygous)
>   1/1 → G/G  (homozygous alternate)
> ```
>
> ➜ **Key insight:**  
> Genotypes do **not** store nucleotides — they store **indexes into REF/ALT**.

## ➡️ What’s Next

**02c — Quality & Status (`QUAL`, `FILTER`)**  
We stop asking *what changed* and start asking:

**“Do we trust this variant?”**