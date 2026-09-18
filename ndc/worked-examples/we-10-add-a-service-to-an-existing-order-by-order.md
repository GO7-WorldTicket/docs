---
layout: go7
title: WE-10 Add a service to an existing order by order
---

# WE-10 Add a service to an existing order by order

Postman: `UseCase/Ancillary Order - Services`

**Capabilities.** [Shop for ancillary services](../capabilities/shop-for-ancillary-services.md), [Add seats or services to an existing order](../capabilities/add-seats-or-services-to-an-existing-order.md)

**Sequence.** create the order, then `ServiceList` (order context) → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An existing order — create it with [WE-1](./we-1-create-and-confirm-an-on-hold-booking.md) or [WE-2](./we-2-create-a-paid-booking.md).

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | `PaxID`, `OrderItemRefID` |
| 2 | [ServiceList by order](../endpoints/servicelist.md#servicelist-by-order) | `OrderID`, optionally narrowed to one order item | Service offers with prices | Service `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderQuote](../endpoints/orderquote.md) | `ExistingOrder` and the selected service offer item | Quoted service price | Quoted offer references |
| 4 | [OrderChange](../endpoints/orderchange.md) | The accepted quoted offer and `PaymentFunctions` | Order with the service attached and paid | `OrderID` |
| 5 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Order showing the service | — |

**Outcome.** The service is attached to the order and paid.

**Watch out for.** Zero-price services still follow all five steps. Do not skip the quote because the amount is zero.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
