# Bibliography

Each entry pairs a **resolvable identifier** (DOI) with an **in-our-words provenance
note** on what the Sail takes from the source, plus an open-access link where one
exists. No copyrighted full text is committed (§0.1); the machine-readable record in
[`references.bib`](references.bib) is the substitute.

**Reviewer leg (§14A.9, FR8).** CI confirms each entry is *present*, carries a
*resolvable* DOI, and that the DOIs resolve at `doi.org`. CI does **not** confirm that a
record *matches* the cited work or that a note is *faithful* — those are signed off in
review. Identifiers below were verified at init (DOI resolves at `doi.org`; title +
authors confirmed via Crossref; arXiv ids confirmed via the arXiv API) — see
[`logbook/2026-06-12-init.md`](logbook/2026-06-12-init.md).

## Verified entries

- **Brownnutt, Kumph, Rabl & Blatt (2015)** — *Ion-trap measurements of electric-field
  noise near surfaces*, Reviews of Modern Physics **87**, 1419.
  - Identifier: https://doi.org/10.1103/RevModPhys.87.1419
  - Open access: arXiv:1409.6572
  - Provenance: the community review of heating-rate and electric-field-noise
    phenomenology that the Sail takes as its point of departure (§1.1) and as the
    catalogue of Gaussian-class sources (§5.1).

- **Holevo (1996)** — *Covariant quantum Markovian evolutions*, Journal of Mathematical
  Physics **37**, 1812.
  - Identifier: https://doi.org/10.1063/1.531481
  - Open access: none
  - Provenance: the structure theorem for translation-covariant quantum dynamical
    semigroups underpinning the Lévy–Khintchine generator decomposition the Sail imports
    as a Tier-1 coastline (Tier Map §2; §3, §5).

- **Vacchini & Hornberger (2009)** — *Quantum linear Boltzmann equation*, Physics
  Reports **478**, 71.
  - Identifier: https://doi.org/10.1016/j.physrep.2009.06.001
  - Open access: arXiv:0904.3911
  - Provenance: the quantum linear Boltzmann equation and translation-covariant
    generator framework the Sail cites for the compound-Poisson jump superoperator and
    its Markov-semigroup imports (Tier Map §2; §5).

## Not entered (and why)

> **Pedernales *et al.* (2015)** is listed in TC-STN-INIT-01 App. G "per programme
> provenance" but is **not cited in this Sail**; asserting it here would be a
> fabrication (§0.1), so it is omitted. The **Lévy–Khintchine decomposition** and
> **macroscopic QED** enter as textbook Coastlines (see [GLOSSARY.md](GLOSSARY.md)
> "Terms used here"), not as discrete bibliography entries. As the Sail's bibliography
> is closed in review, further sources are added here with the same verify-before-assert
> discipline.
