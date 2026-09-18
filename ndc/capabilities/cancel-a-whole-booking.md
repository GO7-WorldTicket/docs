---
layout: go7
title: Cancel a whole booking
---

# Cancel a whole booking

**Definition.** Cancel every flight on an order and settle the result.

**Preconditions.** An existing order and current `PaxID` values.

**Process.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Post condition.**
- *Success:* the order is cancelled.
- *Failure:* the fare does not permit cancellation, or the order is already cancelled.

**Messages.** [Order Reshop → Cancel order](../endpoints/orderreshop.md#orderreshop-cancel-order), [Order Quote → Cancel quote](../endpoints/orderquote.md#orderquote-cancel), [Order Change](../endpoints/orderchange.md).

**Notes.** `OrderQuote` is skipped where the airline does not support refunds on that order. In that case go straight from `OrderReshop` to `OrderChange`.

**Availability.** Not available on every PSS — see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
