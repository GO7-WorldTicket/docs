---
layout: go7
title: Add seats or services to an existing order
---

# Add seats or services to an existing order

**Definition.** Add a seat or an ancillary service to an order that already exists, and pay for it.

**Preconditions.** An existing order, and the current `PaxID` values read from `OrderRetrieve`.

**Process.** `SeatAvailability` or `ServiceList` (order context) → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Post condition.**
- *Success:* the seat or service is attached to the order and paid.
- *Failure:* the seat was taken in the meantime (error 486), or the selected offer item no longer applies to that passenger.

**Messages.** [Seat Availability → by order](../endpoints/seatavailability.md#seatavailability-by-order), [Service List → by order](../endpoints/servicelist.md#servicelist-by-order), [Order Quote](../endpoints/orderquote.md), [Order Change](../endpoints/orderchange.md).

**Notes.** Refresh `PaxID` with `OrderRetrieve` before every step in this sequence.

**Availability.** Services on both PSS. Seats by order, see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
