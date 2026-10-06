---
layout: go7
title: Get airline profile
---

# Get airline profile

**Definition.** Get the airline profile of one or more airlines: the origin and destination airport pairs each airline serves. Use it to fill origin and destination pickers, or to check that a pair is served before you search for flights.

**Preconditions.** A valid API key, tenant and sales channel.

**Process.** `AirlineProfile`

**Post condition.**
- *Success:* one `AirlineProfile` per airline (`ProfileOwner`), with one `AirlineProfileDataItem` per origin and destination airport pair. An airline you asked for that has no route is returned without data items.
- *Failure:* a validation error for a missing `DistributionChain` or an invalid airline code; error 913 when no route is found and no airline was requested.

**Messages.** [Airline Profile](../endpoints/airlineprofile.md) — [all profiles](../endpoints/airlineprofile.md#airlineprofile-all), [by airline](../endpoints/airlineprofile.md#airlineprofile-by-owner), [several airlines](../endpoints/airlineprofile.md#airlineprofile-several-owners).

**Notes.** Select airlines with `AirlineProfileCriteria/OwnerCode`; `AllProfilesInd` = `true` returns every profile available to you. The message has no airport filter. Only routes sold in your `x-SalesChannel` are returned. A route is an airport pair, not a flight — use [Shop for flights](shop-for-flights.md) for dates, flights and prices.

**Availability.** Routes are read from the GO7 route catalogue, so the message is the same on every PSS; the routes returned are the ones loaded for the airline.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
