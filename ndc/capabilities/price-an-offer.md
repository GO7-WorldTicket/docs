---
layout: go7
title: Price an offer
---

# Price an offer

`Phase 1`

**Definition.** Confirm the final price and conditions of a selected offer before you create an order. This is also the message that builds a **combined offer** when you add a seat or a service before payment.

**Preconditions.** An `OfferID` and `OfferItemID` from `AirShopping`. For a combined offer, also the seat or service offer items you selected.

**Process.** `OfferPrice`

**Post condition.**
- *Success:* a priced offer with final amounts and currency, ready for `OrderCreate`.
- *Failure:* the offer expired or is no longer available — shop again.

**Messages.** [Offer Price](../endpoints/offerprice.md) — [one-way](../endpoints/offerprice.md#offerprice-one-way-trip), [round trip](../endpoints/offerprice.md#offerprice-round-trip), [with service](../endpoints/offerprice.md#offerprice-with-service), [with seat](../endpoints/offerprice.md#offerprice-with-seat), [with service and seat](../endpoints/offerprice.md#offerprice-with-service-and-seat).

**Notes.** When the flight was priced together with a seat or a service, echo the resulting composite offer into `OrderCreate` — see [OfferRefID shapes](../endpoints/ordercreate.md#ordercreate-combined-offer) for the single-offer and multiple-offer request forms.

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
