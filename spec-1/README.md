# SPEC-1 — Research Engine Documentation

SPEC-1 is the automated OSINT research engine that powers Notitia Civica.

## Pipeline

SPEC-1 runs a 7-stage pipeline on every cycle:

```
Harvest → Parse → Score → Investigate → Verify → Analyze → Store
```

| Stage | What it does |
|---|---|
| **Harvest** | Collects signals from public sources (official statements, public records, reporting, regulatory filings) |
| **Parse** | Structures raw signals into typed records with source, date, domain, and content fields |
| **Score** | Assigns a numeric confidence score (0.0–1.0) to each signal based on source reliability and corroboration |
| **Investigate** | Generates targeted investigation prompts from high-confidence signals; see `prompts/` |
| **Verify** | Cross-references signals against known records; flags contradictions and gaps |
| **Analyze** | Synthesizes verified signals into brief sections: executive summary, priority developments, watch list |
| **Store** | Appends output records to `briefs/brief_index.jsonl` and writes the dated brief to `briefs/` |

## Output files

| File | Description |
|---|---|
| `briefs/spec1_brief_YYYY-MM-DD.md` | Dated output brief |
| `briefs/spec1_brief_latest.md` | Copy of the most recent brief |
| `briefs/brief_index.jsonl` | Append-only index of all pipeline runs (one JSON object per line) |

## Confidence language

SPEC-1 scores are mapped to public confidence language in `methodology/confidence-language.md`:

| Score | Label |
|---|---|
| 0.80–1.00 | High confidence |
| 0.60–0.79 | Moderate confidence |
| 0.40–0.59 | Directional signal |
| Below 0.40 | Watch item / unconfirmed signal |

## Investigation prompts

When SPEC-1 identifies a high-signal opportunity, it generates a structured investigation prompt for human follow-up. Prompts are saved in `spec-1/prompts/YYYY-MM-DD.md`.

Each prompt includes:
- The originating signal and combined confidence score
- A background memo task
- Specific questions for source contacts
- A FOIA request draft (where applicable)
- A pitch memo for editorial

## Lead cards

Processed leads live in `spec-1/leads/`. A lead card combines:
- The SPEC-1 signal map (sourced, structured, confidence-rated)
- A chain-of-custody record for key evidence
- The PSYCHE-OPS column output (editorial voice, public-facing)
- An intel report (YAML frontmatter, tables, gap registry)

## Pipeline invariants

All database records follow these rules (from `spec-1/SPEC-1_Protocol.pdf`):
- `run_id` on every record — execution lineage
- `created_at` (timestamptz) — immutable
- `source_type` — origin classification
- `schema_version` — migration tracking
- Append-only; nothing is deleted
- `ON CONFLICT DO NOTHING` — idempotent by default

## Editorial boundary

SPEC-1 produces signal analysis and draft structure. **Editorial responsibility remains human.** SPEC-1 does not publish. Every public output is reviewed before release.

See `methodology/editorial-standard.md` and `methodology/source-handling.md` for the full editorial standard.
