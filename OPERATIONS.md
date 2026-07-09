# Docs Operations

This repo publishes `docs.soc2doc.ai` through the Mintlify GitHub App. The docs are public product commitments, so changes move through the same basic control surface as product work: Linear issue, PR, checks, preview review, owner approval when needed, then merge.

## Change Control

Use a pull request for every material change. A material change is any edit that changes product behavior, positioning, security/confidentiality language, pricing, API claims, navigation, or the operating process in this file.

Small typo fixes may merge with a short PR, but still run the gates.

Before merge:

1. Link a Linear issue in the PR.
2. Run `bash scripts/honesty-grep.sh`.
3. Run `npx -y mint@latest validate`.
4. Run `npx -y mint@latest broken-links`.
5. Run `npx -y mint@latest export --output /tmp/soc2doc-docs-export.zip`.
6. Review the Mintlify PR preview URL from the GitHub App.
7. Get owner approval for material product, positioning, security, pricing, or API language.

Merges to `main` publish through Mintlify. Do not bypass `main` for routine edits.

## Required Checks

The GitHub Actions workflow runs:

- `bash scripts/honesty-grep.sh`
- `npx -y mint@latest validate`
- `npx -y mint@latest broken-links`
- `npx -y mint@latest export --output /tmp/soc2doc-docs-export.zip`

Mintlify's GitHub App provides the preview deployment and deployment status. Treat a failed preview or export as blocking until resolved.

## Urgent Corrections

An urgent correction is one of:

- A false security, confidentiality, audit, API, legal, or pricing statement.
- A broken primary conversion path, such as the free review CTA.
- Public exposure of a customer name, customer report detail, secret, or non-public implementation detail.
- A docs error that could mislead a buyer, auditor, or customer into taking the wrong action.

For urgent corrections, open or link a Linear issue, make the smallest safe edit, run the gates, merge after owner approval, then add a short `CHANGELOG.md` note. If the current live docs are materially wrong, roll forward with the correction rather than waiting for a broader rewrite.

## Feedback Router

Every actionable docs signal gets a Linear issue in the `SOC2DOC Platform Build` project with label `docs-feedback`.

Use this routing:

- **Docs correction:** typo, broken link, outdated page, unclear step. Create `docs-feedback`; assign to the docs owner.
- **Buyer confusion:** a prospect misunderstands what soc2doc does, what the free review includes, or how it differs from platforms. Create `docs-feedback` and link the page/quote.
- **Product question:** feedback exposes missing product behavior, pricing uncertainty, integration need, or support workflow. Create `docs-feedback` plus `Feature` or `Improvement` when appropriate.
- **Security/confidentiality concern:** create `docs-feedback`, mark priority High or Urgent depending on exposure, and notify Vikas.
- **API/developer request:** create `docs-feedback`; keep the docs honest that no public API is live until a real API ships.

Each issue should include the page URL, exact quoted feedback when available, expected correction or decision, and whether the change is public urgent or normal priority.

## Release Notes

Update `CHANGELOG.md` for material content, navigation, process, or policy changes. Use short dated entries. Do not write diary entries; record what changed and why a reviewer would care.

## Rollback

Prefer a forward fix. If a published docs change must be reverted, revert the merge commit in GitHub, confirm the Mintlify deployment returns to a known-good state, and add a `CHANGELOG.md` entry explaining the rollback.

## Post-Publish Smoke

After a material merge, confirm these URLs return `200`:

- `https://docs.soc2doc.ai`
- `https://docs.soc2doc.ai/llms.txt`
- `https://docs.soc2doc.ai/sitemap.xml`
- `https://docs.soc2doc.ai/product/commitment-review`
- `https://docs.soc2doc.ai/product/confidentiality`
- `https://docs.soc2doc.ai/why/vs-vanta-drata-sprinto`
- `https://docs.soc2doc.ai/api/introduction`
