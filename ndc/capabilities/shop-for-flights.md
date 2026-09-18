---
layout: go7
title: Shop for flights
---

# Shop for flights

`Phase 1`

**Definition.** Search live flight offers for a journey and a passenger mix. You send the journey, the platform returns priced offers from every airline your API key is entitled to search.

**Preconditions.** A valid API key, tenant and sales channel.

**Process.** `AirShopping`

**Post condition.**
- *Success:* a list of offers, each with an `OfferID`, its `OfferItemID` values and an `OwnerCode`.
- *Failure:* a validation error. No offer matching your criteria returns an empty offer list, not an error.

**Messages.** [Air Shopping](../endpoints/airshopping.md) — [one-way](../endpoints/airshopping.md#airshopping-one-way-trip), [round trip](../endpoints/airshopping.md#airshopping-round-trip).

**Notes.** Passenger types are `ADT`, `CHD`, `INF`. If you send a cabin filter, `PrefLevel/PrefLevelCode` is mandatory — see [Rules that apply to every flow](../NDC_PARTNER_GUIDE.md#rules-that-apply-to-every-flow).

**Availability.** Both PSS. See [Availability by PSS](../NDC_PARTNER_GUIDE.md#availability-by-pss).

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
