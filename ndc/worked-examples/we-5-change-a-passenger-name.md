---
layout: go7
title: WE-5 Change a passenger name
---

# WE-5 Change a passenger name

Postman: `UseCase/Manage booking - NameChange`

**Capabilities.** [Change a passenger name](../capabilities/change-a-passenger-name.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderChange` (with payment) → `OrderRetrieve`

**Preconditions.** An existing order. Each passenger whose name changes needs its own `OrderReshop` request.

**Availability.** SMS only (not yet on AeroCRS).

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID`, `OwnerCode` | Current order | **`PaxID` per passenger** |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-name-change) | `OrderRefID` and `UpdatePaxName` with `GivenName`, `Surname`, `TitleName`, `PaxRefID` | Name-change offer | `OfferRefID`, `OfferItemRefID`, amount, currency |
| 3 | [OrderChange](../endpoints/orderchange.md) | `OrderID`, the accepted `OrderReshop` offer **and** `PaymentFunctions` for the offer amount | Order with the new name, fee settled | `OrderID` |
| 4 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Order showing the new names | — |

There is no `OrderQuote` in this flow, and `OrderChange` is called **once** — it accepts the `OrderReshop` offer and pays for it in the same request.

**Outcome.** The order shows the new passenger names and any name-change fee is settled.

**Watch out for.**
- `PaxRefID` in step 2 must come from the step 1 response, not from the original `OrderCreate`.
- Change an adult and an infant with separate step 2 requests; do not combine them.
- Do not send a second, payment-only `OrderChange`; payment belongs on step 3.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
