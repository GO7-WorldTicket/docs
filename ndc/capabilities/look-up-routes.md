---
layout: go7
title: Look up routes
---

# Look up routes

**Definition.** List the routes an airline serves — the origin and destination airport pairs you can shop for. Use it to fill origin and destination pickers, or to check that a pair is served before you search for flights.

**Preconditions.** A valid API key, tenant and sales channel.

**Process.** `Routes` (GO7 extension of NDC 21.3, not part of the IATA standard).

**Post condition.**
- *Success:* one `OriginDest` per origin and destination airport pair, optionally filtered by the airlines, origin and destination you sent.
- *Failure:* a validation error for a missing `DistributionChain` or an invalid airline or airport code. No route matching your filters returns an empty `DataLists`, not an error.

**Messages.** [Routes](../endpoints/routes.md) — [all routes](../endpoints/routes.md#routes-all), [by carrier](../endpoints/routes.md#routes-by-carrier), [from an origin](../endpoints/routes.md#routes-from-origin), [by carrier and airports](../endpoints/routes.md#routes-by-carrier-and-airports).

**Notes.** Every filter is optional. Send `CarrierCriteria` with the airline codes you want; without it no carrier filter is applied. `OriginCode` and `DestCode` are airport codes. Only routes sold in your `x-SalesChannel` are returned. A route is an airport pair, not a flight — use [Shop for flights](shop-for-flights.md) for dates, flights and prices.

**Availability.** Routes are read from the GO7 route catalogue, so the message is the same on every PSS; the routes returned are the ones loaded for the airline.

---

[All capabilities](../NDC_PARTNER_GUIDE.md#capabilities) · [NDC Partner Guide](../NDC_PARTNER_GUIDE.md)
