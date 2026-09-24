---
layout: go7
title: WE-6 Cancel a whole booking
---

# WE-6 Cancel a whole booking

Postman: `UseCase/Manage booking - Cancel/Cancel Booking`

**Capabilities.** [Cancel a whole booking](../capabilities/cancel-a-whole-booking.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An existing order that the fare permits cancelling.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | `PaxID`, `OrderItemRefID` |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-cancel-order) | `OrderID` and the cancel request | Cancel offer | `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderChange](../endpoints/orderchange.md) | `OrderID` and the cancel offer from step 2 (`OfferRefID`, `OfferItemRefID`) | Cancelled order | `OrderID` |
| 4 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Cancelled order view | — |

**Outcome.** Every flight on the order is cancelled.

**Watch out for.** This flow has no quote step — carry the step 2 offer references straight into step 3.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
