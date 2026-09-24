---
layout: go7
title: Cancel a segment
---

# Cancel a segment

**Definition.** Cancel part of an order, leaving the remaining flights intact.

**Preconditions.** An existing order with more than one flight, and the `OrderItemRefID` of the part to remove, read from `OrderRetrieve`.

**Process.** `OrderRetrieve` → `OrderReshop` → `OrderChange` → `OrderRetrieve`

**Post condition.**
- *Success:* the selected segment is removed and the rest of the order is untouched.
- *Failure:* the fare does not permit partial cancellation.

**Messages.** [Order Reshop → Cancel order](../endpoints/orderreshop.md#orderreshop-cancel-order), [Order Change](../endpoints/orderchange.md).

**Notes.** Unlike a whole-booking cancellation, the segment cancel selects the `OrderItemRefID` to remove on the reshop request. Neither cancellation goes through `OrderQuote`.

**Availability.** Not available on every PSS — see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
