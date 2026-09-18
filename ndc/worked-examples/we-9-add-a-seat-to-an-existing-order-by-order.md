---
layout: go7
title: WE-9 Add a seat to an existing order by order
---

# WE-9 Add a seat to an existing order by order

Postman: `UseCase/Ancillary Order - Seats`

**Capabilities.** [Shop for seats](../capabilities/shop-for-seats.md), [Add seats or services to an existing order](../capabilities/add-seats-or-services-to-an-existing-order.md)

**Sequence.** create the order, then `SeatAvailability` (order context) → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Preconditions.** An existing order — create it with [WE-1](./we-1-create-and-confirm-an-on-hold-booking.md) or [WE-2](./we-2-create-a-paid-booking.md).

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Current order | `PaxID`, `OrderItemRefID` |
| 2 | [SeatAvailability by order](../endpoints/seatavailability.md#seatavailability-by-order) | `OrderID` and the flight to seat | Seat map with seat offer items | Seat `OfferRefID`, `OfferItemRefID` |
| 3 | [OrderQuote](../endpoints/orderquote.md) | `ExistingOrder` and the selected seat offer item | Quoted seat price | Quoted offer references |
| 4 | [OrderChange](../endpoints/orderchange.md) | The accepted quoted offer and `PaymentFunctions` | Order with the seat attached and paid | `OrderID` |
| 5 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Order showing the seat | — |

**Outcome.** The seat is attached to the order and paid.

**Watch out for.** A seat taken between steps 2 and 4 returns error 486 — re-read the seat map and pick another.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
