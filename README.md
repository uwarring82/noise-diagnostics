---
fair-profile: full
entry-surface: README.md
---

# The Statistical Turn in Trapped-Ion Noise Diagnostics

This repository develops a method for telling apart the different kinds of electrical
noise that disturb a single trapped ion's motion. Most laboratories report that
disturbance as one number — a heating rate — which hides the difference between many
small pushes and a few violent kicks, even though the two demand opposite fixes. The
method here sorts the noise into three statistical families and gives a step-by-step
procedure for deciding which family you are looking at, how many measurements it takes,
and how to check the answer.

**FAIR profile: full** · **entry surface:** `README.md`

Within the [Open-Science Harbour](GLOSSARY.md#harbour), this work is a
[Sail](GLOSSARY.md#sail) — an operational synthesis that imports established physics
from external [Coastlines](GLOSSARY.md#coastline) without restating it.

---

> **Sail · Tier 2 · Harbour Architecture Compliance Notice.** Authority flows from use,
> not endorsement. The frameworks referenced are imports under local stewardship;
> Standard-Model electrodynamics and quantum mechanics are external Coastlines.

## What this repository contains
- **[Live site →](https://uwarring82.github.io/noise-diagnostics/)** — this work rendered as a website (essay, glossary, bibliography).
- [`essays/`](essays/) — the Sail (the full framework).
- [`GLOSSARY.md`](GLOSSARY.md), [`CITATION.cff`](CITATION.cff), [`logbook/`](logbook/) — FAIR minimal floor.
- [`BIBLIOGRAPHY.md`](BIBLIOGRAPHY.md), [`references.bib`](references.bib), [`OUTREACH.md`](OUTREACH.md) — FAIR full profile.
- [`tools/fair_check.sh`](tools/fair_check.sh) — the §14A reference checker (run it from the repo root).

## Provenance
Built against blueprint **CD 1.8.2** (`cd-rules`@`a61ad52`, tag `cd-1.8.2`); design assets
and the FAIR checker copied via Model B — see [`assets/SOURCE.md`](assets/SOURCE.md) and
[`tools/SOURCE.md`](tools/SOURCE.md). Licensing is split by folder — see [`LICENCE`](LICENCE).
