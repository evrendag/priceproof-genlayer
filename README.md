# PRICEPROOF
PRICEPROOF verifies a precisely scoped retail offer against 1–3 live official merchant pages and issues an on-chain Price Claim Receipt.

The contract stores product, currency, current/reference prices, deterministic discount basis points, audience conditions and evidence URLs. During audit, every validator independently refetches the same pages. Verdict, primary gap, evidence quality, currency and observed prices must match exactly; scores may differ by at most 10 inside the same band. Cross-field rules prevent a VERIFIED result unless every material fact matches. Missing or conflicting evidence fails closed.

Lifecycle: create claim → consensus audit → ACTIVE, QUALIFIED, REJECTED or MANUAL_REVIEW → third-party challenge → superseding receipt. Prior receipts remain readable.

Files: `contract.py`, `tests/test_priceproof.py`, `app/page.tsx`, `ARCHITECTURE.md`, `SUBMISSION.md`.

The frontend targets GenLayer Studio Next (chain ID `61997`) through the `studionet` chain definition and defaults to the deployed contract `0x89f972F5E8D015E4fFDF49739cC6da3fB8b9D578`. Set `NEXT_PUBLIC_CONTRACT_ADDRESS` to override it for another deployment.

Reproducible setup:

```bash
pnpm install
pnpm dev
pnpm build
```

Run contract tests with `pytest -q`; run the app with `pnpm dev`. This protocol adjudicates a specific advertised claim; it is not a generic price feed.
