---
layout: go7
title: WE-1 Create and confirm an on-hold booking
---

# WE-1 Create and confirm an on-hold booking

`Phase 1` · Postman: `UseCase/Create & confirm on-hold booking`

**Capabilities.** [Shop for flights](../capabilities/shop-for-flights.md), [Price an offer](../capabilities/price-an-offer.md), [Create an order without payment](../capabilities/create-an-order-without-payment.md), [Retrieve an order](../capabilities/retrieve-an-order.md), [Pay an on-hold order](../capabilities/pay-an-on-hold-order.md)

**Sequence.** `AirShopping` → `OfferPrice` → `OrderCreate` (no payment) → `OrderRetrieve` → `OrderQuote` → `OrderChange` → `OrderRetrieve`

**Preconditions.** API key issued; tenant and sales channel known.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [AirShopping](../endpoints/airshopping.md#airshopping-one-way-trip) | Origin, destination, dates, passengers (`ADT` / `CHD` / `INF`), optional cabin | Offer list | `OfferID`, `OfferItemID`, `OwnerCode` |
| 2 | [OfferPrice](../endpoints/offerprice.md#offerprice-one-way-trip) | Selected `OfferID` and `OfferItemID` | Priced offer with final amount and currency | Priced `OfferID` |
| 3 | [OrderCreate](../endpoints/ordercreate.md#ordercreate-pay-later) | Priced `OfferID`, passenger list, contact email and phone | `OrderID`, booking reference, order held | `OrderID` |
| 4 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID`, `OwnerCode` | Current order view | `PaxID` values, amount due |
| 5 | [OrderQuote](../endpoints/orderquote.md#orderquote-booking) | `ExistingOrder` with `OrderID` | Amount to settle | Quoted `OfferRefID`, `OfferItemRefID` |
| 6 | [OrderChange](../endpoints/orderchange.md#orderchange-payment-on-hold) | `OrderID`, accepted quote, `PaymentFunctions` | Confirmed order | `OrderID` |
| 7 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Final order with ticket numbers | — |

**Outcome.** A confirmed, paid and ticketed order.

**Watch out for.** Step 4 is not optional — the `PaxID` values it returns are the ones step 6 must use. Do not reuse `PaxID` values from the step 3 response.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
