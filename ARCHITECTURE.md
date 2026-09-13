# Architecture
`PriceClaim` freezes the merchant domain, product, currency, displayed prices, contract-computed discount, audience scope and official URLs. `audit_claim` retrieves those URLs inside each validator and emits a structured `PriceReceipt`.

Exact-consensus fields: verdict, primary gap, evidence grade, observed prices and currency. Tolerant field: score (±10, same band). The receipt becomes ACTIVE, QUALIFIED, REJECTED or MANUAL_REVIEW. Challenges require a different wallet and create a new version; the previous receipt becomes SUPERSEDED.

Security: HTTPS-only same-merchant sources, private-network blocking, bounded content, closed enums, untrusted-evidence prompt boundary and deterministic verdict invariants.
