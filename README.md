# Sentinel Firewall

This repository contains the manuscript, reproducible code, local-
adaptation workbook, figures, and supplementary materials for:

**The Sentinel Firewall: A Health-System Strategy to Decouple Informal
Industrialization from Lead Exposure in LMICs**

The project asks whether maternal and child health systems can reduce
lead exposure by replacing hazardous consumer products with safer
substitutes in sentinel-identified high-risk areas.

## Start here

If you want the clean public package for readers, reviewers, ministries,
or NGOs, begin with:

- [submission_package/README.md](submission_package/README.md)

That file identifies the authoritative manuscript, code, workbook, and
public outputs, and explains the difference between the deterministic
spreadsheet and the full Monte Carlo model.

## Core public materials

The main files most readers will want are:

- `submission_package/public_code_and_data/sentinel_firewall_model.py`
- `submission_package/public_code_and_data/Simulating_sentinel_safe_products.xlsx`
- `submission_package/public_code_and_data/summary_table.csv`
- `submission_package/public_code_and_data/validation_checks.csv`
- `submission_package/main_manuscript/manuscript_bmj_ready_from_word_cleaned.docx`
- `submission_package/supplementary_materials/technical_appendix.docx`
- `submission_package/supplementary_materials/parameter_citation_table.docx`

The main paper figures are:

- `submission_package/figures_main/figure_1_kitchen_cognition_pathway.png`
- `submission_package/figures_main/figure_2_bcr_distribution.png`

## Repository structure

- `submission_package/`
  Current paper-ready package, including the manuscript, appendices,
  public code, public workbook, figures, policy brief, and synced
  output tables.
- `outputs/`
  Latest local rerun outputs used to sync the public package.
- `source_inputs/`
  Local working notes and source materials.
- `archive/`
  Superseded working files and old drafts.

## Reproducing the analysis

Run the Python model from the repository root or from
`submission_package/public_code_and_data/`:

```powershell
python sentinel_firewall_model.py
```

The script writes:

- trial-level compressed CSVs
- `summary_table.csv`
- `validation_checks.csv`
- main and supplementary figures
- `Simulating_sentinel_safe_products.xlsx`

## Current public repository URL

- [https://github.com/levine63/Sentinel-Firewall](https://github.com/levine63/Sentinel-Firewall)

## Archived release DOI

- [https://doi.org/10.5281/zenodo.19898684](https://doi.org/10.5281/zenodo.19898684)

## Notes

- The Excel workbook is a deterministic, mode-only local-adaptation
  tool. It is meant to be easy to edit, not to reproduce the paper's
  Monte Carlo medians exactly.
- The Python script is the authoritative probabilistic model used for
  the paper's uncertainty analysis and figures.
