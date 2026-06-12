# Bibliography

Each entry pairs a **resolvable identifier** (DOI, or ISBN for books) with an
**in-our-words provenance note** on what the Sail takes from the source, plus an
open-access link where one exists. No copyrighted full text is committed (§0.1); the
machine-readable record in [`references.bib`](references.bib) is the substitute.

**Access key:** 🟢 = open access (arXiv / free host, link given) · 🔒 = paywalled
(fetch the PDF from the publisher for reading; only the derived record lives here).

**Reviewer leg (§14A.9, FR8).** CI confirms each entry is *present*, carries a
*resolvable* identifier, and that DOIs resolve at `doi.org`. CI does **not** confirm that
a record *matches* the cited work or that a note is *faithful* — those are signed off in
review. Every identifier below was verified at init: DOIs resolve at `doi.org`;
titles/authors confirmed via Crossref; arXiv ids via the arXiv API; book ISBNs via
OpenLibrary. See [`logbook/2026-06-12-init.md`](logbook/2026-06-12-init.md).

## Ion-trap motional heating & electric-field noise (T0/§1, §5.1)

- **Brownnutt, Kumph, Rabl & Blatt (2015)** — *Ion-trap measurements of electric-field
  noise near surfaces*, Reviews of Modern Physics **87**, 1419.
  - Identifier: https://doi.org/10.1103/RevModPhys.87.1419
  - Open access: 🟢 arXiv:1409.6572
  - Provenance: the community review of heating-rate and electric-field-noise
    phenomenology that the Sail takes as its point of departure (§1.1) and as the
    catalogue of Gaussian-class sources (§5.1).

- **Turchette, Kielpinski, King, Leibfried *et al.* (2000)** — *Heating of trapped ions
  from the quantum ground state*, Physical Review A **61**, 063418.
  - Identifier: https://doi.org/10.1103/PhysRevA.61.063418
  - Open access: 🟢 arXiv:quant-ph/0002040
  - Provenance: the foundational measurement of anomalous motional heating of a single
    ground-state-cooled ion — the phenomenon whose single-scalar reporting (§1) the
    Decision Engine refines into statistical classes.

- **Deslauriers, Olmschenk, Stick, Hensinger *et al.* (2006)** — *Scaling and suppression
  of anomalous heating in ion traps*, Physical Review Letters **97**, 103007.
  - Identifier: https://doi.org/10.1103/PhysRevLett.97.103007
  - Open access: 🟢 arXiv:quant-ph/0602003
  - Provenance: distance/temperature scaling and suppression of anomalous heating — the
    geometric and Johnson-noise scalings the Sail invokes for the Gaussian class (§5.1)
    and for Pillar-2 physical-model benchmarking (§7).

## Open quantum systems: master-equation structure (T1, §3, §5)

- **Davies (1974)** — *Markovian master equations*, Communications in Mathematical
  Physics **39**, 91.
  - Identifier: https://doi.org/10.1007/BF01608389
  - Open access: 🔒 none (fetch)
  - Provenance: an early derivation of Markovian master equations from system–bath
    coupling — background for the Markov-accessibility gate μ and the generator formalism
    (§3, §4.2, §5).

- **Gorini, Kossakowski & Sudarshan (1976)** — *Completely positive dynamical semigroups
  of N-level systems*, Journal of Mathematical Physics **17**, 821.
  - Identifier: https://doi.org/10.1063/1.522979
  - Open access: 🔒 none (fetch)
  - Provenance: the completely-positive (GKS) generator structure for finite-dimensional
    systems — one half of the GKSL form on which the Sail's master-equation decomposition
    rests (§5).

- **Lindblad (1976)** — *On the generators of quantum dynamical semigroups*,
  Communications in Mathematical Physics **48**, 119.
  - Identifier: https://doi.org/10.1007/BF01608499
  - Open access: 🔒 none (fetch)
  - Provenance: the general-form generator theorem for quantum dynamical semigroups — the
    Markov generator that the Sail's Gaussian-diffusion-plus-jump decomposition
    specialises (§5).

- **Holevo (1996)** — *Covariant quantum Markovian evolutions*, Journal of Mathematical
  Physics **37**, 1812.
  - Identifier: https://doi.org/10.1063/1.531481
  - Open access: 🔒 none (fetch)
  - Provenance: the structure theorem for translation-covariant quantum dynamical
    semigroups underpinning the Lévy–Khintchine generator decomposition the Sail imports
    as a Tier-1 coastline (Tier Map §2; §3, §5).

- **Breuer & Petruccione (2007)** — *The Theory of Open Quantum Systems*, Oxford
  University Press.
  - Identifier: https://doi.org/10.1093/acprof:oso/9780199213900.001.0001
  - Open access: 🔒 none — book (fetch)
  - Provenance: the standard textbook for open-system master equations, the Lindblad
    form, and decoherence — the coastline from which the Sail imports its §3/§5 formalism.

## Collisional decoherence / quantum linear Boltzmann equation (T1, §5.2)

- **Hornberger (2006)** — *Master equation for a quantum particle in a gas*, Physical
  Review Letters **97**, 060601.
  - Identifier: https://doi.org/10.1103/PhysRevLett.97.060601
  - Open access: 🟢 arXiv:quant-ph/0607085
  - Provenance: the compact master equation for a quantum particle's motion in a gas — the
    collisional (compound-Poisson) decoherence model behind the Sail's Class-II jump
    superoperator (§5.2).

- **Vacchini & Hornberger (2009)** — *Quantum linear Boltzmann equation*, Physics Reports
  **478**, 71.
  - Identifier: https://doi.org/10.1016/j.physrep.2009.06.001
  - Open access: 🟢 arXiv:0904.3911
  - Provenance: the quantum linear Boltzmann equation and translation-covariant generator
    framework the Sail cites for the compound-Poisson jump superoperator and its
    Markov-semigroup imports (Tier Map §2; §5).

## Lévy processes, anomalous diffusion & heavy-tail inference (T1, §1.3, §5.3, §7)

- **Sato (1999)** — *Lévy Processes and Infinitely Divisible Distributions*, Cambridge
  Studies in Advanced Mathematics, Cambridge University Press.
  - Identifier: ISBN 9780521553025 (rev. ed. 2013, ISBN 9781107656499)
  - Open access: 🔒 none — book (fetch)
  - Provenance: the canonical monograph on Lévy processes and the Lévy–Khintchine
    decomposition of infinitely divisible distributions — the probabilistic backbone of
    the Sail's three-class hypothesis (§1.3, §5).

- **Metzler & Klafter (2000)** — *The random walk's guide to anomalous diffusion: a
  fractional dynamics approach*, Physics Reports **339**, 1.
  - Identifier: DOI 10.1016/S0370-1573(00)00070-3 — resolves at
    https://doi.org/10.1016/S0370-1573%2800%2900070-3
  - Open access: 🔒 none (fetch)
  - Provenance: the physics review of anomalous diffusion, heavy-tailed jump
    distributions and Lévy flights — context for the Sail's Class-III heavy-tailed
    processes and the ⟨Δx²⟩ ∝ t^{2/α} signature (§5.3).

- **Clauset, Shalizi & Newman (2009)** — *Power-law distributions in empirical data*,
  SIAM Review **51**, 661.
  - Identifier: https://doi.org/10.1137/070710111
  - Open access: 🟢 arXiv:0706.1062
  - Provenance: the standard methodology for fitting and testing power-law tails
    (maximum-likelihood plus goodness-of-fit) — the inference recipe behind the Sail's
    tail-exponent estimation and feasibility gate (§5.3, §7.4).

- **Hill (1975)** — *A simple general approach to inference about the tail of a
  distribution*, The Annals of Statistics **3**, 1163.
  - Identifier: https://doi.org/10.1214/aos/1176343247
  - Open access: 🟢 free at Project Euclid
  - Provenance: the Hill estimator for the tail index of a heavy-tailed distribution —
    named explicitly in the Sail's Class-III inference (§5.3; Decision Engine node 9).

## Not entered (and why)

> **Pedernales *et al.* (2015)** is listed in TC-STN-INIT-01 App. G "per programme
> provenance" but is **not cited in this Sail**; asserting it here would be a fabrication
> (§0.1), so it is omitted. As the bibliography is closed in review, further sources are
> added with the same verify-before-assert discipline (DOI resolves / ISBN confirmed
> before entry).
