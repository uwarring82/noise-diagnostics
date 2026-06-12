---
layout: default
title: "The Statistical Turn in Trapped-Ion Noise Diagnostics"
description: "From Heating Rates to a Decision Engine"
---

<!--
SPDX-License-Identifier: CC-BY-NC-SA-4.0
SPDX-FileCopyrightText: 2026 U. Warring
Authored Sail under T(h)reehouse +EC stewardship. Verbatim source of truth:
github.com/uwarring82/ions-in-freiburg @ 41059f9
  (essays/the-statistical-turn-in-trapped-ion-noise-diagnostics.md, 2026-02-20).
Verified sources: BIBLIOGRAPHY.md. Folder/layer licences: root LICENCE.
-->

# The Statistical Turn in Trapped-Ion Noise Diagnostics

***

<div class="callout callout-info" markdown="1">
**Stewardship:** U. Warring\
**Status:** Draft · February 2026
</div>

***

### Endorsement Marker v2.0

> **Harbour Architecture Compliance Notice**
>
> This document is a **Sail** (essay + handbook-facing protocol narrative) within the Open-Science Harbour. It is classified **Tier 2**: an operational synthesis that imports physics from Tier 1 coastlines and boundary conditions from Tier 0, but does not itself constitute a fundamental law or a novel theoretical result.
>
> _Authority flows from use, not endorsement._ The frameworks referenced herein—macroscopic QED, the Lévy–Khintchine decomposition, translation-covariant quantum Markov semigroups—are Tier 1 imports under local stewardship. Standard-Model electrodynamics and quantum mechanics are external coastlines referenced as constraints. No claim in this Sail exceeds the validity domain stated in §9.
>
> _Lock-Key separation applies._ The conceptual locks (three operational classes, two-scalar classifier, validation architecture) remain stable; interpretive keys (specific scattering models, mitigation strategies, shot-count estimates) remain free and revisable.
>
> _Distribution scales, not authority._

***

### Abstract

Motional decoherence in trapped-ion systems is conventionally characterised by a single scalar—the heating rate $$\dot{\bar{n}}$$. This reporting convention discards statistical information that distinguishes fundamentally different noise mechanisms requiring different mitigation strategies. We present a Tier-2 operational framework—the Decision Engine—that classifies electromagnetically coupled noise into three operational classes (Gaussian diffusion, compound-Poisson jumps, Lévy-type heavy-tailed processes) within the validity domain of harmonic confinement, Markovian bath dynamics, and stationary statistics. Classification proceeds via two dimensionless scalars: the event-count parameter $$\lambda\tau$$ and the Markov-accessibility parameter $$\mu = \tau/\tau_c$$. We provide a numbered decision protocol with explicit gate nodes, shot-count estimates, and a three-pillar validation architecture incorporating mandatory consistency closure. All claims are bounded to single-ion motional decoherence under linear electromagnetic coupling; extensions beyond this domain are flagged as out-of-scope branch conditions.

***

### 1. Introduction — The Statistical Turn

#### 1.1 Anomalous heating as bottleneck

The scalability of trapped-ion quantum information processing remains constrained by motional decoherence—the uncontrolled degradation of the harmonic oscillator's quantum state through interaction with electromagnetic environments. For over three decades, the community has characterised this process through a single figure of merit: the mean heating rate $$\dot{\bar{n}}$$, typically extracted from sideband thermometry after variable delay times. Comprehensive reviews have catalogued the dependence of $$\dot{\bar{n}}$$ on frequency, ion–surface distance, and temperature, seeking correlations with surface-science models of patch potentials, adatom fluctuators, and electrode contamination (Brownnutt et al., 2015).

#### 1.2 Why heating-rate-only reporting is epistemically lossy

The reduction of complex environmental dynamics to a single scalar discards the vast majority of statistical information carried by the noise signal. Two physically distinct noise processes—one consisting of many weak, continuous fluctuations, the other of rare but violent momentum kicks—can produce identical values of $$\dot{\bar{n}}$$ whilst requiring orthogonal mitigation strategies. The heating rate is a second-moment quantity; it is blind to skewness, kurtosis, waiting-time structure, and tail behaviour. Under the implicit assumption of Gaussian statistics, the power spectral density $$S_E(\omega)$$ is a sufficient statistic. When that assumption fails—as it must for discrete collision events, charging transients, or heavy-tailed excursions—the spectral approach systematically misdiagnoses the environment.

#### 1.3 Statistical Universality Hypothesis (bounded)

Within the validity domain of single-ion harmonic confinement, linear electromagnetic coupling, Markovian bath dynamics, and stationary noise statistics (§9), we advance the following bounded hypothesis: all electromagnetically coupled noise sources acting on a trapped ion's motional degree of freedom fall into one of three operational classes, distinguished by the statistical character of the environmental current sources $$\mathbf{J}(\mathbf{r}, t)$$ that drive the fields. These classes—Gaussian (diffusive), compound-Poisson (jump-dominated), and Lévy-type (heavy-tailed)—arise from the Lévy–Khintchine decomposition of infinitely divisible processes and are exhaustive within the stated domain. The classification is operational: it determines which observables are informative and which measurement strategies are optimal, independently of the microscopic identity of the source.

This hypothesis does _not_ claim universality across all quantum systems, all coupling mechanisms, or all decoherence channels. It is restricted to motional decoherence of a single trapped ion under electromagnetic coupling within the Markov-accessible zone defined below.

#### 1.4 Deliverable: Decision Engine and validation separation

The primary deliverable of this Sail is the **Decision Engine** (§7)—a procedural protocol that converts abstract statistical classification into a linear sequence of experimental decisions. The secondary deliverable is the **Validation Architecture** (§8), which enforces rigorous separation between inference validity (did we identify the correct statistical class?) and physical predictability (does the identified class match the microscopic model?), joined by a mandatory consistency closure test.

***

### 2. Tier Map and Reader Contract

#### Tier Map

| Tier                         | Content                                                                                                                                                                                                      | Role in this Sail                                                                                  | Stewardship                                                                                         |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| **T0 — Boundary Conditions** | Harmonic confinement; linear coupling $$H_\text{int} = -qxE_x$$; Markovian bath ($$\mu \gg 1$$); stationarity; single-ion restriction                                                                          | Define the validity domain. When any T0 condition fails, the Decision Engine degrades (see below). | External constraints; not revisable within this Sail.                                               |
| **T1 — Physics Imports**     | Macroscopic QED / Green tensor $$\mathbf{G}(\mathbf{r}_0, \mathbf{r}; \omega)$$; Lévy–Khintchine decomposition; translation-covariant Markov semigroups (Holevo, Vacchini); quantum linear Boltzmann equation | Provide the theoretical foundation. Imported, not derived here.                                    | Coastlines under broad endorsement (QED) or local stewardship (Holevo–Vacchini structure theorems). |
| **T2 — Decision Engine**     | Two-scalar classifier ($$\lambda\tau$$, $$\mu$$); three operational classes; decision protocol; validation architecture; shot-count estimates                                                                    | The operational synthesis—this Sail's contribution.                                                | Local stewardship; revisable as experiments refine estimates.                                       |

#### Degradation Protocol

When a Tier-0 boundary condition fails, the Decision Engine does not produce undefined output; it degrades gracefully:

| T0 Failure                          | Trigger                                                                              | Engine Response                                                                                                                                                                                                    |
| ----------------------------------- | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Markov breakdown ($$\mu \lesssim 1$$) | Bath correlation time $$\tau_c$$ comparable to or exceeding interrogation time $$\tau$$ | Downgrade to **screening heuristic** only. Flag output as "Markov-inaccessible; classification provisional." Open **non-Markov branch**: recommend memory-kernel analysis or fractional-Brownian-motion extension. |
| Anharmonic confinement              | $$\lvert\beta\rvert x_0 \gtrsim m\omega_t^2$$ or large motional excitation           | Downgrade dephasing predictions; heating classification may remain valid if coupling remains approximately linear. Flag enhanced dephasing channel.                                                                |
| Non-stationarity detected           | Drift in calibration interleaves exceeds tolerance                                   | Suspend classification. Require drift subtraction and re-entry.                                                                                                                                                    |
| Multi-ion correlation               | More than one ion in shared potential                                                | Engine scope exceeded. Flag as "multi-mode extension required."                                                                                                                                                    |

#### Reader Contract

> **To the reader.** This document is a Tier-2 operational guide. It synthesises established physics (Tier 1) into a practical classification protocol, bounded by explicit assumptions (Tier 0). It does _not_ introduce new fundamental physics, claim exhaustive coverage beyond the stated domain, or guarantee that the Decision Engine will correctly classify noise under conditions violating the boundary conditions listed above.
>
> When the Engine says "Gaussian," it means: _within the Markov-accessible zone, under harmonic confinement, with stationary statistics, the data are consistent with the Gaussian operational class at the stated confidence level._ The Engine's output is a provisional classification subject to the three-pillar validation of §8.
>
> The Decision Engine is a tool for structuring experimental enquiry, not a substitute for physical judgement. Proceed accordingly.

***

### 3. Universal Mediation Principle (T1 Import)

The interaction between a trapped ion at equilibrium position $$\mathbf{r}_0$$ and its electromagnetic environment is governed by


$$
H_\text{int} = -qx , E_x(\mathbf{r}_0, t),
$$


where $$E_x$$ is the $$x$$-component of the electric field. The field is not an independent degree of freedom; it is generated by stochastic current densities $$\mathbf{J}(\mathbf{r}, t)$$ distributed throughout the environment—electrodes, dielectrics, vacuum chamber walls, background gas—and mediated by the electromagnetic Green tensor:


$$
E_x(\mathbf{r}_0, \omega) = i\mu_0 \omega \int \mathrm{d}^3 r ; G_{x\alpha}(\mathbf{r}_0, \mathbf{r}; \omega) , J_\alpha(\mathbf{r}, \omega).
$$


The force spectrum entering the master equation is


$$
S_F(\omega) = q^2 \int \mathrm{d}^3 r , \mathrm{d}^3 r' ; G_{x\alpha}(\mathbf{r}_0, \mathbf{r}; \omega) , S_{JJ}^{\alpha\beta}(\mathbf{r}, \mathbf{r}'; \omega) , G_{x\beta}^*(\mathbf{r}_0, \mathbf{r}'; \omega).
$$


This factorisation is the Universal Mediation Principle (within the linear-coupling domain): the problem separates into a **deterministic filter** ($$\mathbf{G}$$, encoding trap geometry and material response) and a **stochastic driver** ($$\mathbf{J}$$, encoding the temporal dynamics of the source). The geometry does not change the statistical class of the noise—only its magnitude and spectral colour. A Gaussian source produces Gaussian fields at the ion; a Poissonian source produces Poissonian fields. Linear response preserves the character of the distribution.

#### What changes / what doesn't

| Aspect                                        | Determined by                                         | Changed by trap geometry?                        |
| --------------------------------------------- | ----------------------------------------------------- | ------------------------------------------------ |
| Statistical class (Gaussian / Poisson / Lévy) | Source current statistics $$\mathbf{J}(\mathbf{r}, t)$$ | No (within linear coupling)                      |
| Spectral shape of $$S_F(\omega)$$              | Both $$\mathbf{G}$$ and $$S_{JJ}$$                       | Yes — $$\mathbf{G}$$ filters spectral content      |
| Overall noise magnitude                       | Both $$\mathbf{G}$$ and $$S_{JJ}$$                       | Yes — geometric coupling efficiency              |
| Heating/dephasing balance                     | Spectral weight near $$\omega_t$$ vs. near $$0$$         | Yes — $$\mathbf{G}$$ redistributes spectral weight |
| Directional anisotropy                        | Spatial structure of $$\mathbf{G}$$                     | Yes — extended trajectories break isotropy       |

**Implication for diagnostics.** The trap can be treated as a known filter. Diagnostic effort focuses on analysing the _output_ statistics of the ion's motional state to infer the _input_ statistics of the environment.

***

### 4. Regime Classifier

Classification proceeds via two dimensionless scalars that gate all subsequent analysis.

#### 4.1 The event-count parameter $$\lambda\tau$$


$$
\lambda\tau = \text{(characteristic event rate)} \times \text{(interrogation time per shot)}.
$$


For impulsive processes, $$\lambda$$ is the Poisson arrival rate. For continuous fields, $$\lambda^{-1}$$ represents an effective correlation time, so $$\lambda\tau \sim \tau/\tau_c$$ counts independent fluctuation intervals. The parameter organises _temporal statistics_:

* $$\lambda\tau \gg 1$$ **(diffusive regime):** Many events per shot. Central Limit Theorem applies. Statistics appear Gaussian regardless of single-event character.
* $$\lambda\tau \sim 1$$ **(intermediate regime):** Zero to a few events per shot. Non-Gaussian cumulants become measurable. This is typically the most diagnostic regime.
* $$\lambda\tau \ll 1$$ **(sparse regime):** Most shots show no event. Rare shots show large jumps. Waiting-time distributions become the primary observable.

**Crucially, $$\lambda\tau$$ characterises event statistics, not spectral content.** A Gaussian source with $$1/f$$ spectrum ($$\lambda\tau \gg 1$$) can produce strong dephasing but weak heating; a Poisson collision process ($$\lambda\tau \ll 1$$) with large momentum transfer produces primarily heating. The framework treats both aspects independently.

#### 4.2 The Markov-accessibility parameter $$\mu$$


$$
\mu = \frac{\tau}{\tau_c},
$$


where $$\tau_c$$ is the bath correlation time—the timescale over which environmental correlations decay. The parameter gates the _validity of the Markov approximation_:

* $$\mu \gg 1$$ **(Markov-accessible zone):** The interrogation time spans many bath correlation times. The memoryless approximation holds. The Lévy–Khintchine generator is valid. **The Decision Engine operates normally.**
* $$\mu \lesssim 1$$ **(Markov-inaccessible zone):** Environmental memory persists across the measurement window. The generator formalism breaks down. **The Decision Engine degrades to a screening heuristic.** Non-Markov branches (memory-kernel methods, fractional Brownian motion) must be pursued separately.

#### 4.3 Joint gating logic

Both scalars must be evaluated before classification proceeds. The $$\mu$$ gate is applied _first_: if $$\mu \lesssim 1$$, the Engine halts normal classification and flags the output as provisional. Only when $$\mu \gg 1$$ does $$\lambda\tau$$ determine which observables to prioritise.

**Failure mode.** If only $$\lambda\tau$$ is evaluated without $$\mu$$, a source with slow environmental memory ($$\tau_c \sim \tau$$) could be misclassified as sparse-Poisson ($$\lambda\tau \ll 1$$) when it is in fact non-Markovian. The $$\mu$$ gate prevents this diagnostic error.

***

### 5. Three Operational Classes (Bounded)

Within the Markov-accessible zone ($$\mu \gg 1$$), under harmonic confinement and stationary statistics, all electromagnetically coupled noise falls into three operational classes distinguished by the Lévy–Khintchine decomposition of the master-equation generator:


$$
\dot{\rho} = -i[H_0, \rho] + \mathcal{D}_G[\rho] + \mathcal{J}_P[\rho],
$$


where $$\mathcal{D}_G$$ is the Gaussian diffusion superoperator and $$\mathcal{J}_P$$ is the compound-Poisson jump superoperator. Heavy-tailed Lévy processes extend $$\mathcal{J}_P$$ to divergent-variance jump-size distributions.

#### 5.1 Gaussian (Diffusive) — $$\lambda\tau \gg 1$$

**Physical picture.** Many weak, independent fluctuations aggregate via the Central Limit Theorem. Sources include Johnson–Nyquist noise in electrodes, control-field pickup, dense patch-potential fluctuations, and high-flux photon scattering.

**Signature → Measurement → Inference → Mitigation lever**

| Element                                          | Detail                                                                                                                                                                                                                                                                    |
| ------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Signature**                                    | Linear heating $$\bar{n}(t) = \bar{n}_0 + \dot{\bar{n}},t$$; thermal phonon distribution $$P(n) \propto \bar{n}^n/(\bar{n}+1)^{n+1}$$; vanishing higher-order cumulants $$\kappa_3 \approx 0$$, $$\kappa_4 \approx 0$$; Allan variance $$\sigma_A^2(\tau) \propto \tau^{-1}$$. |
| **Measurement**                                  | Power spectral density $$S_E(\omega)$$ via sideband heating-rate scans at multiple frequencies; sideband asymmetry mapping; Ramsey coherence decay envelopes.                                                                                                              |
| **Inference**                                    | $$\dot{\bar{n}} \approx q^2 S_E(\omega_t)/(4m\hbar\omega_t)$$. Spectral shape (white, $$1/f^\alpha$$, Lorentzian) identifies source class. Dephasing separately from low-frequency $$S_{\delta\omega}(\Omega)$$.                                                           |
| **Mitigation lever** _(handbook-level strategy)_ | Reduce source amplitude (lower temperature, lower electrode resistance); spectral filtering (dynamical decoupling for dephasing); geometric optimisation (increase ion–surface distance to exploit $$\mathbf{G}$$ scaling).                                                 |

**Domain note.** The PSD is a sufficient statistic _only_ within this class. Applying spectral methods to non-Gaussian noise produces systematically biased estimates.

#### 5.2 Compound-Poisson (Jump-Dominated) — $$\lambda\tau \sim 1$$ to $$\ll 1$$

**Physical picture.** Discrete, independent events deliver momentum kicks $$\Delta p$$ drawn from a distribution $$\nu(\Delta p)$$ with finite variance. Each kick implements the unitary displacement $$U_{\Delta p} = \exp[-i\Delta p , x/\hbar]$$, simultaneously changing the ion's energy and phase. Sources include background-gas collisions (Langevin, hard-sphere, resonant charge exchange), single-photon recoil at low flux, and bistable fluctuators (telegraph noise).

**Signature → Measurement → Inference → Mitigation lever**

| Element                                          | Detail                                                                                                                                                                                                                                                                                                                                                                                                      |
| ------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Signature**                                    | Non-zero skewness $$\kappa_3/\kappa_2^{3/2} \sim 0.3\text{–}1$$; excess kurtosis; non-thermal $$P(n)$$ (displaced/coherent-state character after single kicks); exponential waiting-time distribution $$p(\Delta t) = \lambda e^{-\lambda \Delta t}$$; Allan variance rollover near $$\tau \sim 1/\lambda$$; correlated energy and phase fluctuations.                                                            |
| **Measurement**                                  | Higher-order cumulants from $$\sim 10^4$$ stroboscopic shots; waiting-time histograms from time-stamped single-shot readout ($$\sim 10^3$$ events); jump-size distribution $$P(\Delta n)$$ from $$\sim 10^5$$ shots; Allan variance over extended traces (hours).                                                                                                                                                   |
| **Inference**                                    | Event rate $$\lambda$$ from waiting-time exponential fit or Allan-variance rollover. Jump-size distribution $$\nu(\Delta n)$$ mapped to scattering cross-section $$\mathrm{d}\sigma/\mathrm{d}\Omega$$ via phonon transition matrix elements $$P_{n \to n'}(\Delta p)$$. Species identification from $$\nu(\Delta p)$$ shape: forward-peaked (Langevin), isotropic (hard-sphere), state-dependent (charge exchange). |
| **Mitigation lever** _(handbook-level strategy)_ | Reduce event rate (improve vacuum, eliminate charging sources); time-domain filtering (erasure conversion—detect kick, discard corrupted shot); increase gate speed to operate between kicks ($$\tau_\text{gate} \ll 1/\lambda$$).                                                                                                                                                                           |

**Domain note.** The compound-Poisson class requires finite variance of $$\nu(\Delta p)$$. When variance diverges, the process enters the Lévy-type class.

#### 5.3 Lévy-Type (Heavy-Tailed) — Power-Law $$\nu(\Delta p)$$

**Physical picture.** Jump-size distributions with power-law tails $$\nu(\Delta p) \propto \lvert\Delta p\rvert^{-1-\alpha}$$ for $$0 < \alpha < 2$$ produce divergent variance and anomalous diffusion $$\langle(\Delta x)^2\rangle \propto t^{2/\alpha}$$. Candidate mechanisms include Coulomb scattering on charged dust grains (long-range $$1/r^2$$ potential), micro-discharge events, cosmic-ray impacts, and possibly self-organised-critical surface-patch avalanches.

**Signature → Measurement → Inference → Mitigation lever**

| Element                                          | Detail                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
| ------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Signature**                                    | Power-law tails $$P(\Delta n) \propto \lvert\Delta n\rvert^{-1-\alpha}$$ ($$0 < \alpha < 2$$); divergent variance; anomalous diffusion $$\langle(\Delta x)^2\rangle \propto t^{2/\alpha}$$; rare extreme excursions dominate single-shot histograms; CCDF linear on log–log axes. |
| **Measurement**                                  | Large-$$N$$ single-shot datasets ($$\sim 10^5\text{–}10^6$$ shots); complementary cumulative distribution function (CCDF) on log–log scale; tail-exponent estimation (Hill estimator or maximum-likelihood stable-law fit); i.i.d. vs. clustered test (autocorrelation of extreme events).                                                                                                                                                                                                                     |
| **Inference**                                    | Stability parameter $$\alpha$$ from tail fit. **Feasibility gate applies** (see §7 and §8.4): tail-exponent inference requires $$N_\text{ev} \gtrsim 10^3\text{–}10^4$$ events in the tail, implying acquisition time $$T_\text{acq} \sim N_\text{ev}/(\lambda d)$$ where $$d$$ is the tail-exceedance fraction. Beyond the stability horizon ($$T_\text{acq}$$ exceeds practical drift-free measurement windows), downgrade to **detection-only**: report "heavy tails detected" without quantitative $$\alpha$$. |
| **Mitigation lever** _(handbook-level strategy)_ | Averaging is counterproductive (rare catastrophic events contaminate the mean). Use robust statistics (median, trimmed mean); threshold-based rejection of extreme excursions; erasure-conversion protocols in quantum error correction; reduce defect density (a single Lévy-type defect can dominate even in otherwise clean systems).                                                                                                                                                                   |

**Critical distinction:** Lévy-type heavy tails do _not_ automatically imply long memory. A Lévy process can be i.i.d. (memoryless jumps with heavy-tailed sizes) or clustered (correlated inter-event times). The i.i.d. vs. clustered distinction must be tested explicitly via autocorrelation of exceedances. Clustering would indicate a non-Markov component and trigger the $$\mu$$-gate degradation.

***

### 6. Decision Engine

The following numbered protocol constitutes the Decision Engine. Each node references a measurable quantity and an order-of-magnitude shot count. Gate nodes are marked with ⊳.

> **Pre-requisite.** Calibrate the stroboscopic measurement chain: ground-state preparation fidelity, readout fidelity, and baseline technical noise floor. Establish interleaved calibration shots for drift monitoring.

```
DECISION ENGINE v1.0
════════════════════

⊳ 1.  STATIONARITY CHECK
      Run interleaved calibration over full acquisition window.
      If drift > tolerance → HALT. Subtract drift or shorten window. Re-enter.

⊳ 2.  ESTIMATE μ = τ / τ_c
      Measure bath correlation time τ_c (autocorrelation decay of noise proxy).
      If μ ≲ 1 → DEGRADE to screening heuristic. Open non-Markov branch. EXIT.
      If μ ≫ 1 → PROCEED (Markov-accessible zone confirmed).

⊳ 3.  ESTIMATE λτ
      From prior knowledge (pressure gauge, technical-noise bandwidth) or
      preliminary Allan-variance scan, estimate event-count parameter.

  4.  ACQUIRE STROBOSCOPIC DATA
      N ≥ 10⁴ shots at chosen τ. Record time-stamped single-shot outcomes {nᵢ}.

  5.  COMPUTE CUMULANTS
      Extract ⟨n⟩, σ², κ₃, κ₄ from histogram P(n|τ).

  6.  TEST: κ₃/κ₂^{3/2} ≈ 0  AND  κ₄/κ₂² ≈ 0  (within statistical uncertainty)?
      YES → provisional CLASS I (Gaussian). Go to 10.
      NO  → non-Gaussian component detected. Go to 7.

  7.  CONSTRUCT WAITING-TIME DISTRIBUTION (if time-stamped data available).
      Threshold: |nᵢ₊₁ − nᵢ| > δ.  Fit p(Δt).

  8.  TEST: p(Δt) exponential?
      YES → provisional CLASS II (compound-Poisson). Go to 10.
      NO (power-law or stretched-exponential)  → Go to 9.

  9.  TAIL ANALYSIS on P(Δn).
      Plot CCDF on log–log scale.
      ⊳ FEASIBILITY GATE: Can N_ev / (λd) be achieved within drift-free window?
        NO  → DETECTION-ONLY: report "heavy tails detected; α not reliably
               estimable." EXIT.
        YES → Fit α via Hill estimator or MLE.  Provisional CLASS III (Lévy-type).
               Test i.i.d. vs. clustered (autocorrelation of exceedances).
               If clustered → flag non-Markov contribution; re-check μ gate.

 10.  VALIDATE via three-pillar architecture (§8).
      Pillar 1: confusion matrix at achieved N.
      Pillar 2: physical-model benchmark (G-tensor scaling, pressure dependence).
      Pillar 3: consistency closure (σ_tot test).
      If any pillar fails → revise classification or acquire more data.

 11.  REPORT: statistical class, confidence level, λ, τ, μ,
      cumulants, and full P(n|τ). State all T0 conditions verified.
```

**Shot-count reference** (order-of-magnitude):

| Target                                   | Required scale              |
| ---------------------------------------- | --------------------------- |
| Detect $$\kappa_3 \neq 0$$ at $$3\sigma$$   | $$\sim 10^4$$ shots           |
| Reconstruct $$\nu(\Delta n)$$ (5 bins)     | $$\sim 10^5$$ shots           |
| Test heavy-tail exponent $$\alpha$$        | $$\sim 10^6$$ events          |
| Allan-variance rollover near $$1/\lambda$$ | Hours of continuous trace   |
| Sideband asymmetry frequency map         | $$\sim 10^2$$ frequency scans |

***

### 7. Validation Architecture

#### Pillar 1 — Classification Power (Inference Validity)

**Question:** Given finite data, can we reliably distinguish the three classes?

**Method:** Monte Carlo confusion matrix. Generate synthetic datasets for each class (Gaussian, compound-Poisson, Lévy-type) with parameters matching the experimental regime (including realistic readout fidelity, drift contamination, and finite $$N$$). Feed synthetic data through the Decision Engine. Compute $$C_{ij} = P(\text{predicted class } i \mid \text{true class } j)$$.

**Requirement:** Diagonal elements $$C_{ii} > 0.90$$ at the achieved shot count $$N$$. If off-diagonal confusion is high (e.g., Lévy frequently misclassified as Poisson), the data volume is insufficient. Action: acquire more shots or accept reduced classification confidence with explicit error bars.

**Minimum shot counts** for $$>90%$$ diagonal (indicative):

* Gaussian vs. Poisson: $$N \sim 10^3\text{–}10^4$$
* Poisson vs. Lévy tail: $$N \sim 10^5\text{–}10^6$$ (tail events)

**Recommended tests:** Anderson–Darling (sensitive to tail deviations) over Kolmogorov–Smirnov.

#### Pillar 2 — Physical Predictability (Model Correctness)

**Question:** Does the identified statistical class align with the physics predicted by the Green tensor and known source models?

**Method:** Compare inferred parameters against independent physical predictions:

* If Class I (Gaussian) identified: heating rate should exhibit predicted geometric scaling ($$d^{-4}$$ for patch potentials, $$d^{-2}$$ for Johnson noise). Temperature dependence should match ($$\dot{\bar{n}} \propto T$$ for Johnson).
* If Class II (Poisson) identified: event rate $$\lambda$$ should scale linearly with background pressure (for gas collisions) or laser intensity (for photon scattering). Pressure-independence falsifies the gas-collision assignment.
* If Class III (Lévy-type) identified: candidate mechanism must physically support power-law momentum transfer (Coulomb scattering, not Langevin).

**Cross-validation protocol:** Deliberately perturb one physical parameter (e.g., worsen vacuum pressure by $$10\times$$) and verify that the Engine's inferred $$\lambda$$ responds as predicted. If it does not, the physical assignment is wrong even if the statistical classification is correct.

**Green tensor benchmarking:** Compare numerically computed $$\mathbf{G}$$ against measured heating-rate geometric scalings. Discrepancies indicate geometry-modelling errors that propagate into all quantitative predictions.

#### Pillar 3 — Consistency Closure (Mandatory)

**Question:** Do Pillars 1 and 2, taken together, produce a self-consistent picture?

**Closure equation.** Define the total predicted noise budget:


$$
\sigma_\text{tot}^2 = \sigma_\text{Gaussian}^2 + \sigma_\text{Poisson}^2 + \sigma_\text{Lévy}^2,
$$


where each term is computed from the inferred parameters of the respective class (diffusion coefficient, event rate $$\times$$ mean kick variance, tail contribution up to truncation). The closure test requires:


$$
\left| \frac{\sigma_\text{tot}^2 - \sigma_\text{measured}^2}{\sigma_\text{measured}^2} \right| < \epsilon_\text{closure},
$$


with $$\epsilon_\text{closure}$$ set by the combined uncertainty budget (statistical + systematic).

**Failure actions:**

* If $$\sigma_\text{tot}^2 < \sigma_\text{measured}^2$$: a noise source is missing. Search for additional mechanisms.
* If $$\sigma_\text{tot}^2 > \sigma_\text{measured}^2$$: parameters are overestimated or classes are double-counted. Review inference assumptions.
* If closure fails after iterative refinement: archive as **Divergent** (per Council-3 Resolution Clause). Report the discrepancy explicitly; do not force agreement.

**Pillar-3 is mandatory.** Pillars 1 and 2 are necessary but not sufficient. Without closure, a statistically valid and physically plausible classification can still produce an inconsistent noise budget—indicating that the decomposition is incomplete or that the validity domain has been exceeded.

#### 7.4 Feasibility Gate for Lévy Exponent Inference

Estimating the stability parameter $$\alpha$$ from tail data requires sufficient events in the power-law regime. The acquisition timescale is


$$
T_\text{acq} \sim \frac{N_\text{ev}}{\lambda , d},
$$


where $$N_\text{ev} \sim 10^3\text{–}10^4$$ is the minimum number of tail events, $$\lambda$$ is the total event rate, and $$d$$ is the fraction of events exceeding the tail threshold.

**Stability horizon:** The maximum drift-free measurement window achievable with interleaved calibration (typically hours to a day, depending on laboratory stability).

* If $$T_\text{acq} <$$ stability horizon: proceed with $$\alpha$$ estimation.
* If $$T_\text{acq} >$$ stability horizon: **downgrade to detection-only.** Report that heavy tails are detected but $$\alpha$$ is not reliably estimable at current event rates. Do not publish a point estimate of $$\alpha$$ without the requisite statistical power.

***

### 8. Limitations and Extensions (Strictly Bounded)

The Decision Engine operates within the validity domain specified in §2 (Tier Map). The following extensions lie outside the current scope; branch conditions are defined to prevent silent extrapolation.

**Non-Markovian environments ($$\mu \lesssim 1$$).** When bath correlation times exceed the interrogation window—as for $$1/f$$ patch-potential fluctuations with very low corner frequencies—the Lévy–Khintchine generator is not applicable. Branch: memory-kernel methods, fractional Brownian motion frameworks, or whitening of known spectral drifts before re-entry into the Engine.

**Multi-ion correlated dynamics.** When multiple ions share a common potential, the Green tensor becomes a matrix coupling spatial modes. Common-mode noise (typically Class I technical noise) and differential-mode noise (potentially Class II/III surface effects) can in principle be separated, but the single-ion restriction of this Sail does not cover the inference protocol for correlated multi-mode decoherence. Branch: extend $$\mathbf{G}$$ to multi-mode form; modify cumulant analysis for joint distributions.

**Feedback and active stabilisation.** Closed-loop systems modify the effective noise statistics seen by the ion. The open-loop classification of this Sail applies to the _uncompensated_ noise; the effect of feedback on the residual noise class is a separate analysis.

**Non-electromagnetic decoherence.** Magnetic-field noise coupling to spin-motion entangled states, gravitational perturbations, and other non-electromagnetic channels are outside the universal-mediation framework. The Engine does not classify such sources.

**Heavy-tailed Lévy models (quantitative).** A full quantitative treatment of $$\alpha < 2$$ stable laws—including finite-size effects, truncated tails, and the crossover from compound-Poisson to genuinely heavy-tailed behaviour—requires dedicated theoretical and numerical work beyond the scope of this Sail. The current treatment provides a detection and feasibility framework; quantitative Lévy modelling is deferred to future coastline-level work.

_All extensions are flagged as out of scope; branch conditions are defined._

***

### 9. Conclusion — What Changes for Labs

#### Reporting standard

The Decision Engine implies a richer reporting standard than the conventional $$\dot{\bar{n}}$$. We suggest that trapped-ion noise characterisation reports include, at minimum:

1. The heating rate $$\dot{\bar{n}}$$ (for backward compatibility).
2. The regime parameters $$\lambda\tau$$ and $$\mu$$ at the measurement conditions used.
3. The identified operational class (Gaussian / compound-Poisson / Lévy-type / mixed / indeterminate) with confidence level.
4. Higher-order cumulants $$\kappa_3$$, $$\kappa_4$$ (even if consistent with zero—the null result is informative).
5. The full phonon distribution $$P(n\mid\tau)$$ or sufficient statistics thereof.
6. Validation status: which pillars passed, whether closure was achieved.

A trap with low $$\dot{\bar{n}}$$ but Lévy-type statistics is, for quantum error correction purposes, potentially worse than a trap with higher $$\dot{\bar{n}}$$ but confirmed Gaussian statistics—because uncorrectable extreme events defeat standard error correction codes whilst Gaussian noise can be managed by conventional filtering and averaging.

#### Protocol reference

This Sail is designed to serve as a protocol reference: the Decision Engine (§7) provides the operational flowchart; the validation architecture (§8) provides the quality assurance; the glossary (Appendix A) provides the shared vocabulary. Together, they define a reproducible methodology for statistical noise characterisation that can be adopted across laboratories without requiring each group to independently derive the underlying theory.

***

### Appendix A — Glossary

| Term                               | Symbol               | Definition                                                                                                                                                                                                                                                 |
| ---------------------------------- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Event rate**                     | $$\lambda$$            | Characteristic frequency of environmental disturbances (Hz). For collisions: $$\lambda = n_g \sigma v$$. For continuous noise: $$\lambda \sim 1/\tau_c$$.                                                                                                    |
| **Interrogation time**             | $$\tau$$               | Duration of the idle/noise-evolution period in a single stroboscopic shot (s). A controlled experimental parameter.                                                                                                                                        |
| **Bath correlation time**          | $$\tau_c$$            | Timescale over which environmental correlations decay. For Markovian baths, $$\tau_c \ll \omega_t^{-1}$$.                                                                                                                                                  |
| **Event-count parameter**          | $$\lambda\tau$$        | Dimensionless product counting expected independent noise events per shot. Organises temporal statistics: diffusive ($$\gg 1$$), intermediate ($$\sim 1$$), sparse ($$\ll 1$$).                                                                                  |
| **Markov-accessibility parameter** | $$\mu = \tau/\tau_c$$ | Dimensionless ratio gating the validity of the Markov approximation. $$\mu \gg 1$$: Markov-accessible (Engine valid). $$\mu \lesssim 1$$: Markov-inaccessible (Engine degrades).                                                                               |
| **Event**                          | —                    | A single discrete disturbance (collision, charging transient, photon recoil) producing a resolvable change in the ion's motional state. For continuous noise, an "event" is understood as one independent fluctuation interval of duration $$\sim \tau_c$$. |
| **Jump**                           | —                    | The instantaneous change in phonon number $$\Delta n$$ resulting from a single event. Related to momentum transfer $$\Delta p$$ via the displacement operator $$U_{\Delta p}$$ and phonon transition amplitudes.                                                |
| **Markov-accessible**              | —                    | A measurement regime in which the Markov approximation holds ($$\mu \gg 1$$) and the Lévy–Khintchine generator is a valid description of the dynamics.                                                                                                       |
| **Closure**                        | —                    | The Pillar-3 consistency test requiring the sum of inferred noise contributions to match the total measured variance within the uncertainty budget.                                                                                                        |
| **Stability horizon**              | —                    | The maximum duration over which drift-free measurements can be sustained with interleaved calibration. Sets the upper bound on $$T_\text{acq}$$ for tail-exponent inference.                                                                                |

***

### Appendix B — Lock-Compliance Checklist

#### B.1 Tier-0 Boundary Conditions

> **Box: T0 Boundary Conditions**
>
> 1. Harmonic confinement: $$U(x) = \frac{1}{2}m\omega_t^2 x^2$$ with anharmonic corrections perturbative.
> 2. Linear coupling: $$H_\text{int} = -qxE_x(\mathbf{r}_0, t)$$; ion motion small compared to field-variation scale.
> 3. Markovian bath: $$\tau_c \ll \omega_t^{-1}$$; equivalently $$\mu \gg 1$$.
> 4. Stationary statistics: noise correlations depend only on time differences.
> 5. Single-ion restriction: no multi-ion correlated dynamics.

#### B.2 Degradation Triggers and Branch Actions

| Trigger                                  | Detection method                                     | Action                                                                    |
| ---------------------------------------- | ---------------------------------------------------- | ------------------------------------------------------------------------- |
| $$\mu \lesssim 1$$                         | Autocorrelation of noise proxy; $$\tau_c$$ estimate   | Degrade to screening heuristic. Open non-Markov branch.                   |
| Non-stationarity                         | Drift in interleaved calibrations                    | Halt classification. Subtract drift or shorten acquisition window.        |
| Anharmonic regime                        | Large motional excitation; measured frequency shifts | Flag enhanced dephasing. Proceed with caution for heating classification. |
| Multi-ion mode coupling                  | Correlated heating across ions                       | Flag scope exceeded. Extend to multi-mode $$\mathbf{G}$$.                   |
| Lévy $$T_\text{acq} >$$ stability horizon | Feasibility-gate computation                         | Downgrade to detection-only for tail exponent.                            |

#### B.3 Claim Bounding List

| Forbidden phrase                                               | Replacement                                                                                         |
| -------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| "all EM noise" (unbounded)                                     | "all electromagnetically coupled noise within the validity domain of §2"                            |
| "exhaustive" (unbounded)                                       | "exhaustive within the Markov-accessible zone under harmonic confinement and stationary statistics" |
| "universal" (unbounded)                                        | "universal within the domain of single-ion motional decoherence under linear EM coupling"           |
| "the Lévy exponent is $$\alpha = \ldots$$" (without feasibility) | "the Lévy exponent is estimated as $$\alpha = \ldots$$ subject to the feasibility gate of §7/§8.4"    |
| "Pillars 1 and 2 confirm…" (without closure)                   | "Pillars 1, 2, and 3 (consistency closure) confirm…"                                                |
| "determines the regime" ($$\lambda\tau$$ alone)                  | "$$\lambda\tau$$, jointly with the Markov gate $$\mu$$, determines the accessible regime"               |
| "noise spectroscopy" (implying completeness)                   | "statistical noise characterisation within the operational framework"                               |
| "applies to all quantum systems"                               | "applies to single-ion motional decoherence; platform generalisations require separate treatment"   |

***

### Appendix C — Validation Architecture Box

> **Three-Pillar Validation Summary**

| Pillar                         | Question                                              | Method                                                                                                                                                          | Output                                    | Failure Action                                                                                                                           |
| ------------------------------ | ----------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| **1. Classification power**    | Can we distinguish the three classes at achieved $$N$$? | Monte Carlo confusion matrix with synthetic data                                                                                                                | $$C_{ii} > 0.90$$ required                 | Acquire more data or widen confidence interval                                                                                           |
| **2. Physical predictability** | Does the class match the physics?                     | Compare inferred $$\lambda$$, $$\nu(\Delta p)$$ against $$\mathbf{G}$$-tensor predictions and independent physical controls (pressure, temperature, geometry scaling) | Quantitative agreement within uncertainty | Revise physical-model assignment; seek alternative source                                                                                |
| **3. Consistency closure**     | Do Pillars 1+2 sum correctly?                         | Closure equation: $$\lvert\sigma_\text{tot}^2 - \sigma_\text{measured}^2\rvert / \sigma_\text{measured}^2 < \epsilon_\text{closure}$$                         | Pass/fail                                 | Missing source ($$\sigma_\text{tot}^2$$ too small) or double-counting ($$\sigma_\text{tot}^2$$ too large); iterate or archive as Divergent |

> **Feasibility gate** (Lévy tail inference): $$T_\text{acq} \sim N_\text{ev}/(\lambda d)$$. If $$T_\text{acq} >$$ stability horizon → downgrade to detection-only; do not publish point estimate of $$\alpha$$.
>
> **Pillar 3 is mandatory.** Classification is provisional until closure is verified.

***

_End of Sail v1.0-draft._
