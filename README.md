# soc2doc-docs

Source for **docs.soc2doc.ai** - the documentation and positioning site for
[soc2doc](https://soc2doc.ai), a Generation AI LLC product. Built with
[Mintlify](https://mintlify.com) using docs-as-code: MDX plus `docs.json`.

This repo is intentionally separate from the marketing app. Nothing here is
hard-coded into the Next app; Mintlify hosts the subdomain directly. The docs host
does not route through the app proxy.

## Structure

```
docs.json            site config: theme, brand colors, logo, fonts, navigation
favicon.svg          navy monogram
logo/light.svg       navy wordmark (light mode)
logo/dark.svg        inverted wordmark (dark mode)
introduction.mdx     landing / overview
product/             product docs: Commitment Review, process, confidentiality
why/                 positioning docs: what soc2doc is, comparison, FAQ
api/                 developer preview: honest scaffold, no live endpoints yet
scripts/honesty-grep.sh   honesty + banned-token gate
AGENTS.md            DOX contract for this repo
OPERATIONS.md        publishing, review, rollback, and feedback routing
CHANGELOG.md         material docs changes
```

## Contribution Contract

- **PR-editable.** Edit MDX and `docs.json`, open a PR. Merges to `main` trigger a
  Mintlify build through the connected GitHub App. Keep `docs.json` valid JSON.
- **Change-controlled.** Material changes need a Linear issue, GitHub PR, CI checks,
  Mintlify preview review, and owner approval when they affect positioning,
  confidentiality, security, pricing, API language, or product behavior. See
  [`OPERATIONS.md`](./OPERATIONS.md).
- **Brand: `--s2-*` only.** Use navy `#0a1f3a`, green `#15803d` / `#16a34a`, and
  Inter. Parent-brand coral `#f47e52`, gold `#fed700`, and purple `#573053` are
  forbidden. Positioning-guide visual tokens such as `--ink`, `--pulse`, and
  `Space Grotesk` must not appear in shipped config.
- **Auditor-grade honesty.** No fabricated API endpoints, no invented Trust
  Services Criteria, no "we audit / certify / guarantee". soc2doc never performs
  the audit; the free Commitment Review does no gap analysis.
- **Company name.** Use `Generation AI LLC`.
- **Never commit secrets.** Mintlify, Vercel, database, API, and customer secrets
  stay out of this repo.

## Before Every Content Publish

Run the local gates before every material PR:

```bash
bash scripts/honesty-grep.sh
npx -y mint@latest validate
npx -y mint@latest broken-links
npx -y mint@latest export --output /tmp/soc2doc-docs-export.zip
```

The GitHub Actions workflow runs the same checks on PRs and pushes to `main`.
Mintlify's GitHub App supplies the PR preview and production deployment after merge.

Reviewed negations ("we do **not** perform the audit", "**no** gap analysis",
"does **not** expose a public API") are allowed because they are the honest claims.

## Docs Feedback

Route actionable docs feedback into Linear project **SOC2DOC Platform Build** with
label `docs-feedback`. Include the page URL, the quoted confusion or correction,
and whether it is urgent. See [`OPERATIONS.md`](./OPERATIONS.md#feedback-router).

## Local Preview

Mintlify's push-triggered preview is the source of truth. For a local render:

```bash
npx mint@latest dev
```
