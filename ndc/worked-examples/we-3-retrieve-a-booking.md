---
layout: go7
title: WE-3 Retrieve a booking
---

# WE-3 Retrieve a booking

`Phase 1` · Postman: `UseCase/Retrieve booking`

**Capabilities.** [Retrieve an order](../capabilities/retrieve-an-order.md)

**Sequence.** `OrderRetrieve`

**Preconditions.** An `OrderID`, or a booking reference and a traveller name.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1a | [OrderRetrieve by order ID](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID`, `OwnerCode` | Full order view | `PaxID`, `OrderItemRefID` |
| 1b | [OrderRetrieve by booking reference](../endpoints/orderretrieve.md#orderretrieve-by-booking-reference) | Booking reference and traveller name | Full order view | `OrderID`, `PaxID` |

**Outcome.** The current itinerary, passengers, services, payments and ticket numbers.

**Watch out for.** Use this message before every step that follows an `OrderChange`, and read the `PaxID` values from its response.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
