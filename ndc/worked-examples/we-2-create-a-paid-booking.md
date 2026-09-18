---
layout: go7
title: WE-2 Create a paid booking
---

# WE-2 Create a paid booking

`Phase 1` · Postman: `UseCase/Create paid booking`

**Capabilities.** [Shop for flights](../capabilities/shop-for-flights.md), [Price an offer](../capabilities/price-an-offer.md), [Create an order with payment](../capabilities/create-an-order-with-payment.md)

**Sequence.** `AirShopping` → `OfferPrice` → `OrderCreate` (with payment) → `OrderRetrieve`

**Preconditions.** API key issued; a payment method available.

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [AirShopping](../endpoints/airshopping.md#airshopping-round-trip) | Journey and passengers | Offer list | `OfferID`, `OfferItemID` |
| 2 | [OfferPrice](../endpoints/offerprice.md#offerprice-round-trip) | Selected offer | Priced offer | Priced `OfferID`, amount, currency |
| 3 | [OrderCreate](../endpoints/ordercreate.md#ordercreate-instant-pay) | Priced `OfferID`, passenger list, `PaymentFunctions` | Paid order with `OrderID` and booking reference | `OrderID` |
| 4 | [OrderRetrieve](../endpoints/orderretrieve.md#orderretrieve-by-order-id) | `OrderID` | Order with ticket numbers | — |

**Outcome.** A paid and ticketed order in one round trip.

**Watch out for.** The payment amount and currency must match the priced offer from step 2 exactly.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
