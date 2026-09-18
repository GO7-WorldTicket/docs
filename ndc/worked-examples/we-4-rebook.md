---
layout: go7
title: WE-4 Rebook
---

# WE-4 Rebook

`Phase 1` · Postman: `UseCase/Manage booking - Rebook`

**Capabilities.** [Rebook an order](../capabilities/rebook-an-order.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An existing order.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | `PaxID`, `OrderItemRefID` |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-rebook) | `OrderID` and the new travel date or flights | Rebook offers with the fare difference | `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderQuote](../endpoints/orderquote.md#orderquote-rebook) | `ExistingOrder` and the selected rebook offer | Quoted amount | Quoted offer references |
| 4 | [OrderChange](../endpoints/orderchange.md#orderchange-rebook) | Accepted quoted offer and `PaymentFunctions` | Rebooked order | `OrderID` |
| 5 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | New itinerary and tickets | — |

**Outcome.** The order carries the new flights and the fare difference is settled.

**Watch out for.** Rebook offers expire. If step 4 fails because the offer is stale, repeat from step 2.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
