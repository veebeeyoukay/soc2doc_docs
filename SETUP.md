# Mintlify Setup

The file scaffold, brand theme, content, GitHub App connection, and custom domain
are complete. `https://docs.soc2doc.ai` is live and serves this repo through
Mintlify.

## Mintlify GitHub App

The GitHub App should stay scoped to **only** `veebeeyoukay/soc2doc_docs`, with
deploy branch `main`. Pull requests receive Mintlify previews; merges to `main`
publish production.

An admin API key path also exists for optional automation. It is not required for
the standard docs-as-code flow. Keep keys in the Mintlify dashboard or approved
environment storage; never commit them here.

## Custom Domain

`docs.soc2doc.ai` points at Mintlify:

- **CNAME** `docs` -> `cname.mintlify.builders`
- Mintlify verification **TXT** records live in DNS.

This host CNAMEs to Mintlify's edge, not Vercel, so it does not route through the
app proxy and cannot regress the marketing site.

## Operating Process

See [`OPERATIONS.md`](./OPERATIONS.md) for PR rules, required checks, urgent
corrections, rollback, feedback routing, and post-publish smoke checks.

## Secrets

No Mintlify key or secret is committed to this repo, and none should be. Keys live
in the Mintlify dashboard or approved environment storage only.
