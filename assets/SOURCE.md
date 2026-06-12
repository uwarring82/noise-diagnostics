# Asset provenance (Model B, §0.10)

Source repo:    github.com/threehouse-plus-ec/cd-rules
Source path:    repository root (NOTE: the upstream blueprint §14 diagrams place these
                in `assets/`; the live source keeps them at root — divergence recorded,
                see TC-STN-INIT-01 §8/D-5)
Pinned commit:  a61ad52ff46bcb64874dba1de84d49d681e06629   (2026-06-12T09:52:52Z)
Tag:            cd-1.8.2   (annotated; points to the commit above)
                — supersedes D-5's proposed new tag `cd-1.8.2-freeze`: a named freeze
                  anchor already exists at the pin, so no second tag was cut (§0.12,
                  single source of truth). EC note: logbook/2026-06-12-init.md.
Blueprint:      CD 1.8.2 (frozen Coastline, 2026-06-12)

## SHA-256
7298b11e6231d27d3454a16380c4d511e1c2251c7c168c5f66cafa8bc05fe44b  emblem-16.svg
e799f0bd9ddc5d36c6904c43690c8507215ea78d5d12cc5fec53992bade9ff0b  emblem-32.svg
48bf761c7f903d09b7b98a5cc8b813c035d8c34b31bdece685f0b9c51387fe55  emblem-64.svg
84defa4091307bd59a30b262ea83d1e244da0d317770dbf56661baaa09add0f2  wordmark-full.svg
164e8317cd8058c3eb3c3fab8c3a2aa15e2b008300dbb4046f7a0a77090e73fb  wordmark-silent.svg
097b5903dc3983d3215fb46b4b76948a716e5d2448a1175910b884c25af63962  tokens.css

# Verify (from assets/):
#   grep -E '^[0-9a-f]{64}  ' SOURCE.md | sha256sum -c
