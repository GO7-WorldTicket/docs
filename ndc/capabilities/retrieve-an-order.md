---
layout: go7
title: Retrieve an order
---

# Retrieve an order

**Definition.** Read the current state of an order: itinerary, passengers, services, payments and ticket numbers.

**Preconditions.** An `OrderID`, or a booking reference with a traveller name.

**Process.** `OrderRetrieve`

**Post condition.**
- *Success:* the current order view, including the current `PaxID` values.
- *Failure:* 404 when the order or the reference and name combination does not match.

**Messages.** [Order Retrieve](../endpoints/orderretrieve.md) — [by order ID](../endpoints/orderretrieve.md#orderretrieve-by-order-id), [by booking reference](../endpoints/orderretrieve.md#orderretrieve-by-booking-reference).

**Notes.** This is not only a read. It is how you refresh `PaxID` values, which change across order modifications. Call it before every step that follows an `OrderChange`.

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
