---
layout: go7
title: Change a passenger name
---

# Change a passenger name

**Definition.** Correct or change a passenger's name on an existing order. The airline returns the change as an offer, which is quoted and may carry a fee.

**Preconditions.** An existing order, and the current `PaxID` values read from `OrderRetrieve`. Each passenger whose name changes needs its own reshop request.

**Process.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` (with or without payment) → `OrderChange` (payment, only if the previous step was pay later) → `OrderRetrieve`

**Post condition.**
- *Success:* the order shows the new names, and any name-change fee is settled.
- *Failure:* the airline does not allow a name change on that order or fare, or the quoted offer expired.

**Messages.** [Order Reshop → Name change offer](../endpoints/orderreshop.md#orderreshop-name-change), [Order Quote](../endpoints/orderquote.md), [Order Change](../endpoints/orderchange.md).

**Request shape.** The change is carried on `OrderReshop` as `UpdateOrder/ReshopOrder/ReshopOrderChoice/UpdatePaxName`, with `GivenName`, `Surname`, `TitleName` and the `PaxRefID` of the passenger being changed. Change an adult and an infant with **separate** reshop requests.

**Paying the fee.** You can settle the name-change fee in the same `OrderChange` that accepts the quoted offer, or accept it first and pay in a following `OrderChange`.

**Availability.** Not available on every PSS — see [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
