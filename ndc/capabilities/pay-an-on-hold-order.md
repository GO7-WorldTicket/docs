---
layout: go7
title: Pay an on-hold order
---

# Pay an on-hold order

`Phase 1`

**Definition.** Settle a held order so it is confirmed and ticketed.

**Preconditions.** An existing held order, and the current `PaxID` values read from `OrderRetrieve`.

**Process.** `OrderRetrieve` → `OrderQuote` → `OrderChange`

**Post condition.**
- *Success:* the order is confirmed and ticketed.
- *Failure:* payment declined, or the hold expired before payment.

**Messages.** [Order Quote → Booking](../endpoints/orderquote.md#orderquote-booking), [Order Change → Payment on hold booking](../endpoints/orderchange.md#orderchange-payment-on-hold).

**Payment methods.** [Cash](../endpoints/orderchange.md#orderchange-payment-on-hold), [debit](../endpoints/orderchange.md#orderchange-payment-debit), [credit](../endpoints/orderchange.md#orderchange-payment-credit), [debit or credit account](../endpoints/orderchange.md#orderchange-payment-debit-credit-account), and [credit card via PCI Proxy](../endpoints/orderchange.md#orderchange-payment-credit-card) — the card path **requires a 3DS authenticate result** (`SecurePaymentVersion2`).

**Availability.** Cash and zero-amount payments on both PSS. Reuse of a payment captured in your own payment service provider is available on one PSS only — see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
