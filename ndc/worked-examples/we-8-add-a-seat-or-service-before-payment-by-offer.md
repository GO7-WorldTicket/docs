---
layout: go7
title: WE-8 Add a seat or service before payment by offer
---

# WE-8 Add a seat or service before payment by offer

Postman: `UseCase/Ancillary Offer - Seats`, `UseCase/Ancillary Offer - Services`

**Capabilities.** [Shop for seats](../capabilities/shop-for-seats.md), [Shop for ancillary services](../capabilities/shop-for-ancillary-services.md), [Price an offer](../capabilities/price-an-offer.md), [Create an order with payment](../capabilities/create-an-order-with-payment.md)

**Sequence.** `AirShopping` → `SeatAvailability` and/or `ServiceList` → `OfferPrice` → `OrderCreate` (with payment)

**Preconditions.** None beyond a valid API key. **This path is instant pay.** To hold a booking and add extras afterwards, use [WE-1](./we-1-create-and-confirm-an-on-hold-booking.md) followed by [WE-9](./we-9-add-a-seat-to-an-existing-order-by-order.md) or [WE-10](./we-10-add-a-service-to-an-existing-order-by-order.md).

| Step | Message | Send | Get back | Carry forward |
|---|---|---|---|---|
| 1 | [AirShopping](../endpoints/airshopping.md#airshopping-one-way-trip) | Journey and passengers | Offer list | `OfferID`, `OfferItemID` |
| 2a | [SeatAvailability by offer](../endpoints/seatavailability.md#seatavailability-by-offer) | The `OfferID` from step 1 | Seat map with seat offer items | Seat `OfferItemRefID` |
| 2b | [ServiceList by offer](../endpoints/servicelist.md#servicelist-by-offer) | The `OfferID` from step 1 | Service offers | Service `OfferItemRefID` |
| 3 | [OfferPrice with seat and service](../endpoints/offerprice.md#offerprice-with-service-and-seat) | The flight offer plus the selected seat and service items | One combined priced offer | Combined `OfferID`, total amount |
| 4 | [OrderCreate combined offer](../endpoints/ordercreate.md#ordercreate-combined-offer) | The combined `OfferID`, passenger list, `PaymentFunctions` | Paid order including the seat and service | `OrderID` |

You can run step 2a alone, step 2b alone, or both. Price only what you selected: [with seat](../endpoints/offerprice.md#offerprice-with-seat), [with service](../endpoints/offerprice.md#offerprice-with-service), or [with both](../endpoints/offerprice.md#offerprice-with-service-and-seat).

**Outcome.** A paid order that already carries the seat and the service.

**Watch out for.** A seat can return several `OfferItemRefID` values. Pick the one belonging to the passenger you are seating, or the combined pricing in step 3 will not match.

---

[All worked examples](../NDC_PARTNER_GUIDE.md#worked-examples) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
