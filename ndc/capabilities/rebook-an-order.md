---
layout: go7
title: Rebook an order
---

# Rebook an order

**Definition.** Move passengers to different flights or dates on an existing order, and settle any difference in fare.

**Preconditions.** An existing order and current `PaxID` values.

**Process.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Post condition.**
- *Success:* the order carries the new flights, and the fare difference is settled.
- *Failure:* no rebook offer is available for the requested change, or the quoted offer expired before acceptance.

**Messages.** [Order Reshop → Rebook](../endpoints/orderreshop.md#orderreshop-rebook), [Order Quote → Rebook quote](../endpoints/orderquote.md#orderquote-rebook), [Order Change → Rebook with new offers](../endpoints/orderchange.md#orderchange-rebook).

**Availability.** Both PSS.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
