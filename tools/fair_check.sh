#!/usr/bin/env bash
# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: 2026 U. Warring
#
# fair_check.sh — reference checker for the FAIR Research-Repository Profile
# (T(h)reehouse +EC Corporate Design Blueprint, §14A).
#
# CANONICAL REFERENCE IMPLEMENTATION (§14A.9). The blueprint text is normative;
# this script is its pinned, evidentiary reference implementation: it settles the
# CI (machine) half of each FR rule and demonstrates implementability. If checker
# and specification ever disagree, that disagreement is a BLOCKING DEFECT resolved
# by amendment (Harbourmaster ruling §7.3) — never by silent checker precedence.
# Consuming repos copy it via Model B (§0.10), as they copy emblems and tokens.
#
# Reviewer (human) predicates are reported, never failed: FR8 "record matches the
# cited work" / "note faithful", CFF 1.2 schema semantics (FR2), logbook
# append-only history (FR3), a *substantive* lede (FR6), a *plain-language* status
# (FR9). "All checks green" means the CI half only (§14A.9).
#
# Usage:  tools/fair_check.sh [REPO_DIR]   (REPO_DIR defaults to the repo root;
#         when run from a Model-B copy in tools/, no argument is needed)
# Exit:   0 iff no CI check FAILs; 1 if any does; 2 on bad invocation.
#
# Pinned version (must match the §16 row that validated it):
FAIR_CHECK_VERSION="1.8.2"
#
# ---------------------------------------------------------------------------
# PINNED MATCHER (§14A.8) — whole-token, case-disciplined, PCRE (perl).
# ---------------------------------------------------------------------------
# Closed Harbour list: Harbour, Harbourmaster, Coastline, Sail, witness, +EC.
#   * Harbour/Harbourmaster/Coastline/Sail  -> case-SENSITIVE proper house nouns;
#     Harbourmaster is tested before Harbour.
#   * witness  -> case-INSENSITIVE ([Ww]itness): appears sentence-initial.
#   * the collective is matched ONLY as the canonical "+EC" (Harbourmaster ruling
#     §7.1). A bare two-letter "EC" — which collides with the decision IDs
#     EC-1..EC-4 and with *error correction* (e.g. the index.html aria-hidden gate
#     glyph) — LEAVES the auto-checked set: glossed by convention, not by FR4/FR5.
# Perl PCRE is required (BSD grep lacks -P/look-around); perl ships with macOS.
HARBOUR_RE='(?:\bHarbourmaster\b|\bHarbour\b|\bCoastline\b|\bSail\b|\b[Ww]itness\b|\+EC(?![A-Za-z0-9]))'

set -u

# REPO_DIR: explicit argument, else the parent of this script (Model-B copy in
# tools/), else the current directory.
REPO="${1:-}"
if [ -n "$REPO" ]; then
  cd "$REPO" 2>/dev/null || { echo "fair_check: cannot enter '$REPO'" >&2; exit 2; }
elif cd "$(dirname "$0")/.." 2>/dev/null && [ -f README.md ]; then
  :
else
  cd "$(pwd)" || exit 2
fi
ROOT="$(pwd)"
FAIL=0
pass(){ printf '  \033[0;32mPASS\033[0m  %s\n' "$1"; }
fail(){ printf '  \033[0;31mFAIL\033[0m  %s\n' "$1"; FAIL=1; }
warn(){ printf '  \033[0;33mWARN\033[0m  %s\n' "$1"; }
note(){ printf '        %s\n' "$1"; }
rule(){ printf '\n\033[1m%s\033[0m\n' "$1"; }

VISITOR_FILES="README.md index.html OUTREACH.md"

# Rendered, accessibility-exposed text (§14A.7): strip HTML comments, <script>,
# and <style>. (aria-hidden / alt discrimination beyond the +EC rule is the
# reviewer's, per §14A.7/§14A.9 — fragile HTML parsing is not mechanised here.)
strip_html(){ perl -0777 -pe 's/<!--.*?-->//gs; s/<script\b[^>]*>.*?<\/script>//gis; s/<style\b[^>]*>.*?<\/style>//gis;' "$1"; }

echo "FAIR §14A mechanical checks (CD v$FAIR_CHECK_VERSION) — $(git -C "$ROOT" rev-parse --short HEAD 2>/dev/null || echo '(no git)') — $ROOT"
echo "Pinned Harbour matcher (perl PCRE, §14A.8):"
echo "    $HARBOUR_RE"

# --- FR1 — README declares the FAIR profile (+ optional entry-surface) -------
rule "FR1  README declares the FAIR profile (§14A.1)"
note "method: grep a machine-readable 'FAIR profile: full|minimal' key; if 'entry-surface:' present, the named file must exist"
if hit=$(grep -inE 'FAIR profile:[[:space:]]*(full|minimal)' README.md | head -1); then
  pass "declared -> README.md:$hit"
else
  fail "no 'FAIR profile: full|minimal' declaration found in README.md"
fi
ENTRY_SURFACE=$(perl -ne 'if(/entry-surface:\s*(\S+)/i){ my $v=$1; $v=~s/[`"<>].*//; print $v; exit }' README.md 2>/dev/null)
if [ -n "$ENTRY_SURFACE" ]; then
  [ -e "$ENTRY_SURFACE" ] && note "entry-surface: $ENTRY_SURFACE (exists) — FR5–FR7 bind it (§14A.7)" \
                          || fail "entry-surface '$ENTRY_SURFACE' declared but not found"
else
  note "no entry-surface declared — README.md is the primary entry surface by default (§14A.7)"
fi
note "reviewer: the declaration also renders as a human-visible line, not only front matter"

# --- FR2 — CITATION.cff valid CFF 1.2 + resolvable repo URL -----------------
rule "FR2  CITATION.cff valid CFF 1.2 + resolvable repo URL"
note "method: cffconvert --validate (else structural cff-version check); then resolve the url:/repository-code:"
if [ ! -f CITATION.cff ]; then
  fail "CITATION.cff not found"
else
  if command -v cffconvert >/dev/null 2>&1; then
    if cffout=$(cffconvert --validate -i CITATION.cff 2>&1); then pass "CFF valid: $cffout"; else fail "CFF invalid: $cffout"; fi
  else
    ver=$(grep -E '^cff-version:' CITATION.cff | head -1)
    note "cffconvert not installed; structural check only -> $ver"
    echo "$ver" | grep -q '1\.2' && pass "cff-version is 1.2.x (validator unavailable — full schema is reviewer's)" || fail "cff-version not 1.2.x"
  fi
  URL=$(grep -E '^(url|repository-code):' CITATION.cff | head -1 | sed -E 's/^[a-z-]+:[[:space:]]*"?([^"]*)"?.*/\1/')
  note "url: ${URL:-none}"
  # curl prints "000" on connection failure; default empty to 000 (never "|| echo 000").
  code=$(curl -sS -o /dev/null -w '%{http_code}' -I --max-time 20 "$URL" 2>/dev/null); code=${code:-000}
  case "$code" in
    2*|3*) pass "repo URL resolves (HTTP $code)";;
    000)   note "network unavailable (HTTP 000) — URL resolvability not checkable offline (degrade)";;
    *)     fail "repo URL did not resolve (HTTP $code)";;
  esac
fi

# --- FR3 — logbook in any admissible form (§14A.3, ruling §7.2) --------------
rule "FR3  a logbook (any admissible form) has a dated entry"
note "method: accept logbook/ dir (YYYY-MM-DD-*), logbook/LOG.md, logbook.md, or docs/logbook.md, with a dated entry"
lb=""
if [ -d logbook ] && d=$(ls logbook 2>/dev/null | grep -E '^[0-9]{4}-[0-9]{2}-[0-9]{2}' | head -1) && [ -n "$d" ]; then
  lb="logbook/$d"
else
  for f in logbook/LOG.md logbook.md docs/logbook.md; do
    if [ -f "$f" ] && grep -qE '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$f"; then lb="$f"; break; fi
  done
fi
[ -n "$lb" ] && pass "dated entry present -> $lb" \
             || fail "no admissible logbook (logbook/ dir, logbook/LOG.md, logbook.md, or docs/logbook.md) with a dated entry"
note "reviewer: entries are append-only — a git-history property, verified via 'git log' (§14A.3)"

# --- FR4 — every Harbour term on a visitor file is glossed with an anchor ----
rule "FR4  Harbour + house terms on visitor files resolve to a glossary anchor"
note "method: scan rendered text of $VISITOR_FILES (HTML comments/script/style stripped, §14A.7); each term maps to a GLOSSARY.md slug"
if [ ! -f GLOSSARY.md ]; then
  fail "GLOSSARY.md not found"
else
  ANCHORS=$(perl -ne 'if(/^#{1,6}\s+(.*?)\s*$/){my $s=lc $1; $s=~s/[^\w\s-]//g; $s=~s/\s+/-/g; print "$s\n";}' GLOSSARY.md)
  check_term(){ # $1 perl-regex  $2 anchor-slug  $3 label
    local found="" f txt
    for f in $VISITOR_FILES; do
      [ -f "$f" ] || continue
      case "$f" in *.html) txt=$(strip_html "$f");; *) txt=$(cat "$f");; esac
      if printf '%s' "$txt" | perl -ne "BEGIN{\$x=1} \$x=0 if /$1/; END{exit \$x}"; then found="$f"; break; fi
    done
    if [ -n "$found" ]; then
      if echo "$ANCHORS" | grep -qx "$2"; then pass "$3 appears ($found) -> GLOSSARY.md#$2"
      else fail "$3 appears ($found) but no GLOSSARY.md#$2 anchor"; fi
    else
      note "$3 not present on visitor files (no obligation)"
    fi
  }
  check_term '\bHarbourmaster\b'  'harbourmaster'     'Harbourmaster'
  check_term '\bHarbour\b'        'harbour'           'Harbour'
  check_term '\bCoastline\b'      'coastline'         'Coastline'
  check_term '\bSail\b'           'sail'              'Sail'
  check_term '\b[Ww]itness\b'     'witness'           'witness'
  check_term '\+EC(?![A-Za-z0-9])' 'ec'               '+EC (collective)'
  check_term '\bBreakwater Ledger\b|\bLedger\b' 'breakwater-ledger' 'Breakwater Ledger'
  check_term '\bEndorsement Marker\b' 'endorsement-marker' 'Endorsement Marker'
  check_term '\bCouncil-3 ADM-EC\b|\bADM-EC\b' 'council-3-adm-ec' 'Council-3 ADM-EC'
fi

# Welcome block of the primary entry surface (default README.md). v1.8.2 boundary
# (§14A.4): after front matter + H1, up to WHICHEVER COMES FIRST of a thematic
# break (---/***/___/<hr>, each preceded by a blank line — setext guard) OR the
# first ## heading; whole body if neither (and warn). HTML comments stripped.
ENTRY="README.md"
WELCOME=$(perl -0777 -ne '
  s/\A---\n.*?\n---\n//s;                       # drop leading YAML front-matter fence pair
  s/\A\s*#[^\n]*\n//;                            # drop the H1 line
  s/<!--.*?-->//gs;                              # strip HTML comments (§14A.7)
  if (/(.*?)(?:\n[ ]*\n[ ]{0,3}(?:-{3,}|\*{3,}|_{3,}|<hr\b[^>]*>)[ ]*(?:\n|\z)|\n[ ]{0,3}#{2,6}[ ])/s) { print $1 } else { print }
' "$ENTRY")
LEDE=$(perl -0777 -ne '
  s/\A---\n.*?\n---\n//s;                        # drop leading YAML front matter (both fences)
  s/\A\s*#[^\n]*\n//;                            # drop the H1 line
  s/<!--.*?-->//gs;                              # strip HTML comments
  s/\A\s+//;                                     # drop leading blank lines
  if (/(.*?)(\n\s*\n|\z)/s) { print $1 }         # first paragraph (to blank line)
' "$ENTRY")
UNBOUNDED=$(perl -0777 -ne '
  s/\A---\n.*?\n---\n//s; s/\A\s*#[^\n]*\n//; s/<!--.*?-->//gs;
  print "1" unless (/\n[ ]*\n[ ]{0,3}(?:-{3,}|\*{3,}|_{3,}|<hr\b[^>]*>)[ ]*(?:\n|\z)/s || /\n[ ]{0,3}#{2,6}[ ]/);
' "$ENTRY")

# --- FR5 — Harbour tokens in the welcome block are glossary-linked ----------
rule "FR5  Harbour tokens in the welcome block link to the glossary"
note "method: welcome block = after front matter + H1, to first thematic break OR first ## (§14A.4); strip [text](GLOSSARY.md#...) spans; any Harbour token remaining is unlinked"
[ -n "$UNBOUNDED" ] && warn "welcome block is unbounded (no thematic break or ## heading) — whole $ENTRY is in FR5/FR6 scope (§14A.4): bound it explicitly"
if [ -n "$ENTRY_SURFACE" ] && [ "$ENTRY_SURFACE" != "README.md" ]; then
  note "entry-surface '$ENTRY_SURFACE' is declared: README is the Markdown authority (§0.5); a faithful render inherits, an independent surface's rendered welcome block is reviewer-owned (§14A.7)"
fi
WB_STRIPPED=$(printf '%s' "$WELCOME" | perl -pe 's/\[[^\]]*\]\(GLOSSARY\.md#[^)]*\)//g')
if leftover=$(printf '%s' "$WB_STRIPPED" | perl -ne "print \"$.: \$_\" if /$HARBOUR_RE/"); [ -z "$leftover" ]; then
  pass "every Harbour token in the welcome block is glossary-linked (or none appears)"
else
  fail "unlinked Harbour token(s) in welcome block:"; printf '%s\n' "$leftover" | sed 's/^/        /'
fi

# --- FR6 — welcome block opens with a Harbour-free substantive paragraph -----
rule "FR6  welcome-block lede is free of Harbour vocabulary"
note "method: first paragraph after front matter + H1; scan for whole-token Harbour terms (substantive is reviewer's)"
note "lede begins: \"$(printf '%s' "$LEDE" | head -c 68 | tr '\n' ' ')...\""
if [ -z "$LEDE" ]; then
  fail "no opening paragraph found in the welcome block"
elif hits=$(printf '%s' "$LEDE" | perl -ne "print for /($HARBOUR_RE)/g"); [ -z "$hits" ]; then
  pass "lede contains no Harbour vocabulary"
else
  fail "Harbour vocabulary in lede: $(printf '%s' "$hits" | tr '\n' ' ')"
fi

# --- FR7 — endorsement marker does not precede the lede (rendered order) -----
rule "FR7  §0.7 endorsement marker does not appear before the lede"
note "method: line of first 'Endorsement Marker' in $ENTRY vs first lede line (rendered/DOM order; HTML order is reviewer's)"
LEDE_LN=$(grep -nE '^[^#> ].*[A-Za-z]' "$ENTRY" | perl -ne 'next if /^\d+:---/||/^\d+:FAIR profile/; if(/^(\d+):/){print $1; exit}')
MARK_LN=$(grep -niE 'Endorsement Marker' "$ENTRY" | head -1 | cut -d: -f1)
note "lede starts at $ENTRY:${LEDE_LN:-?}; first marker at $ENTRY:${MARK_LN:-none}"
if [ -z "${MARK_LN:-}" ]; then
  pass "no endorsement marker in $ENTRY (cannot precede the lede)"
elif [ "${LEDE_LN:-0}" -lt "${MARK_LN:-0}" ]; then
  pass "lede (line $LEDE_LN) precedes marker (line $MARK_LN)"
else
  fail "marker (line $MARK_LN) appears at/before lede (line ${LEDE_LN:-?})"
fi

# --- FR8 — present -> resolvable -> correct (CI half) ------------------------
rule "FR8  BIBLIOGRAPHY.md — present -> resolvable -> correct (CI half)"
note "method: per entry identifier + provenance note; git-tracked record covering all entries; DOIs resolve at doi.org (HEAD->GET fallback, §14A.8); denylist no tracked PDFs outside figures/"
if [ ! -f BIBLIOGRAPHY.md ]; then
  fail "BIBLIOGRAPHY.md missing"
else
  read -r total ident noted < <(perl -0777 -ne '
    my @b = split /\n(?=- )/;
    my ($t,$i,$n)=(0,0,0);
    for (@b){ next unless /^- /m; $t++; $i++ if /(doi\.org|arxiv\.org|\bISBN\b)/i; $n++ if /Provenance/i; }
    print "$t $i $n";
  ' BIBLIOGRAPHY.md)
  note "entries: $total; with identifier: $ident; with provenance note: $noted"
  { [ "$total" -gt 0 ] && [ "$total" -eq "$ident" ]; } && pass "all $total entries carry a resolvable identifier (present)" \
                                                       || fail "$((total-ident)) of $total entries lack a resolvable identifier"
  [ "$total" -eq "$noted" ] && pass "all $total entries carry an in-your-words provenance note" \
                            || fail "$((total-noted)) of $total entries lack a provenance note"
  # committed = git-tracked (§14A.5), covering every entry.
  REC=""; for f in references.bib references.json; do
    git -C "$ROOT" ls-files --error-unmatch "$f" >/dev/null 2>&1 && REC="$f"
  done
  if [ -n "$REC" ]; then
    if [ "$REC" = references.json ]; then nrec=$(grep -coE '"id"[[:space:]]*:' "$REC"); else nrec=$(grep -cE '^@' "$REC"); fi
    note "machine-readable record: $REC ($nrec records, git-tracked)"
    [ "$nrec" -ge "$total" ] && pass "record committed and covers all entries ($nrec >= $total)" \
                             || fail "record $REC has $nrec records < $total entries"
  elif [ -f references.bib ] || [ -f references.json ]; then
    fail "machine-readable record present but UNTRACKED (git add it — §14A.5 requires committed)"
  else
    fail "no machine-readable record (references.bib / references.json) committed"
  fi
  # resolvability — doi.org only, no publisher-follow (§14A.8). HEAD; GET fallback
  # when HEAD is rejected/inconclusive (405/501, HEAD-specific 403/429). Taxonomy:
  # 2xx/3xx resolves; 404/410 dead (fail); 403/429 inconclusive; 000 offline (degrade).
  dois=$(grep -oE 'doi\.org/[^ >)]+' BIBLIOGRAPHY.md | sed 's#.*doi\.org/##' | sort -u)
  nd=$(printf '%s\n' "$dois" | grep -c .); res=0; off=0; incon=0; dead=""
  for d in $dois; do
    c=$(curl -sS -o /dev/null -w '%{http_code}' -I --max-time 12 "https://doi.org/$d" 2>/dev/null); c=${c:-000}
    case "$c" in
      403|405|429|501)  # HEAD rejected/inconclusive -> GET fallback (status only, no -L)
        g=$(curl -sS -o /dev/null -w '%{http_code}' --max-time 12 "https://doi.org/$d" 2>/dev/null); g=${g:-000}
        [ "$g" != 000 ] && c="$g" ;;
    esac
    case "$c" in
      2*|3*)   res=$((res+1));;
      000)     off=$((off+1));;
      404|410) dead="$dead $d";;
      *)       incon=$((incon+1));;
    esac
  done
  if [ "$nd" -eq 0 ]; then note "no DOI identifiers to resolve (arXiv/ISBN resolution is reviewer-owned, §14A.8)"
  elif [ "$off" -eq "$nd" ]; then note "resolvability: network unavailable ($nd DOIs unchecked offline — degrade)"
  elif [ -n "$dead" ]; then fail "DOI(s) not registered at doi.org (404/410):$dead"
  else
    pass "no dead DOIs ($res/$nd resolve at doi.org; $incon inconclusive [403/429]; $off offline)"
  fi
  badpdf=$(git -C "$ROOT" ls-files '*.pdf' '*.PDF' 2>/dev/null | grep -vE '^figures/' || true)
  [ -z "$badpdf" ] && pass "denylist clean: no tracked PDFs outside the repo's own figures/" \
                   || { fail "tracked PDF(s) outside figures/ — possible copyrighted full text (§0.1):"; printf '%s\n' "$badpdf" | sed 's/^/        /'; }
  note "reviewer half — record matches the cited work; note is faithful (§14A.9, the Zurek example)"
fi

# --- FR9 — OUTREACH.md plain-language, dated status line ---------------------
rule "FR9  OUTREACH.md carries a dated status line"
note "method: a 'Status ... YYYY-MM-DD' line (plain-language is reviewer's)"
if [ -f OUTREACH.md ] && sl=$(grep -nE 'Status.*[0-9]{4}-[0-9]{2}-[0-9]{2}' OUTREACH.md 2>/dev/null | head -1); then
  pass "status line -> OUTREACH.md:$sl"
else
  fail "no dated 'Status ... YYYY-MM-DD' line in OUTREACH.md"
fi

# --- FR10 — OUTREACH status within 183 days of HEAD committer date -----------
rule "FR10  OUTREACH status within six months (183 days) of HEAD"
note "method: status date vs HEAD committer date (git show -s --format=%cs)"
SD=$(grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}' OUTREACH.md 2>/dev/null | sort | tail -1)
HD=$(git -C "$ROOT" show -s --format=%cs HEAD 2>/dev/null)
note "status date: ${SD:-none}; HEAD date: ${HD:-unknown}"
if [ -n "$SD" ] && [ -n "$HD" ]; then
  verdict=$(python3 - "$SD" "$HD" <<'PY'
import sys, datetime as d
s=d.date.fromisoformat(sys.argv[1]); h=d.date.fromisoformat(sys.argv[2])
floor=h - d.timedelta(days=183)
print("FRESH" if s>=floor else "STALE", floor.isoformat())
PY
)
  set -- $verdict
  if [ "$1" = FRESH ]; then pass "status fresh (>= $2)"; else fail "status STALE (< $2) — visible drift (§0.10)"; fi
else
  note "insufficient data to evaluate (offline or missing date — degrade)"
fi

echo
if [ "$FAIL" -eq 0 ]; then printf '\033[0;32mALL CI CHECKS PASS\033[0m — MANUAL/reviewer items above remain the reviewer'\''s (§14A.9).\n'
else printf '\033[0;31mONE OR MORE CI CHECKS FAILED\033[0m — see FAIL lines above.\n'; fi
exit "$FAIL"
