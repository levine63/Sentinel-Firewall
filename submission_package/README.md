# Sentinel Firewall Submission Package

This folder contains the current manuscript, supplementary files, figures, code, and local-adaptation workbook for:

**The Sentinel Firewall: A Health-System Strategy to Decouple Informal Industrialization from Lead Exposure in LMICs**

## Authoritative files

Use these files as the current source of truth:

- Main manuscript source: `main_manuscript/manuscript_bmj_ready_from_word_cleaned.md`
- Main manuscript Word file: `main_manuscript/manuscript_bmj_ready_from_word_cleaned.docx`
- Technical appendix: `supplementary_materials/technical_appendix.md`
- Parameter appendix: `supplementary_materials/parameter_citation_table.md`
- Public Python model: `public_code_and_data/sentinel_firewall_model.py`
- Public deterministic workbook: `public_code_and_data/Simulating_sentinel_safe_products.xlsx`
- Public Monte Carlo summary table: `public_code_and_data/summary_table.csv`
- Public validation checks: `public_code_and_data/validation_checks.csv`

Older manuscript drafts and superseded convenience copies have been moved to `archive/` to reduce confusion.

## Public repository

The public repository is:

- `https://github.com/levine63/Sentinel-Firewall`

The archived Zenodo record is:

- `https://doi.org/10.5281/zenodo.19898684`

Planned public file links:

- `https://github.com/levine63/Sentinel-Firewall/blob/main/submission_package/public_code_and_data/sentinel_firewall_model.py`
- `https://github.com/levine63/Sentinel-Firewall/blob/main/submission_package/public_code_and_data/Simulating_sentinel_safe_products.xlsx`

## Current headline results

These values come from the latest synced Monte Carlo rerun and should match:

- `public_code_and_data/summary_table.csv`
- `main_manuscript/manuscript_bmj_ready_from_word_cleaned.md`
- the figures in `figures_main/` and `supplementary_materials/`

Current cognition-only benefit-cost ratios:

- Kitchen Package: median `5.60`, 5th-95th percentile `2.00-15.30`, `0.30%` below parity
- Kohl Package: median `5.89`, 5th-95th percentile `1.83-17.17`, `0.62%` below parity

Current total benefit-cost ratios:

- Kitchen Package: median `6.73`, 5th-95th percentile `2.62-17.35`, `0.05%` below parity
- Kohl Package: median `6.49`, 5th-95th percentile `2.12-18.14`, `0.27%` below parity

## Important distinction: workbook versus Monte Carlo model

The Excel workbook is a **deterministic mode-only local-adaptation tool**.

- It uses one active value per parameter.
- It does **not** reproduce the manuscript medians exactly.
- It is intended for ministries, NGOs, and local researchers who want to swap in local values quickly.

The Python script is the **authoritative probabilistic model**.

- It runs the `10,000`-draw Monte Carlo analysis.
- It generates the publication figures and trial-level outputs.
- It should be used whenever the question is about the paper's reported uncertainty results.

## Folder structure

### `main_manuscript/`

- current manuscript source and DOCX

### `figures_main/`

- `figure_1_kitchen_cognition_pathway.*`
- `figure_2_bcr_distribution.*`

### `supplementary_materials/`

- technical appendix
- parameter citation appendix
- supplementary figures and tornado diagrams
- copy of the public workbook for convenience

### `public_code_and_data/`

- public Python model
- public deterministic workbook
- synced summary and validation CSVs

### `policy_brief/`

- current policy brief source and DOCX

### `presentation/`

- economist talk source and slide deck

### `archive/`

- superseded workbook/manuscript convenience copies

## Reproducing the model outputs

From the repository root or from `submission_package/public_code_and_data/`:

```powershell
python sentinel_firewall_model.py
```

The script writes:

- trial-level compressed CSVs
- `summary_table.csv`
- `validation_checks.csv`
- main and supplementary figure files
- `Simulating_sentinel_safe_products.xlsx`

When syncing the package, the current public copies should always be taken from the latest rerun.

## Submission guidance

Recommended manuscript file:

- `main_manuscript/manuscript_bmj_ready_from_word_cleaned.docx`

Recommended figure uploads:

- `figures_main/figure_1_kitchen_cognition_pathway.png`
- `figures_main/figure_2_bcr_distribution.png`
- supplementary figures from `supplementary_materials/` if requested

## Consistency checks already completed

- Main manuscript numbers synced to the latest Monte Carlo rerun
- Public `summary_table.csv` and `validation_checks.csv` synced to the latest rerun
- Workbook language clarified to distinguish deterministic mode-only outputs from manuscript Monte Carlo results
- Productivity definition aligned across manuscript, appendix, workbook, and code as:
  - `GDP PPP per capita x labour share of national income`
- Obsolete tax-recoup reporting removed from the current manuscript-facing package

## Final caution

If any substantive parameter changes are made in the Python model, you should re-run the script and then resync all of the following together:

- manuscript numbers
- policy brief numbers
- public `summary_table.csv`
- public `validation_checks.csv`
- workbook
- main and supplementary figures

That keeps the repository internally consistent for reviewers and readers.
