---
layout: go7
title: WE-7 Cancel a segment
---

# WE-7 Cancel a segment

`Phase 1` · Postman: `UseCase/Manage booking - Cancel/Cancel Segment`

**Capabilities.** [Cancel a segment](../capabilities/cancel-a-segment.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An order with more than one flight.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | **`OrderItemRefID` of the part to remove** |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-cancel-order) | `OrderID` and the `OrderItemRefID` to cancel | Cancel offer for that item | `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderChange](../endpoints/orderchange.md) | The accepted cancel offer | Order with the segment removed | `OrderID` |
| 4 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Remaining itinerary | — |

**Outcome.** The selected segment is removed and the rest of the order is untouched.

**Watch out for.** This flow has no quote step. Selecting the right `OrderItemRefID` in step 2 is what limits the cancellation to one part of the order.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
