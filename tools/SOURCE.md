# Checker provenance (Model B, §0.10 / §14A.9)

File:           tools/fair_check.sh
Version:        1.8.2  (pinned by CD 1.8.2; validated against `broadcast-protection`, exit 0)
Source:         github.com/threehouse-plus-ec/cd-rules @ a61ad52 : tools/fair_check.sh
Tag:            cd-1.8.2   (annotated; points to a61ad52)
SHA-256:        d6090b77f83d2bb063fcffad78c5ec2118694c32af5ded252dab97b83f1f7ba0

Precedence (§14A.9): the blueprint text is normative; this checker is the pinned
evidentiary reference implementation. It settles the CI (machine) half of each FR rule;
the reviewer (human) half is reported, never failed. A checker/spec disagreement is a
blocking defect, resolved by amendment — never by silent checker precedence.

# Verify (from tools/):
#   echo "d6090b77f83d2bb063fcffad78c5ec2118694c32af5ded252dab97b83f1f7ba0  fair_check.sh" | sha256sum -c
