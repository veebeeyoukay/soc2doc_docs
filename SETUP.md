# Owner setup — connect this repo to Mintlify

The file scaffold, brand theme, and content are done and pushed. Two steps remain,
and only the owner can do them (they are dashboard actions, not code):

## 1. Connect Mintlify to this repo

1. Sign in / finish setup at <https://mintlify.com>.
2. Go to **Settings → GitHub App** (<https://mintlify.com/docs/settings/github>).
3. Install the **Mintlify GitHub App** and grant it access to **only** the
   `veebeeyoukay/soc2doc_docs` repo. Least privilege — do **not** grant all repos.
4. Set the **deploy branch to `main`**.
5. Wait for the first build. Confirm the Mintlify dashboard shows a green deploy and
   open the generated `*.mintlify.app` preview URL. It should render the navy/green,
   Inter-themed site with the soc2doc logo, the three tabs (Product, Why soc2doc,
   API Reference), and the **"Review my SOC 2 — free"** navbar button linking to
   `https://soc2doc.ai/review`.

<!-- Note: an admin API key path also exists (Mintlify admin key was added to Vercel
env by the owner). The standard docs-as-code flow above (GitHub App → auto-build on
push → CNAME) does NOT require that key. The key is only for optional Mintlify-API
automation. Keep it in the dashboard/Vercel env — never commit it here. -->

## 2. Custom domain (a later phase, listed here for completeness)

Point `docs.soc2doc.ai` at Mintlify:

- **CNAME** `docs` → `cname.mintlify.builders`
- Plus the two verification **TXT** records Mintlify shows in the dashboard.

This host CNAMEs to Mintlify's edge, **not** Vercel, so it does not route through the
app proxy and cannot regress the marketing site. (Wiring the domain + canonical is
tracked in the phase's later plan, 09-04.)

## Secrets

No Mintlify key or secret is committed to this repo, and none should be. Keys live in
the Mintlify dashboard (and the owner's Vercel env) only.
