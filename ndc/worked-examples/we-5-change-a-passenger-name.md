---
layout: go7
title: WE-5 Change a passenger name
---

# WE-5 Change a passenger name

Postman: `UseCase/Manage booking - NameChange`

**Capabilities.** [Change a passenger name](../capabilities/change-a-passenger-name.md)

**Sequence.** `OrderRetrieve` → `OrderReshop` → `OrderQuote` → `OrderChange` → `OrderChange` (payment, conditional) → `OrderRetrieve`

**Preconditions.** An existing order. Each passenger whose name changes needs its own `OrderReshop` request.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID`, `OwnerCode` | Current order | **`PaxID` per passenger** |
| 2 | [OrderReshop](../endpoints/orderreshop.md#orderreshop-name-change) | `OrderRefID` and `UpdatePaxName` with `GivenName`, `Surname`, `TitleName`, `PaxRefID` | Name-change offer | `OfferRefID`, `OfferItemRefID`, amount, currency |
| 3 | [OrderQuote](../endpoints/orderquote.md) | `ExistingOrder` and the selected offer item, with quantity | Quoted name-change price | Quoted offer references |
| 4a | [OrderChange](../endpoints/orderchange.md) — pay later | `OrderID` and the accepted quoted offer, **no** `PaymentFunctions` | Order with the new name, fee outstanding | `OrderID` |
| 4b | [OrderChange](../endpoints/orderchange.md) — pay now | The same, **plus** `PaymentFunctions` | Order with the new name, fee settled | `OrderID` |
| 5 | [OrderChange](../endpoints/orderchange.md#orderchange-payment-on-hold) | `OrderID` and `PaymentFunctions` | Fee settled | `OrderID` |
| 6 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Order showing the new names | — |

Steps 4a and 4b are alternatives. **Step 5 runs only when you chose 4a.**

**Outcome.** The order shows the new passenger names and any name-change fee is settled.

**Watch out for.**
- `PaxRefID` in step 2 must come from the step 1 response, not from the original `OrderCreate`.
- Change an adult and an infant with separate step 2 requests; do not combine them.
- Call `OrderRetrieve` again between steps 4a and 5 if you chose the pay-later route, so step 5 uses current identifiers.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
