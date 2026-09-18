---
layout: go7
title: Create an order with payment
---

# Create an order with payment

`Phase 1`

**Definition.** Create and pay for an order in one message, so the booking is confirmed and ticketed immediately.

**Preconditions.** A priced offer from `OfferPrice`, complete passenger data, and a payment method.

**Process.** `OrderCreate` with `PaymentFunctions`

**Post condition.**
- *Success:* the order is created, paid and ticketed. E-ticket numbers appear on the order once ticketing completes.
- *Failure:* payment declined or offer expired.

**Messages.** [Order Create → Instant pay](../endpoints/ordercreate.md#ordercreate-instant-pay), [combined offer](../endpoints/ordercreate.md#ordercreate-combined-offer).

**Notes.** This is the only way to buy seats or services **before** the order exists. That by-offer path is instant pay only — to hold a booking and add extras later, create the order without payment and use the by-order path.

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
