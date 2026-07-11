# Project: soc2doc_docs

## Purpose

Docs-as-code source for `docs.soc2doc.ai`, the public Mintlify documentation site for soc2doc. This repo is separate from the main Next.js app and publishes through Mintlify.

## Ownership

- `docs.json` owns Mintlify site configuration, theme, navigation, footer, and brand tokens.
- `*.mdx` pages own public docs content. Keep them calm, precise, practitioner-led, and honest.
- `scripts/honesty-grep.sh` is the local content safety gate for banned brand tokens, fabricated API claims, false audit claims, and retired parent-brand references.
- `.github/workflows/docs-ci.yml` owns repository validation before merge and after pushes to `main`.
- `OPERATIONS.md` owns publishing, review, rollback, and feedback-routing rules.

## Local Contracts

- Public docs must not fabricate API endpoints, Trust Services Criteria, certification claims, audit authority, or gap-analysis capability for the free review.
- soc2doc never performs the SOC 2 audit; independent CPA firms do.
- The free Commitment Review mirrors commitments only. It does not score, grade, or perform gap analysis.
- Use the soc2doc `--s2-*` palette only: navy `#0a1f3a`, green `#15803d` / `#16a34a`, Inter. Do not use reserved parent-brand colors or positioning-guide visual tokens.
- Parent-company naming is `Generation AI LLC`. Do not use retired parent-brand names in public docs.
- Never commit Mintlify, Vercel, database, API, or customer secrets.

## Work Guidance

- Prefer pull requests into `main`; merges to `main` publish through the connected Mintlify GitHub App.
- Every material docs change must reference a Linear issue or create one.
- Capture buyer confusion, docs corrections, and product questions as Linear issues with label `docs-feedback`.
- Update `CHANGELOG.md` for material content, navigation, process, or policy changes. Typos and formatting-only edits may skip it.
- Keep public docs factual and reserved. Avoid combative comparisons, hype, or copy that sounds like a sales page wearing a docs costume.

## Verification

- `bash scripts/honesty-grep.sh`
- `npx -y mint@latest validate`
- `npx -y mint@latest broken-links`
- `npx -y mint@latest export --output /tmp/soc2doc-docs-export.zip`
- Public post-publish smoke: `https://docs.soc2doc.ai`, `/llms.txt`, `/sitemap.xml`, and key pages return `200`.

## Child DOX Index

None.

## Content boundary — this repo is PUBLIC

Canonical structure rules live in the private repo: `soc2doc/STRUCTURE.md`. Binding here: content arrives only by deliberate, sanitized promotion — never sourced directly from PRDs or `.planning/`. No client/tenant names, no roadmap, no internal pricing mechanics (public price: One Plan, $999/mo), no security implementation detail. Task tracking: Linear (ITS-), branch names from Linear, `Fixes ITS-xxx` in PRs.
