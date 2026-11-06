# Notitia Civica

Notitia Civica is a public-interest publication that turns public signals into newsworthy civic and geopolitical reporting.

It publishes civic intelligence briefs, geopolitical analysis, narrative-operations reporting, story leads, signal maps, and research notes derived from public records, reporting, official statements, filings, disclosures, and structured open-source research workflows.

SPEC-1 is the research engine. Notitia Civica is the publication surface. The site is
served from this repository by GitHub Pages at https://cls-1000.github.io/notitia-civica/.

## Mission

Notitia Civica focuses on evidence, source trails, structural patterns, and second-order consequences rather than reaction to the news cycle: the signal beneath the drama.

## Core Series

- **World State Brief** — geopolitical reporting and strategic-risk analysis focused on what matters beneath the headline cycle.
- **Narrative Operations** — reporting on influence campaigns, propaganda patterns, astroturfing, source discrediting, manufactured consensus, and information suppression.
- **Civic Intelligence Brief** — public-interest reporting on local and state institutions, public records, budgets, infrastructure, policy movement, and civic accountability.
- **Story Leads** — newsworthy reporting paths generated from public signal clusters.
- **Signal Maps** — structured explainers connecting sources, actors, events, and emerging patterns.
- **Source Register** — public source trails and audit notes for published analysis.

## Method

Notitia Civica outputs are based on public-source collection, signal clustering, source review, confidence language, and human editorial judgment.

Internal scoring weights and source ratings are not published. Analytical judgments are separated from sourced facts wherever possible.

See [`methodology/editorial-standard.md`](methodology/editorial-standard.md) for the full reporting standard, [`methodology/confidence-language.md`](methodology/confidence-language.md) for how signal scores map to public language, and [`methodology/source-handling.md`](methodology/source-handling.md) for source types and citation rules.

## What's published here

- **[Oregon Legislature, Verified — 2025R1](https://cls-1000.github.io/notitia-civica/oregon/2025R1/)** (`oregon/2025R1/`): every measure of the 2025 regular session with its outcome, one card per measure, and the signed evidence chain in `oregon/2025R1/verify/`.
- **Evidence packs** (`evidence/`): signed records behind published findings, such as `evidence/or_veto_pack_2026-10-01/` for the Oregon veto-field report. `evidence/OPERATOR_KEY.md` publishes the signing key. To check a pack with Python 3 and nothing else installed:

  ```bash
  cd evidence/or_veto_pack_2026-10-01
  python3 ../verify.py chain --pubkey <public key from evidence/OPERATOR_KEY.md> --anchor anchor.json
  ```

- **Briefs** (`briefs/`) and **published issues** (`published/`). The automated briefs dated 2026-10-20 to 2026-10-25 were withdrawn on 2026-10-26 because they had not been verified or reviewed; `briefs/spec1_brief_latest.md` says so, and the next brief appears there only after it passes verification and review.

## SPEC-1

SPEC-1 writes the briefs in `briefs/` and the investigation prompts in `spec-1/prompts/`. See [`spec-1/README.md`](spec-1/README.md) for its pipeline.

## Repository

See [`STRUCTURE.md`](STRUCTURE.md) for a complete directory map and an explanation of how templates, briefs, and published output relate to each other.

## Publication Status

Public OSINT. Notitia Civica does not claim private access, classified information, or privileged intelligence.

SPEC-1 supports source monitoring and signal organization. Editorial responsibility remains human.

## Ownership and rights

Notitia Civica is published by EVASTARARCANA LLC, a commercial entity.

© EVASTARARCANA LLC. All rights reserved. This is not open source. Issues and data corrections are welcome; outside pull requests are not accepted.
