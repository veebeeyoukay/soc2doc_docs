# soc2doc-docs

Source for **docs.soc2doc.ai** — the documentation and positioning site for
[soc2doc](https://soc2doc.ai), a Generation AI LLC product. Built with
[Mintlify](https://mintlify.com) (docs-as-code: MDX + a single `docs.json`).

This repo is intentionally separate from the marketing app. Nothing here is
hard-coded into the Next app; Mintlify hosts the subdomain directly (the docs
host does **not** route through the app proxy).

## Structure

```
docs.json            site config: theme, brand colors, logo, fonts, navigation
favicon.svg          navy monogram
logo/light.svg       navy wordmark (light mode)
logo/dark.svg        inverted wordmark (dark mode)
introduction.mdx     landing / overview
product/             PILLAR 1 — how-to (Commitment Review, the process)
why/                 PILLAR 2 — positioning (what soc2doc is, vs Vanta/Drata/Sprinto, FAQ)
api/                 PILLAR 3 — developer preview (honest scaffold, no live endpoints yet)
scripts/honesty-grep.sh   the L-2 honesty + banned-token gate
```

## Contribution contract

- **PR-editable.** Edit MDX and `docs.json`, open a PR. Merges to `main` trigger a
  Mintlify build via the connected GitHub App. Keep `docs.json` valid JSON.
- **Brand: `--s2-*` only** (navy `#0a1f3a`, green `#15803d` / `#16a34a`, Inter fonts).
  The following parent-brand hexes are **forbidden** — they signal the wrong brand:
  coral `#f47e52`, gold `#fed700`, purple `#573053`. The positioning-guide section 8
  tokens (`--ink`, `--pulse`, `Space Grotesk`) are messaging references only and must
  **not** appear in shipped theme/config.
- **Auditor-grade honesty.** No fabricated API endpoints, no invented Trust Services
  Criteria, no "we audit / certify / guarantee". soc2doc never performs the audit; the
  free Commitment Review does **no** gap analysis. Say only what is true.
- **No "It's Jen AI".** That parent brand was retired company-wide (2026-07-05). The
  company is **Generation AI LLC**.
- **Never commit secrets.** Mintlify account keys live in the Mintlify dashboard only.
  No `MINTLIFY_*` / `mint_*` token belongs in any committed file.

## Before every content publish

Run the honesty gate. It fails on banned hexes, fabricated endpoints, fabricated
audit claims, fabricated TSC references, section 8 tokens, and retired brand names:

```bash
bash scripts/honesty-grep.sh
```

Reviewed negations ("we do **not** perform the audit", "**no** gap analysis",
"**does not** expose a public API") are allowed — those are the honest claims.

## Local preview (optional)

Mintlify's push-triggered preview is the source of truth. If you want a local render:

```bash
npx mint@latest dev
```
