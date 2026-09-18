---
layout: go7
title: WE-6 Cancel a whole booking
---

# WE-6 Cancel a whole booking

`Phase 1` · Postman: `UseCase/Manage booking - Cancel/Cancel Booking`

**Capabilities.** [Cancel a whole booking](../capabilities/cancel-a-whole-booking.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An existing order that the fare permits cancelling.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | `PaxID`, `OrderItemRefID` |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-cancel-order) | `OrderID` and the cancel request | Cancel offer | `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderQuote](../endpoints/orderquote.md#orderquote-cancel) | `ExistingOrder` and the selected cancel offer | Quoted cancellation result | Quoted offer references |
| 4 | [OrderChange](../endpoints/orderchange.md) | The accepted cancel offer | Cancelled order | `OrderID` |
| 5 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Cancelled order view | — |

**Outcome.** Every flight on the order is cancelled.

**Watch out for.** Step 3 is skipped where the airline does not support refunds on that order — go straight from step 2 to step 4.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
