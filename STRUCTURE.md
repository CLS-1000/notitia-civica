# Repository Structure

This file maps the Notitia Civica repository layout — what each directory holds and how the pieces relate.

```
notitia-civica/
│
├── README.md               — Publication overview, mission, core series
├── STRUCTURE.md            — This file
│
├── briefs/                 — SPEC-1 generated output briefs (markdown)
│   ├── spec1_brief_YYYY-MM-DD.md   — Daily/run briefs by date
│   ├── spec1_brief_latest.md       — Copy of the most recent brief
│   ├── brief_index.jsonl           — Machine-readable index of all brief runs
│   └── NOTITIA_CIVICA_INAUGURAL_ISSUE_001.md
│
├── explainers/             — Long-form pattern explainers (public-facing)
│   └── 01-narrative-seeding.md
│
├── methodology/            — Editorial standards and internal rules
│   ├── confidence-language.md      — Numeric score → public language mapping
│   ├── editorial-standard.md       — Core reporting standard
│   └── source-handling.md          — Source types and citation rules
│
├── notitia/                — Web design system
│   ├── notitia.css         — Shared CSS tokens and base styles (import this)
│   └── README.md           — Design token documentation
│
├── owc/                    — Ongoing work cache (gitignored; local only)
│   (intentionally not tracked; see .gitignore)
│
├── published/              — Final published PDFs
│   ├── PSYCHE-INT_Issue-001.pdf
│   ├── World-State-Brief_2026-04-28.pdf
│   ├── World-State-Brief_Issue7_2026-04-29.pdf
│   └── Notitia-Civica_Publication-Template.pdf
│
├── research/               — Source research materials and threat profiles
│   ├── Hwasong-11A_Threat_Profile.pdf
│   ├── Hwasong-11A_Threat_Profile_v2.pdf
│   ├── PSYCHE-OPS_Iran-China-Strategic-Realignment.pdf
│   └── PSYCHE-OPS_Iran-China-Mechanisms.pdf
│
├── spec-1/                 — SPEC-1 engine documentation and artifacts
│   ├── README.md           — Pipeline documentation
│   ├── SPEC-1_Protocol.pdf — Full protocol document
│   ├── landing-page.html   — SPEC-1 standalone landing page
│   ├── leads/              — Processed lead cards and signal maps
│   │   ├── lead-01-signal-map-psyche-ops.md
│   │   └── lead-01-chain-of-custody-debris-analysis.md
│   └── prompts/            — SPEC-1 investigation prompts by date
│       └── 2026-04-25.md
│
└── templates/              — Reusable output templates
    ├── brief.md                    — Civic intelligence brief (markdown)
    ├── narrative-operations.md     — Narrative Operations column (markdown)
    ├── signal-map.md               — Signal Maps column (markdown)
    ├── source-register.md          — Source register (markdown)
    ├── story-lead.md               — Story Leads column (markdown)
    ├── world-state-brief.md        — World State Brief column (markdown)
    ├── print/                      — Print-first HTML templates (Letter/A4)
    │   ├── _base.html              — Parameterized base; edit this to update all three
    │   ├── build.sh                — Regenerates all three series templates from _base.html
    │   ├── civic-intelligence-brief.html
    │   ├── narrative-operations.html
    │   ├── notitia-civica-template.html   — Standalone print template (legacy)
    │   ├── pdf-template.html              — PDF print layout (Letter/A4)
    │   └── world-state-brief.html
    └── web/                        — Web/CSS design system templates
        ├── article.html            — Long-form brief with React tweaker
        ├── congressional-intelligence-one-pager.html
        ├── issue-cover.html        — Full-bleed issue cover
        └── methodology.html        — How We Work page
```

## How templates relate to published output

1. **SPEC-1** runs the pipeline → writes a dated brief to `briefs/` and updates `spec1_brief_latest.md`
2. **Editorial review** applies the relevant `templates/*.md` structure to draft final copy
3. **Print output** uses `templates/print/*.html` rendered to PDF → saved to `published/`
4. **Web output** uses `templates/web/*.html` with the shared `notitia/notitia.css` design system

## Design system

All `templates/web/` templates import `../../notitia/notitia.css`. See `notitia/README.md` for token documentation.

## Print template maintenance

`templates/print/_base.html` is the single source of truth for all three series print templates. Run `bash templates/print/build.sh` after editing `_base.html` to regenerate the three output files.
