## 🧬 02a — Positional Data (`CHROM`, `POS`, `ID`)
> 📘 **VCF Spec Alignment:** This lesson follows VCF v4.2+ conventions. Differences for earlier versions are noted where relevant.

## 📌 Introduction: Positional Data in VCF

In Lesson 01, we learned that every VCF file is divided into a **Header** (metadata lines starting with `##`) and a **Body** (the variant table).

This lesson focuses on the **first group of fixed columns** in the VCF Body: **positional data**.

Each variant line represents a **single genomic location** that differs from the reference genome.  
The first three columns — **`CHROM`, `POS`, and `ID`** — act as the *address and identifier* for that variant.


### Why are these columns grouped together?

The VCF specification defines nine fixed columns, which can be conceptually grouped as follows:

| Group | Purpose | Columns |
|-----|--------|--------|
| Positional | Defines where the variant is located | CHROM, POS, ID |
| Allelic | Defines what changed | REF, ALT |
| Quality & Status | Defines confidence and validity | QUAL, FILTER |
| Metadata Pointers | Defines annotation and sample schemas | INFO, FORMAT |

This lesson covers **only the positional group**.

## 🎯 Learning Objectives

By the end of this lesson, you will be able to:

- Explain the role of **`CHROM`, `POS`, and `ID`** in uniquely defining a variant
- Interpret positional coordinates for **SNPs, indels, and structural variants**
- Identify common **reference compatibility and sorting errors**
- Confidently verify positional data against a reference genome


# 🧬 VCF Column 1: `CHROM` (Chromosome)

## Overview

**`CHROM`** specifies **which reference sequence (chromosome or contig)** a variant is located on. It is the **first mandatory column** in every VCF data record and, together with **`POS`**, defines the genomic coordinate of a variant.

> **Quick intuition:** `CHROM` answers the question: *“On which chromosome (or contig) does this variant occur?”*
> 🧠 **Mental model**
> Think of **`CHROM`** as the *street name* in a mailing address.
> Without it, the house number (POS) is meaningless.


## Basic example

```
#CHROM  POS     ID  REF ALT QUAL FILTER INFO
1       879317  .   G   A   120  PASS   DP=45
```

**Interpretation:** The variant occurs on **chromosome 1** at position **879,317** in the reference genome.


## 1. What values can appear in `CHROM`?

The allowed values depend entirely on the **reference genome** used for variant calling.

### Human genomes (common)

* **Autosomes:** `1`–`22`
* **Sex chromosomes:** `X`, `Y`
* **Mitochondrial DNA:** `MT`, `M`, or `chrM`

### With or without `chr` prefix

Depending on the pipeline, you may see:

* `1`, `2`, `X`, `MT`
* `chr1`, `chr2`, `chrX`, `chrMT`

Both styles are valid **as long as they exactly match the reference genome**.


## 2. CHROM comes directly from the reference genome

> ⚠️ **Critical:** `CHROM` values **must exactly match** the sequence names in the reference FASTA (`.fa`) and its index (`.fai`).

> ⚠️ **Critical term — Reference compatibility:**
> The requirement that CHROM names in a VCF exactly match the sequence names in the reference FASTA used for alignment and variant calling.

### Example conventions

* **GRCh38** (often):
```
  chr1 chr2 … chr22 chrX chrY chrM
```
  
* **GRCh37** (often):
```
  1 2 … 22 X Y MT
```

>⚠️ **Mismatch warning:**
>If your VCF uses `chr1` but the reference uses `1`, tools such as **bcftools**, **GATK**, or **samtools** may error, skip records, or fail annotation.


## 3. `CHROM` and sorting requirements

VCF files are expected to be **sorted by `CHROM`, then by `POS`**, following the sequence order defined by the reference index.

Typical human order:

```
1 → 2 → … → 22 → X → Y → MT
```

(or the equivalent `chr*` names)

Correct sorting example:

```
1
1
2
3
...
X
Y
MT
```

> 🛠️ **Key tool prep:** Tools like **tabix** rely on correct `CHROM` order to build indexes that enable fast genomic lookups. Improper sorting can cause indexing failures or subtle downstream errors.


## 4. `CHROM` in non-human genomes

VCF is species-agnostic. `CHROM` simply names a **reference sequence**.

Examples:

* **Assemblies/contigs:** `scaffold_1`, `contig000234`
* **Human alternate loci:** `chrUn_gl000220`, `chr17_KI270729v1_random`
* **Bacteria:** `chr`, `plasmid1`
* **Plants:** `1`, `2`, `chloroplast`, `mitochondria`

There is no restriction on naming beyond matching the reference FASTA.


## 5. `CHROM` and ploidy

`CHROM` is **independent of ploidy**.

* Diploid, triploid, or polyploid organisms all use `CHROM` the same way.
* Ploidy affects **genotype fields**, not `CHROM`.


## 6. Realistic multi-chromosome example

```
#CHROM  POS     ID    REF ALT QUAL FILTER INFO
chr1    12345   .     A   G   99   PASS   DP=20
chr1    77456   .     T   C   80   PASS   DP=18
chr2    34567   rs12  C   T   90   PASS   DP=22
chrX    87655   .     G   A   75   PASS   DP=25
chrMT   2043    .     A   C   60   PASS   DP=30
```


## 7. Why `CHROM` matters

> **Why this column is critical:**
> `CHROM` determines *where* in the genome a variant belongs and underpins nearly every downstream operation.

`CHROM` is essential because it:

* Defines the **genomic context** of a variant
* Is required for **indexing** (e.g., tabix)
* Controls **sorting, merging, and filtering**
* Enables visualization (e.g., Manhattan plots)
* Is required for accurate **annotation** (dbSNP, gnomAD, ClinVar)

A naming mismatch is one of the **most common causes of pipeline errors**.

Example warning:

```
[warning] Site 1:234567 not found in reference — skipping
```


## 8. 🚨 Common Pitfalls (Read This Carefully)

| Pitfall | Rule / Consequence |
| :--- | :--- |
| **Mixed Naming Conventions** | Tools will fail or skip records if VCF uses `chr1` and reference uses `1` (or vice versa). **Rule:** Normalize names to match FASTA. |
| **Unrecognized Contigs** | Non-standard sequences (e.g., alternate loci) may be ignored by analysis tools. |
| **Incorrect Sorting** | Breaks indexing (e.g., `tabix`) and merging operations. **Rule:** Must be sorted by `CHROM`, then `POS`. |
| **Case Sensitivity Issues** | `chrX` $\neq$ `CHRX`. **Rule:** Ensure exact case matching with the reference FASTA names. |


## **One-sentence takeaway**

**`CHROM` identifies the exact reference sequence a variant belongs to, and it must be reference-compatible and correctly ordered for reliable genomic analysis.**


---

# 🧬 VCF Column 2: `POS` (Position)

## Overview

`POS` is the 1-based coordinate on the reference sequence that marks the first base of the `REF` allele affected by a variant. It is the second mandatory column in every VCF data line and, together with `CHROM` and `REF`, uniquely defines the genomic location of a variant.

> 🧠 **Mental model**
> `POS` is the *house number* on a chromosome street.
> It always points to the **first base of the `REF` allele**, never the `ALT`.
> Always counting from **1**, never zero.

> 🔗 **Recall from CHROM:** `POS` only makes sense **within** the reference sequence defined in the `CHROM` column. Together, they form the core coordinate.


> ⚠️ `POS` alone does **not** uniquely define a variant — only the combination
> **`CHROM` + `POS` + `REF` (+ `ALT`)** does.

> **VCF is always 1-based.**


## 1. `POS` is 1-based (critical rule)

* VCF uses 1-based coordinates.

* `POS` = 1 → first base of the chromosome

* `POS` = 1000 → thousandth base

> ⚠️ **Critical:** Confusing 0-based formats (BED) is the most common source of off-by-one errors.
> Other formats (such as BED) use 0-based, half-open coordinates. Confusing these systems is the single most common source of variant coordinate errors, leading to incorrect annotation, visualization, and analysis.

> **VCF is always 1-based.**


## 2. `POS` always anchors the first base of `REF`

Regardless of variant type—SNPs, insertions, deletions, replacements, or structural variants—`POS` always points to the first base of the `REF` allele encoded in the VCF record.

**SNP example**
```
CHROM  POS   REF  ALT
1      1000  A    G
```

→ At position 1000, reference base `A` is **replaced by** `G`.

**Deletion example**
```
CHROM POS   REF   ALT
1     2000  ATC   A
```

→ `REF` spans positions 2000–2002 (`ATC`).
→ `ALT` = `A` means `TC` is **deleted**.
→ `POS` = 2000 anchors the first `REF` base.

**Insertion example**
```
CHROM POS REF ALT
1     1500 A   AGT
```

→ `POS` anchors base `A` at 1500.
→ Bases `GT` are **inserted after** position 1500.


## 3. `POS` in structural variants (SVs)

For large variants, `POS` marks the start coordinate, while the end is stored in the `INFO` field.

```
1  12345  .  A  <DEL>  .  PASS  SVTYPE=DEL;END=13000
```

- `POS` = 12345 → approximate start

- `END` = 13000 → approximate end

Exact semantics depend on the **variant caller**.


## 4. Repeats and the leftmost (lowest) coordinate rule

In repetitive regions, a variant may be representable at multiple positions. The VCF specification requires using the leftmost (lowest possible) coordinate.

**Reference:**
```
... ACACAC ...
```

Deletion of `AC` could be placed in multiple positions, but VCF mandates choosing the lowest coordinate.

**Why this matters:**

* Ensures consistent representation

* Prevents duplicate variants

* Improves merging and comparison


## 5. Minimal representation and normalization

Variants should be represented in their minimal form, trimming shared bases while keeping the leftmost anchor.

**Common normalization tools:**

* bcftools norm

* vt normalize

Normalization is strongly recommended before **merging**, **comparing**, or **annotating** VCF files.


## 6. POS must match the reference FASTA

The combination **`CHROM` + `POS` + `REF`** must match the reference genome exactly.

If the `REF` allele does not match the FASTA at `POS`, tools will error or skip the record.

>**Always ensure:**

> * Same reference build

> * Same FASTA file

> * Same chromosome naming convention


## 7. Sorting requirement

**VCFs must be sorted by:**

- `CHROM` (reference order)

- `POS` (ascending)

**Unsorted VCFs can break:**

- tabix indexing

- file merging

- streaming analyses

## 8. Multi-allelic sites

A single `POS` may have multiple `ALT` alleles.

```
2  1000  .  A  G,T  50  PASS  .
```

```ALT[1] = G```

```ALT[2] = T```

**All ALTs share the same `CHROM`, `POS`, and `REF`.**

## 9. Indel coordinate examples (intuition builder)
**Deletion**
Reference sequence (with positions):

A₉₉₉ | A₁₀₀₀ T₁₀₀₁ C₁₀₀₂ | G₁₀₀₃

VCF:
```
1  1000  ATC  A
```

> **Effect: POS (1000) anchors ATC. Bases TC are deleted.**

**Insertion**

Reference:

A₁₄₉₉ | A₁₅₀₀ | C₁₅₀₁

VCF:
```
1  1500  A  AGT
```

> **Effect: POS anchors A. Bases GT are inserted after position 1500.**

**Replacement**

Reference (5000–5002): ACG
```
1  5000  ACG  TTT
```

> **Effect: three-base replacement starting at position 5000.**

## 10. Context: Liftover and reference changes

POS is reference-dependent.

During liftover (e.g., `GRCh37` → `GRCh38`):

- `POS` may change

- `REF/ALT` may change

- Some variants may fail to map

- Post-liftover inconsistencies usually indicate reference differences.

## 11. Imprecise breakpoints

Structural variants may include uncertainty:
```
1  12345  .  N  <DEL>  .  .  SVTYPE=DEL;END=20000;IMPRECISE;CIPOS=-10,20;CIEND=-15,25
```

**This indicates confidence intervals around `POS` and `END`.**

> 🧩 **Note on symbolic alleles**
> When ALT is symbolic (e.g., `<DEL>`), POS still anchors the reference base,
> but the exact affected interval is defined using INFO fields such as `END`,
> `SVLEN`, and confidence intervals.

## 12. 🚨 Common POS Pitfalls

| Pitfall | Solution / Rule |
| :--- | :--- |
| Off-by-one errors | Always confirm 1-based coordinates. |
| REF mismatch | Ensure reference FASTA compatibility. |
| Unnormalized Indels | Normalize before merging or comparing. |
| Unsorted VCF | Sort before indexing (`bcftools sort` and `tabix`). |
| Repeat ambiguity | Left-normalize and use minimal representation. |

## **One-sentence takeaway**

**`POS` is the 1-based reference coordinate that anchors the first base of the `REF` allele, precisely fixing every variant in genomic space.**




---

# 🧬 VCF Column 3: `ID` (Identifier)

## Overview

`ID` is a column used to provide a unique identifier for a variant, usually referencing a known variant database such as `dbSNP`. It is the third mandatory column in a VCF data record.

**Quick intuition:** ID answers the question: “Does this variant already have a name or identifier in a database?”
> 🧠 **Mental model**
> ID is a *nickname*, not an address.
> Useful — but never authoritative.

> 🔗 **Recall from `POS`:** The `ID` provides a *name*, but the variant's *location* is rigidly defined by the combination of **`CHROM`** and **`POS`**.


## 1. What values can appear in `ID`?

* `.` **(dot)**: No known identifier for this variant.
* **Database IDs**: Typically from `dbSNP` (rs IDs), but can also be from ClinVar, COSMIC, or custom variant sets.

| #CHROM | POS | ID | REF | ALT | QUAL | FILTER | INFO |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | 879317 | **.** | G | A | 120 | PASS | DP=45 |
| 1 | 879500 | **rs55555** | T | C | 200 | PASS | DP=60 |

**Interpretation:**
- Line 1 → Novel variant, no known database entry (.).
- Line 2 → Known variant with dbSNP ID rs55555.

## 2. `ID` and variant uniqueness

* The `ID` does not define the genomic position — that is determined by **`CHROM` + `POS` + `REF` + `ALT`.**

* It is simply a reference pointer to facilitate lookup, annotation, and cross-referencing with external datasets.

## 3. Multiple IDs

* If a variant is recorded in multiple databases, IDs are semicolon-separated:
```
1  123456  rs12345;COSM67890  A  G  99  PASS  DP=30
```

* `rs12345` → `dbSNP` entry

* `COSM67890` → COSMIC (somatic mutation database) entry

> 🧩 **Note:** Tools like **VEP**, **ANNOVAR**, or bcftools can handle multiple IDs automatically if semicolons are present.

## 4. Novel variants

* Novel variants discovered in your dataset often have . as `ID`.

* After submission to a database, they may later receive a permanent identifier.

## 5. Why `ID` matters

* Facilitates cross-study comparisons.

* Enables annotation pipelines to add clinical or population information.

* Helps in filtering known vs novel variants during analysis.

**Example warning:**
```
[info] Variant 1:879317 not in dbSNP → likely novel
```
## 6. 🚨 Common pitfalls

| Pitfall | Rule / Consequence |
| :--- | :--- |
| **Assuming ID defines the variant** | The ID is just a label; the variant is defined by **CHROM+POS+REF+ALT**. |
| **Using outdated databases** | IDs may be deprecated or reassigned, leading to incorrect references. |
| **Parsing multiple IDs** | Tools must be configured to handle semicolon-separated IDs (e.g., `rs123;COSM678`) correctly. |

## **One-sentence takeaway**

**`ID` links a variant to external databases, providing a reference name but does not define the variant itself.**

---

## ➡️ What’s Next?

Now that you can **locate and uniquely identify** a variant in the genome, the next step is to understand **what actually changed at that location**.

Continue to **[02b-allelic-data.md](./02b-allelic-data.md)** to learn how the **`REF` and `ALT`** columns represent SNPs, insertions, deletions, and replacements.