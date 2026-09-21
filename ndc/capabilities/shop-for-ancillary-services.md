---
layout: go7
title: Shop for ancillary services
---

# Shop for ancillary services

**Definition.** List the ancillary services (bags, meals and other SSRs) available either for an offer you have not yet ordered, or for an order that already exists.

**Preconditions.** *By offer:* an `OfferID` from `AirShopping`. *By order:* an existing `OrderID`.

**Process.** `ServiceList`

**Post condition.**
- *Success:* service offers with their `OfferItemRefID` values and prices.
- *Failure:* no services configured for the flight returns an empty list.

**Messages.** [Service List](../endpoints/servicelist.md) — [by offer](../endpoints/servicelist.md#servicelist-by-offer), [by order](../endpoints/servicelist.md#servicelist-by-order).

**Notes.** Zero-price services are returned as normal offers with an amount of zero, and still follow the full add-and-confirm sequence.

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
