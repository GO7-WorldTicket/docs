---
layout: go7
title: Shop for seats
---

# Shop for seats

`Phase 2`

**Definition.** Retrieve the seat map and seat prices, either for an offer you have not yet ordered or for an existing order.

**Preconditions.** *By offer:* an `OfferID` from `AirShopping`. *By order:* an existing `OrderID`.

**Process.** `SeatAvailability`

**Post condition.**
- *Success:* a seat map with per-seat offer items and prices.
- *Failure:* a requested seat that is no longer free returns error 486 when you try to take it.

**Messages.** [Seat Availability](../endpoints/seatavailability.md) — [by offer](../endpoints/seatavailability.md#seatavailability-by-offer), [by order](../endpoints/seatavailability.md#seatavailability-by-order).

**Notes.** A single seat may return **several** `OfferItemRefID` values, for example one per eligible passenger. Pick the one that matches the passenger you are seating.

**Availability.** By offer on both PSS. By order, see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
