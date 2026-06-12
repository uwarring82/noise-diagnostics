# Local source copies (untracked)

Full-text PDFs of the works in [`../../BIBLIOGRAPHY.md`](../../BIBLIOGRAPHY.md) are kept
**locally only**, in [`pdfs/`](pdfs/), which is git-ignored
([`/.gitignore`](../../.gitignore)).

**Why untracked (§0.1).** Copyrighted full text is never committed; the derived record
(`BIBLIOGRAPHY.md` + `references.bib`) is the committed substitute, and the FAIR checker
fails on any tracked PDF outside `figures/`. This file is a tracked *manifest* of the
local store — it records what should be present, not the content itself.

Filenames follow the BibTeX key in `references.bib` (`<key>.pdf`).

| BibTeX key | File | Pages | Access | Source |
|------------|------|-------|--------|--------|
| `brownnutt2015`  | `pdfs/brownnutt2015.pdf`  | 71 | 🟢 OA   | arXiv:1409.6572 |
| `turchette2000`  | `pdfs/turchette2000.pdf`  | 25 | 🟢 OA   | arXiv:quant-ph/0002040 |
| `deslauriers2006`| `pdfs/deslauriers2006.pdf`|  4 | 🟢 OA   | arXiv:quant-ph/0602003 |
| `davies1974`     | `pdfs/davies1974.pdf`     | 20 | 🔒 paywalled | maintainer-provided |
| `gks1976`        | `pdfs/gks1976.pdf`        |  6 | 🔒 paywalled | maintainer-provided |
| `lindblad1976`   | `pdfs/lindblad1976.pdf`   | 12 | 🔒 paywalled | maintainer-provided |
| `holevo1996`     | `pdfs/holevo1996.pdf`     | 22 | 🔒 paywalled | maintainer-provided |
| `breuer2007`     | `pdfs/breuer2007.pdf`     | 649| 🔒 paywalled (book) | maintainer-provided |
| `hornberger2006` | `pdfs/hornberger2006.pdf` |  5 | 🟢 OA   | arXiv:quant-ph/0607085 |
| `vacchini2009`   | `pdfs/vacchini2009.pdf`   | 63 | 🟢 OA   | arXiv:0904.3911 |
| `metzler2000`    | `pdfs/metzler2000.pdf`    | 77 | 🔒 paywalled | maintainer-provided |
| `clauset2009`    | `pdfs/clauset2009.pdf`    | 43 | 🟢 OA   | arXiv:0706.1062 |
| `hill1975`       | `pdfs/hill1975.pdf`       | 12 | 🟢 OA (free) | Project Euclid (scanned image; retrieved via Internet Archive — Euclid's own free OA PDF) |
| `sato1999`       | **missing** | — | 🔒 paywalled (book) | no legitimate free full text — see below |

## Not held: `sato1999`

Sato, *Lévy Processes and Infinitely Divisible Distributions* (Cambridge Studies in
Advanced Mathematics 68; 1999 ISBN 9780521553025, rev. 2013 ISBN 9781107656499) is a
current copyrighted monograph with **no legitimate open-access full text**. Cambridge
offers only a free [excerpt](https://assets.cambridge.org/97805215/53025/excerpt/9780521553025_excerpt.pdf)
and [frontmatter](https://assets.cambridge.org/97811076/56499/frontmatter/9781107656499_frontmatter.pdf);
the full book is purchase/institutional-access only, and archive.org has only a
controlled-lending (non-downloadable) copy.

- **To obtain the book:** university/institutional library, interlibrary loan, or
  purchase (Cambridge University Press / 2013 paperback ISBN 9781107656499).
- **Free legitimate substitute — held locally** as `pdfs/applebaum2004.pdf`:
  D. Applebaum, *Lévy Processes — From Probability to Finance and Quantum Groups*,
  Notices of the AMS (Nov 2004), https://www.ams.org/notices/200411/fea-applebaum.pdf —
  background reading for the Lévy–Khintchine material. It is a **companion**, not a
  bibliography entry (the Sail does not cite it), so it has no `references.bib` key.

## Rebuilding the OA copies

The 🟢 open-access files can be re-fetched from the sources above (arXiv `…/pdf/<id>`;
Hill via Project Euclid, DOI 10.1214/aos/1176343247). The 🔒 paywalled files must be
supplied from a licensed copy.
